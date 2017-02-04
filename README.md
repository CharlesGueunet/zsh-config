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

You can have a **.zshrc.preconf** to tweak prezto and a **.zshrc.postconf** for your own config.
