This is a simple zsh configuration based on zprezto, fzf and grml.

__INSTALL__
-----------

Define `$ZDOTDIR` as your convenience.

```zsh
cd
ZDOTDIR=${HOME}/.zsh
git clone --recursive https://github.com/CharlesGueunet/zsh-config.git $ZDOTDIR
ln -s ${ZDOTDIR}/.zshrc .
```

You can copy your old *~/.zhistory* in the `$ZDOTDIR` folder if you want to keep
your old history.
Then, (re)start zsh.

### Update

In your shell:

```zsh
cd $ZDOTDIR
git pull # update from git
Update   # update plugins
sz       # re-interpret the .zshrc
```

__CUSTOMIZE__
--------------

### Plugins

* `$ZDOTDIR/plugins_custom_list.zsh`: add new plugins. For the syntax, see the [zplug website](https://github.com/zplug/zplug) of the `plugins_list.zsh` file.
* `$ZDOTDIR/plugins_custom_conf.zsh`: overwite and add plugins configuration.

### Global zsh

* `$ZDOTDIR/zshrc_custom.zsh`: overwrite and add global zsh configurations.

__ISSUES__
----------

* `$FPATH` does not contains *zplug* related path. Some zplug function are not
avaiable. This is due to a fix allowing to switch user (`su`).

__USAGE__
---------

### Travel

When changing directory, `..` will go to the parent directory.
If you type `...` it will be transformed automatically into `../..` and each `.` you add will
be transformed into `../` for a fast traversal.


`Ctrl-v` will open *vifm* (if installed), a ncurse based file manager based on vim.

### Commands

```zsh
popd   # undo a directory change
cd +N  # make N undo directory change
cdt    # go to a temporary directory
Update # Update plugins
```

### Shortcuts

* FZF :
  * `Ctrl-r` fuzzy navigate history
  * `Ctrl-t` fuzzy find a file / folder
  * `Alt-c`  fuzzy change current directory
* Completion
  * `Ctrl-f` complete next suggested word
  * `Ctrl-y` complete with the whole suggestion
  * `Ctrl-p/n` navigate through last version of this command
  * `Ctrl-Space` same as tab
  * `Ctrl-g` substiture in last command

__Copyright__
-------------

This git is mainted by **Charles Gueunet** \<charles.gueunet+zsh@gmail.com\>

Copyright (C) 2016 Charles Gueunet

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
