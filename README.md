
# Magic Trick's NVIM Configuration Setup

This is my personal Neovim init script. If you want to use this setup, clone it
somewhere accessible that you can `source` via absolute path.

### Using VimPlug

I use a plugin manager called VimPlug to fetch third-party plugins. You will need
to install it in order to make the plugins work. Depending on your platform, your
method of installation differs. The commands to install VimPlug are below:

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

### Installing Plugins

Once you have VimPlug, you will now need to source the `init.vim` and, optionally,
the platform scripts that I use for development on Linux/Windows. In your respective
init locations for nvim (`~/.config/nvim/init.vim` for Linux and `%APPDATA%/local/nvim/init.vim`
for Windows), add the lines:

Unix:
```
source ~/path/to/repo/init.vim
source ~/path/to/repo/linux_config.vim
```

Windows:
```
source C:\Path\To\Repo\init.vim
source C:\Path\To\Repo\windows_config.vim
```

The reason I have separate configs for different OS platforms is because Windows
and Unix use different scripting languages. Rather than trying to write a huge
vimscript file just to determine OS, build types, and language environments,
it is much easier to simply write a script in the respective OS scripting languages
and executing them using a nvim shell command.

### License

Free to use, modify, without warranty. It's just a config setup, nothing special.
Go wild.

