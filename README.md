# dotfiles
🔧 My dotfiles &amp; some useful scripts 🐛

The files are managed nicely by [yadm](https://github.com/TheLocehiliosan/yadm/).

## Installation

Specify the main branch:

```
yadm clone -b main https://github.com/mate-amargo/dotfiles.git
```

After that, remember to decrypt the files:

```
yadm decrypt --yadm-archive ~/.local/share/yadm/archive
```

## Usage

### Basic stuff

Just use `yadm` as if it were git.

```
vim ~/.newconfig
yadm add ~/.newconfig
yadm commit -m "Useful commit message"
yadm push
```

### Alternates

There are various ways of using alternate files. But I find that using the `class` system works best for me.

You can set the class with (for example `home`):

```
yadm config local.class home
```

To query the current class just don't pass the last argument

```
yadm config local.class
```

If you want to use alternates just add them to `~/.config/yadm/alt` and commit that file and **not the created symlink**.

For example:

```
vim ~/.config/yadm/alt/.config/fish/config.fish\#\#class.home
yadm add ~/.config/yadm/alt/.config/fish/config.fish\#\#class.home
yadm commit -m "Add fish config for home class"
```

This will create a symlink from `~/.config/fish/config.fish` pointing to `~/.config/yadm/alt/.config/fish/config.fish##class.home`

### Encryption

To use encryption first add the path to the sensitive file to the archive `~/.config/yadm/encrypt` and then use `yadm encrypt` to generate the encrypted file `~/.local/share/yadm/archive` and add that one to the repo too!

For example:

```
vim ~/.config/my_sensitive_config
echo '~/.config/my_sensitive_config' >> ~/.config/yadm/encrypt
yadm add ~/.config/yadm/encrypt
yadm encrypt
yadm add ~/.local/share/yadm/archive
yadm commit -m "Add sensitive config as encrypted file"
```
