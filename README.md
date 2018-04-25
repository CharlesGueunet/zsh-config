This is a simple zsh configuration based on zprezto, fzf and grml.

__INSTALL__
-----------

```zsh
cd
ZDOTDIR=${HOME}/.zsh
git clone --recursive https://github.com/CharlesGueunet/zsh-config.git $ZDOTDIR
ln -s ${ZDOTDIR}/.zshrc .
```

You can copy your old *~/.zhistory* in the `$ZDOTDIR` folder if you want to keep it
for history and suggestion.

### Update

```zsh
cd $ZDOTDIR
git pull --recurse-submodules
git submodule update --recursive --init
```
__CUSTOMIZE__
--------------

### Zprezto

Zprezto related configurations are done in the `${ZDOTDIR}/.zpreztorc` file. If you want to
overwrite any of these configuration, just write them in a `${ZDOTDIR}/.zprezorc.postconf` file.
The documentation related to zprezto (and each module) is available in the
[wiki](https://github.com/sorin-ionescu/prezto).

### Zsh

Zsh related configuration are on the `${ZDOTDIR}/.zshrc` file.
You can overwrite/extend this configuration using a `${ZDOTDIR}/.zshrc.postconf` file.

__USAGE__
---------

### Tricks

When changing directory, `..` will go to the parent directory.
If you type `...` it will be transformed automatically into `../..` and each `.` you add will
be transformed into `../` for a fast traversal.

### Commands

```zsh
popd # undo a directory change
cd +N # make N undo directory change
cdt  # go to a temporary directory
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

