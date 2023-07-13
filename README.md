
Here is my personal nvim configuration file. You will need to have vim plug installed
in order to use this. Make sure to install this before setting the source of the
init.vim. I personally place my init.vim script somewhere more accessible than
the default directory and source it with `source ~/my/path/init.vim`.

Unix:
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Windows Powershell
```
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```


