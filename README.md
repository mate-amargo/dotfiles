# dotfiles

Here I host my dotfiles 🔧

I used to use a nice tool called [yadm](https://github.com/TheLocehiliosan/yadm/),
but I have decided to switch to simply using [GNU stow](https://www.gnu.org/software/stow/).

I've kept the old yadm system under a branch appropriately called `yadm`.

## How to use

Basically the same as described [here](https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html).

Simply clone this repo at `$HOME`

```console
$ cd
$ git clone git@github.com:mate-amargo/dotfiles
```

Then, just choose which dotfiles to install by doing

```console
$ cd dotfiles
$ stow vim
```

which will symlink everything under vim to the homedir. Thus installing `~/.vimrc -> dotfiles/vim/.vimrc`.

To add a new config, just move the directory structure under a new dir in `dotfiles`.
For example, here we create the `i3` "package" and move all related configs there.

```console
$ cd ~/dotfiles
$ mkdir -p i3/.config
$ mv ~/.config/i3 i3/.config
$ mv ~/.config/i3status i3/.config
$ mkdir -p i3/.local/bin
$ mv ~/.local/bin/i3sw i3/.local/bin
$ tree -a i3
i3
├── .config
│   ├── i3
│   │   ├── config
│   │   ├── conky
│   │   └── conkyrc
│   └── i3status
│       └── config
└── .local
    └── bin
        └── i3sw

6 directories, 5 files
$ stow i3
```
