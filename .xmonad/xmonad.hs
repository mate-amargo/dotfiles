--                                       _
-- __  ___ __ ___   ___  _ __   __ _  __| |
-- \ \/ / '_ ` _ \ / _ \| '_ \ / _` |/ _` |
--  >  <| | | | | | (_) | | | | (_| | (_| |
-- /_/\_\_| |_| |_|\___/|_| |_|\__,_|\__,_|
--
-- Template at:
-- http://code.haskell.org/xmonad/man/xmonad.hs
--
-----------------------------------------------
-- Modules                                  {{{
-----------------------------------------------

import XMonad
import Data.Monoid
import System.Exit
import System.IO -- for zenity

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Graphics.X11.ExtraTypes.XF86 -- For media keys

import XMonad.Hooks.DynamicLog -- For xmobar
import XMonad.Hooks.ManageDocks -- avoidStruts
import XMonad.Hooks.ManageHelpers -- composeOne
import XMonad.Hooks.InsertPosition -- For opening always right of current
import XMonad.Hooks.UrgencyHook -- For urgent calls
import XMonad.Hooks.EwmhDesktops -- For fullscreen support Hook
import XMonad.Hooks.SetWMName -- Fix Matlab big gray square

import XMonad.Util.Cursor -- To get rid of the default X cursor
import XMonad.Util.ExclusiveScratchpads
import XMonad.ManageHook (title,appName)
--import XMonad.Util.NamedScratchpad -- As the title says
import XMonad.Util.NamedActions -- for Descriptive keys
--import XMonad.Util.EZConfig -- for Descriptive keys
import XMonad.Util.Run -- for runInTerm
import XMonad.Util.Ungrab -- for scrot -s
import XMonad.Util.SpawnOnce -- Spawns a commnad only once, nice for statusbar
import XMonad.Util.Font

import XMonad.Actions.CycleWS -- toggleWS switch to previous workspace
import XMonad.Actions.DynamicProjects
import XMonad.Actions.GridSelect -- Cool window selection
import XMonad.Actions.Navigation2D
--import XMonad.Actions.WindowNavigation
import XMonad.Actions.TagWindows
import XMonad.Actions.CopyWindow
import XMonad.Actions.Minimize

import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Prompt.Unicode

-- Import Layouts {{{

--import XMonad.Layout.Accordion
--import XMonad.Layout.AutoMaster
--import XMonad.Layout.AvoidFloats
--import XMonad.Layout.BinaryColumn
--import XMonad.Layout.BinarySpacePartition
--import XMonad.Layout.BorderResize
import XMonad.Layout.BoringWindows
--import XMonad.Layout.ButtonDecoration
--import XMonad.Layout.CenteredMaster
--import XMonad.Layout.Circle
--import XMonad.Layout.Column
import XMonad.Layout.Combo
--import XMonad.Layout.ComboP
--import XMonad.Layout.Cross
--import XMonad.Layout.Decoration
--import XMonad.Layout.DecorationAddons
--import XMonad.Layout.DecorationMadness
--import XMonad.Layout.Dishes
--import XMonad.Layout.DragPane
--import XMonad.Layout.DraggingVisualizer
--import XMonad.Layout.Drawer
--import XMonad.Layout.Dwindle
--import XMonad.Layout.DwmStyle
--import XMonad.Layout.FixedColumn
--import XMonad.Layout.Fullscreen
--import XMonad.Layout.Gaps
import XMonad.Layout.Grid
--import XMonad.Layout.GridVariants
--import XMonad.Layout.Groups
--import XMonad.Layout.Groups.Examples
--import XMonad.Layout.Groups.Helpers
--import XMonad.Layout.Groups.Wmii
--import XMonad.Layout.Hidden
--import XMonad.Layout.HintedGrid
--import XMonad.Layout.HintedTile
--import XMonad.Layout.IM
--import XMonad.Layout.IfMax
--import XMonad.Layout.ImageButtonDecoration
--import XMonad.Layout.IndependentScreens
--import XMonad.Layout.LayoutBuilder
--import XMonad.Layout.LayoutBuilderP
--import XMonad.Layout.LayoutCombinators
--import XMonad.Layout.LayoutHints
--import XMonad.Layout.LayoutModifier
--import XMonad.Layout.LayoutScreens
--import XMonad.Layout.LimitWindows
--import XMonad.Layout.MagicFocus
--import XMonad.Layout.Magnifier
--import XMonad.Layout.Master
import XMonad.Layout.Maximize
--import XMonad.Layout.MessageControl
import XMonad.Layout.Minimize
--import XMonad.Layout.Monitor
--import XMonad.Layout.Mosaic
--import XMonad.Layout.MosaicAlt
--import XMonad.Layout.MouseResizableTile
--import XMonad.Layout.MultiColumns
--import XMonad.Layout.MultiDishes
import XMonad.Layout.MultiToggle -- To toggle Full
import XMonad.Layout.MultiToggle.Instances -- MIRROR, NOBORDERS, FULL, etc
--import XMonad.Layout.MultiToggle.TabBarDecoration
import XMonad.Layout.Named -- Change default names of Layouts
import XMonad.Layout.NoBorders -- Remove decorations on fullscreen floats
--import XMonad.Layout.NoFrillsDecoration
--import XMonad.Layout.OnHost
--import XMonad.Layout.OneBig
--import XMonad.Layout.PerScreen
import XMonad.Layout.PerWorkspace -- Different Layout for each workspace
--import XMonad.Layout.PositionStoreFloat
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
--import XMonad.Layout.ResizableTile
--import XMonad.Layout.ResizeScreen
--import XMonad.Layout.Roledex
--import XMonad.Layout.ShowWName
--import XMonad.Layout.SimpleDecoration
--import XMonad.Layout.SimpleFloat
--import XMonad.Layout.Simplest
--import XMonad.Layout.SimplestFloat
--import XMonad.Layout.SortedLayout
import XMonad.Layout.Spacing
--import XMonad.Layout.Spiral
--import XMonad.Layout.Square
--import XMonad.Layout.StackTile
--import XMonad.Layout.StateFull
--import XMonad.Layout.Stoppable
--import XMonad.Layout.SubLayouts
--import XMonad.Layout.TabBarDecoration
import XMonad.Layout.Tabbed
--import XMonad.Layout.ThreeColumns
--import XMonad.Layout.ToggleLayouts
--import XMonad.Layout.TrackFloating
--import XMonad.Layout.TwoPane
--import XMonad.Layout.TwoPanePersistent
--import XMonad.Layout.WindowArranger
--import XMonad.Layout.WindowNavigation
--import XMonad.Layout.WindowSwitcherDecoration
--import XMonad.Layout.WorkspaceDir
--import XMonad.Layout.ZoomRow
--}}}

--------------------------------------------}}}
-- Theme                                    {{{
-----------------------------------------------

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
myTerminal      = "st"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth   = 1

-- Border colors for unfocused and focused windows, respectively.

myNormalBorderColor  = "#646464"
myFocusedBorderColor = "#FF4000"

promptTheme = def
    {
      font = "xft:CodeNewRoman:size=11:antialias=true"
    , bgColor               = "#646464"
    , fgColor               = "#FF4000"
    , promptBorderWidth     = 0
    , position              = Top
    }

--------------------------------------------}}}
-- Key bindings                             {{{
-----------------------------------------------

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask
showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
    h <- spawnPipe "zenity --text-info"
    hPutStr h (unlines $ showKm x)
    hClose h
    return ()
-------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
--myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
myKeys conf@(XConfig {XMonad.modMask = modm}) = (subtitle "Custom Keys":) $
  [
      ((modm, xK_Return), addName "Opens a terminal"     $ spawn $ XMonad.terminal conf)
    , ((modm, xK_r     ), addName "Opens dmenu launcher" $ spawn "dmenu_run")
    , ((modm, xK_w     ), addName "Grid Select"          $ goToSelected def)
    -- Media keys
    , ((0,   xF86XK_AudioPlay), addName "Toggle Music Player" $ spawn "mpc toggle")
    , ((0,   xF86XK_AudioPrev), addName "Previous Song" $ spawn "mpc prev")
    , ((0,   xF86XK_AudioNext), addName "Next Song" $ spawn "mpc next")
    , ((0,   xF86XK_AudioStop), addName "Stop Music Player" $ spawn "mpc stop")
    -- Volume
    , ((modm, xK_x     ), addName "Toggle Audio Output" $ spawn "ponymix toggle")
    , ((0, xF86XK_AudioLowerVolume), addName "Lower Volume by 5%" $ spawn "amixer -c 0 sset Master 5%-")
    , ((0, xF86XK_AudioRaiseVolume), addName "Raise Volume by 5%" $ spawn "amixer -c 0 sset Master 5%+")
    -- Brightness
    , ((0, xF86XK_MonBrightnessUp), addName "Increase Brightness" $ spawn "backlight +50")
    , ((0, xF86XK_MonBrightnessDown), addName "Decrease Brightness" $ spawn "backlight -50")
    -- Apps
    , ((modm, xK_i ), addName "Web Browser" $ spawn "google-chrome-stable")
    , ((modm, xK_m), addName "Music Player" $ runInTerm "-c NCMPCPP" "fish -c ncmpcpp")
    , ((modm .|. controlMask .|. shiftMask, xK_p), addName "Podcast Player" $ runInTerm "-t castero -c castero" "castero")
    , ((modm .|. shiftMask, xK_p), addName "Toggle podcast player" $ spawn "xdotool key --window $(xwininfo -name castero | sed -n '/id:/s/.*\\(0x[0-9a-f]*\\).*/\\1/p') p")
    , ((modm .|. controlMask, xK_m), addName "Update e-mail count" $ spawn "emilio")
    , ((modm, xK_o), addName "Document Viewer (PDF/Djvu)" $ spawn "zathura")
    , ((modm, xK_c), addName "Change wallpaper" $ spawn "wallchange")
    , ((modm .|. controlMask, xK_c), addName "Toggle compositors" $ spawn "~/.xmonad/toggle_comp.sh")
    , ((0, xK_Print), addName "Take screenshot of the focused window" $ spawn "scrot -u ~/images/screenshots/'%Y-%m-%d-%s_$wx$h.png' && notify-send -u low 'Screenshot of the focused window saved'")
    , ((shiftMask, xK_Print), addName "Take screenshot of the selected area" $ unGrab >> spawn "scrot -s '%Y-%m-%d-%s_$wx$h.png' -e 'mv $f ~/images/screenshots' && notify-send -u low 'Screenshot of the selected area saved'")
    , ((modm, xK_Print), addName "Take screenshot of the full screen" $ unGrab >> spawn "scrot ~/images/screenshots/'%Y-%m-%d-%s_$wx$h.png' && notify-send -u low 'Screenshot of the full screen saved'")
    , ((modm, xK_g), addName "Custom Game Launcher" $ spawn "games")
    , ((modm .|. shiftMask, xK_g), addName "Audio Visualizer on the Desktop" $ spawn "pkill glava || glava --audio=fifo")
    , ((modm .|. controlMask, xK_g), addName "Toggle gaps" $ sequence_ [toggleWindowSpacingEnabled, toggleScreenSpacingEnabled])
    , ((modm, xK_b), addName "Bookworm" $ spawn "bookworm")
    -- Recording
    , ((modm,       xK_F8     ), addName "Record Desktop" $ spawn "~/videos/youtube/record.fish")
    , ((modm,       xK_F9     ), addName "Toggle Desktop recording" $ spawn "~/videos/youtube/play-pause.fish")
    , ((modm,       xK_F10    ), addName "Stop Desktop recording" $ spawn "~/videos/youtube/stop.fish")
    , ((modm .|. shiftMask, xK_l), addName "Lock screen" $ spawn "xset s activate")
    -- Passwords
    , ((modm, xK_p ), addName "Password Manager autotype" $ spawn "passmenu --type")
    , ((modm .|. controlMask, xK_p ), addName "Password Manager clipboard" $ spawn "passmenu")
    -- Scratchpads
    , ((modm .|. shiftMask, xK_t), addName "Scratchpad terminal" $ scratchpadAction scratchpads "terminal")
    , ((modm .|. shiftMask, xK_h), addName "Scratchpad htop" $ scratchpadAction scratchpads "htop")
    , ((modm .|. shiftMask, xK_c), addName "Edit XMonad Config File in Scratchpad" $ scratchpadAction scratchpads "XMonadConfig")
    , ((modm .|. controlMask, xK_h), addName "Hide all Scratchpads" $ hideAll scratchpads)
    -- Projects
    , ((modm, xK_slash), addName "Switch or Create Project" $ switchProjectPrompt promptTheme)
    , ((modm .|. shiftMask, xK_slash), addName "Shift to Project" $ shiftToProjectPrompt promptTheme)
    -- Tags
    , ((modm,                 xK_apostrophe), addName "Tag window with default tag (tagged)" $ withFocused (addTag "tagged"))
    , ((modm .|. controlMask, xK_apostrophe), addName "Delete default tag from window" $ withFocused (delTag "tagged"))
    , ((modm .|. shiftMask,   xK_apostrophe), addName "Move tagged to current WS" $ withTaggedGlobalP "tagged" shiftHere)
    , ((modm,                 xK_semicolon ), addName "Add Tag Prompt" $ tagPrompt promptTheme (\s -> withFocused (addTag s)))
    , ((modm .|. controlMask, xK_semicolon ), addName "Delete Tag Prompt" $ tagDelPrompt promptTheme)
    , ((modm .|. shiftMask,   xK_semicolon ), addName "Move Tag Prompt" $ tagPrompt promptTheme (\s -> withTaggedGlobalP s shiftHere))
    , ((modm,               xK_minus ), addName "Minimize window" $ withFocused minimizeWindow)
    , ((modm .|. shiftMask, xK_minus ), addName "Maximize window" $ withLastMinimized maximizeWindowAndFocus)
    , ((modm .|. shiftMask, xK_q), addName "Close window" $ kill1)
    , ((modm, xK_v ), addName "Make focused window always visible" $ windows copyToAll)
    , ((modm .|. shiftMask, xK_v ), addName "Toggle window state back" $ killAllOtherCopies)
    , ((modm,               xK_space ), addName "Rotate through the available layout algorithms" $ sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), addName "Reset the layouts on the current WS to default" $ setLayout $ XMonad.layoutHook conf)
    -- Directional Window Navigation
    , ((modm, xK_h), addName "Move to the left window" $ windowGo L False)
    , ((modm, xK_j), addName "Move to the downward window" $ windowGo D False)
    , ((modm, xK_k), addName "Move to the upper window" $ windowGo U False)
    , ((modm, xK_l), addName "Move to the right window" $ windowGo R False)
    , ((modm, xK_Tab   ), addName "Toggle between previous WS" $ toggleWS)
    , ((modm, xK_grave   ), addName "Next WS" $ nextWS)
    , ((modm .|. shiftMask, xK_grave   ), addName "Previous WS" $ prevWS)
    , ((modm .|. shiftMask,   xK_j     ), addName "Move to the next window" $ focusDown)
    , ((modm .|. shiftMask,   xK_k     ),  addName "Move to the previous window" $ focusUp  )
    , ((modm .|. shiftMask,   xK_m     ), addName "Move focus to the master window" $ focusMaster  )
    , ((modm .|. shiftMask, xK_Return), addName "Swap the focused window and the master window" $windows W.swapMaster)
    , ((modm .|. controlMask, xK_j     ), addName "Swap the focused window with the next window" $ windows W.swapDown  )
    , ((modm .|. controlMask, xK_k     ), addName "Swap the focused window with the previous window" $ windows W.swapUp    )
    , ((modm, xK_less  ), addName "Shrink the master area" $ sendMessage Shrink)
    , ((modm .|. shiftMask, xK_less ), addName "Expand the master area" $ sendMessage Expand)
    , ((modm,               xK_t     ), addName "Push window back into tiling" $ withFocused $ windows . W.sink)
    , ((modm              , xK_f ), addName "Swap window between tiled and fullscreen" $ sendMessage $ Toggle NBFULL)
    , ((modm .|. shiftMask, xK_f ), addName "Take window out of layout and maximize it to fill most of the screen" $ withFocused (sendMessage . maximizeRestore))
    , ((modm              , xK_comma ), addName "Increment the number of windows in the master area" $ sendMessage (IncMasterN 1))
    , ((modm              , xK_period), addName "Deincrement the number of windows in the master area" $ sendMessage (IncMasterN (-1)))
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    , ((modm .|. shiftMask, xK_b     ), addName "Toggle the status bar gap" $ sequence_ [spawn "~/.xmobar/toggle.sh", broadcastMessage ToggleStruts, refresh] )
    , ((modm .|. controlMask, xK_b     ), addName "Toggle the status bar gap in the current WS only" $ sendMessage ToggleStruts)
    , ((modm .|. shiftMask, xK_e     ), addName "Quit xmonad" $ io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_r), addName "Restart XMonad" $ spawn "xmonad --recompile && xmonad --restart || notify-send -u critical 'Errors found in XMonad Config!'")
    , ((modm, xK_u), addName "Unicode Prompt" $ mkUnicodePrompt "xsel" ["-i","-b"] "/usr/share/unicode/UnicodeData.txt" promptTheme)
    , ((modm .|. shiftMask .|. controlMask, xK_m), addName "Manpage Prompt" $ manPrompt promptTheme)
    ]
    ++

    [((m .|. modm, k), addName (s ++ show n ++ e) $ f i)
        | (i, k, n) <- zip3 (XMonad.workspaces conf) [xK_1 .. xK_9] [1..9]
        , (f, m, s, e) <- [(toggleOrView, 0, "Switch to WS ", ". Or if already in that WS, toggle to previous WS."), (windows . W.shift, shiftMask, "Move to client WS ", "."), (windows . copy, controlMask, "Copy client to WS ", ".")]]
   --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
--    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
--        | (key, sc) <- zip [xK_w, xK_e, xK_p] [0..]
--        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
--------------------------------------------}}}
-- Mouse bindings                           {{{
-----------------------------------------------

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
--------------------------------------------}}}
-- Projects                                 {{{
-----------------------------------------------

projects :: [Project]
projects =
  [ Project { projectName      = wsCMD
            , projectDirectory = "~/"
            , projectStartHook = Just $ do spawn myTerminal
            }
  , Project { projectName      = wsMSX
            , projectDirectory = "~/music"
            , projectStartHook = Just $ do runInTerm "" "pulsemixer"
                                           runInTerm "-t castero -c castero" "castero"
                                           runInTerm "-c NCMPCPP" "ncmpcpp"
            }
  ]

--------------------------------------------}}}
-- Workspaces                               {{{
-----------------------------------------------

wsWEB = "\xf268" -- 1: web 
wsCMD = "\xf120" -- 2: terminals 
wsMSX = "\xf001" -- 3: music 
wsBOK = "\xf02d" -- 4: books 
wsGAM = "\xf11b" -- 5: games 
wsPIC = "\xf03e" -- 6: pictures & video 
wsELE = "\xf2db" -- 7: LTSpice 
wsMAT = "\xf1ec" -- 8: Matlab 
wsCHT = "\xf086" -- 9: Chat 
myWorkspaces = [wsWEB, wsCMD, wsMSX, wsBOK, wsGAM, wsPIC, wsELE, wsMAT, wsCHT]

--------------------------------------------}}}
-- Layouts                                  {{{
-----------------------------------------------
-- minimize adds the word minimize to the Layout name, regardless of what named says, so cut it with renamed [...]
myLayout = avoidStruts $ renamed [CutWordsLeft 3] $ spacingRaw True (Border 5 5 5 5) False (Border 8 8 8 8) False $ baseLayout
baseLayout = minimize $ maximize $ boringWindows $ smartBorders $ mkToggle (NOBORDERS ?? NBFULL ?? EOT) $ onWorkspace wsCMD layoutTerminals  $ onWorkspace wsMSX layoutMusic $ onWorkspace wsBOK layoutBooks layoutDefault

layoutDefault = Full ||| named "MTall" (Mirror layoutTiled) ||| layoutTiled ||| Grid
layoutTerminals = named "MTall" (Mirror layoutTiled) ||| layoutTiled ||| layoutCombined ||| Grid ||| Full
layoutCombined = named "TabSplit" (combineTwo (reflectVert $ Mirror $ layoutTiled) (tabbedLayout) (tabbedLayout))
layoutTiled = Tall 1 (3/100) (1/2)
layoutBooks = (named "Tabs" tabbedLayout ||| layoutTiled ||| Full)
layoutMusic = named "MTall" $ Mirror $ Tall 2 (3/100) (7/9)

tabbedLayout = tabbed shrinkText tabbedConf

tabbedConf = def {
    fontName = "xft:CodeNewRoman:size=9:antialias=true"
  , activeColor = myFocusedBorderColor
  , inactiveColor = myNormalBorderColor
  , inactiveBorderColor = myNormalBorderColor
  , activeBorderColor = myFocusedBorderColor
  , decoHeight = 14
}

myNav2DConf = def
    { defaultTiledNavigation    = sideNavigation
    }
--------------------------------------------}}}
-- Window rules                             {{{
-----------------------------------------------

scratchpads = mkXScratchpads [ ("htop", myTerminal ++ " -t scratchpad-htop -e htop", title =? "scratchpad-htop")
                             , ("XMonadConfig", myTerminal ++ " -c scratchpad-xmonadconfig -n scratchpad-xmonadconfig -e vim ~/.xmonad/xmonad.hs", className =? "scratchpad-xmonadconfig")
                             , ("terminal", myTerminal ++ " -c scratchpad-terminal -n scratchpad-terminal", className =? "scratchpad-terminal")                   ] $ customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)

myManageHook =
--insertPosition Below Newer <+>
--    namedScratchpadManageHook scratchpads
    composeOne [ isDialog -?> doCenterFloat ]
--    <+> insertPosition Master Newer
    <+> composeAll [
      xScratchpadsManageHook scratchpads
    , className =? "St" --> insertPosition Below Newer
    , title     =? "WhatsApp - Google Chrome" --> doShift wsCHT
    , className =? "Google-chrome" --> doShift wsWEB
    , className =? "NCMPCPP" --> doShiftAndGo wsMSX
    , className =? "castero" --> doShiftAndGo wsMSX
    , className =? "Zathura" --> doShiftAndGo wsBOK <+> insertPosition Below Newer
    , className =? "vlc" --> doShiftAndGo wsPIC
    , className =? "Vlc" --> doShiftAndGo wsPIC
    , className =? "MATLAB" --> doShift wsMAT
    , className =? "com-mathworks-util-PostVMInit" --> doShift wsMAT
    , className =? "Steam"          --> doShift wsGAM
    , className =? "zoom"           --> doShift wsCHT
    , className =? "dialog"         --> doCenterFloat
    , className =? "xviix64.exe"    --> doFloat -- wine
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , manageDocks
   ] where
     doShiftAndGo ws = doF (W.greedyView ws) <+> doShift ws

--------------------------------------------}}}
-- Event handling                           {{{
-----------------------------------------------

myEventHook = fullscreenEventHook

--------------------------------------------}}}
-- Status bars and logging                  {{{
-----------------------------------------------

myLogHook = return ()

--------------------------------------------}}}
-- Startup hook                             {{{
-----------------------------------------------

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.

myStartupHook = setDefaultCursor xC_left_ptr <+> setWMName "LG3D" <+> spawnOnce "stalonetray" <+> spawnOnce "google-chrome-stable" <+> spawnOnce "google-chrome-stable --new-window web.whatsapp.com"

myBar = "xmobar"

myPP = xmobarPP { ppCurrent = xmobarColor "#FF4000" ""
                , ppTitle = xmobarColor "#00FF00" "" . shorten 45
                , ppUrgent = xmobarColor "yellow" ""
--                , ppSort = fmap (namedScratchpadFilterOutWorkspace .) (ppSort def)
                }
--myPP = xmobarPP { ppCurrent = xmobarColor "#FF4000" "" , ppTitle = xmobarColor "#00FF00" "" . shorten 55}
--myPP = xmobarPP { ppCurrent = xmobarColor "#FF4000" "" . wrap "[" "]" }

--toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask .|. shiftMask, xK_b)
toggleStrutsKey XConfig {} = (0,0) -- Empty keybinding since we are doing more than one thing and we redefine that on the general keybindings

--------------------------------------------}}}
-- Main                                     {{{
-----------------------------------------------
main = xmonad =<< (
    statusBar myBar myPP toggleStrutsKey
    $ withUrgencyHook NoUrgencyHook
    $ withNavigation2DConfig myNav2DConf
    $ dynamicProjects projects
    $ addDescrKeys' ((myModMask, xK_F1), showKeybindings) myKeys
    defaults)

defaults = def {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    clickJustFocuses   = myClickJustFocuses,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
--    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = myLayout,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    logHook            = myLogHook,
    startupHook        = myStartupHook
}

-- vim: ft=haskell:foldmethod=marker:expandtab:tabstop=4:softtabstop=4:shiftwidth=4
