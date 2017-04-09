This is a simple zsh configuration based on zprezto, fzf and grml.

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


# zsh-config
Custom zsh config based on zprezto

# INSTALL

```zsh
cd
git clone --recursive https://github.com/CharlesGueunet/zsh-config.git .zsh
ln -s .zsh/.zshrc .
```

You can copy your old *~/.zhistory* in the *~/.zsh* folder if you want to keep it
for history and suggestion.

Note if you have simply cloned this repo, you need to install git submodules
with:

```zsh
cd ~/.zsh
git submodule update --recursive --init
```

# USE

You can have in you *.zsh/* folder  a **.zpreztorc.postconf** to tweak prezto
and a **.zshrc.postconf** for your own config.
