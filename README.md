
# Magic Trick's NVIM Configuration Setup

This is my personal Neovim configuration file. For the most part, it's an out-of-the-box
experience plus some custom lua scripts to aid in my personal development cycles.

**Windows Environment Setup:**

I use MSVC build tools and CMake and to expose these to the command line, you can
add these to your PowerShell startup script. I personally wrap them in a function,
but if you want them to automatically startup, you can simply copy and paste them in.

You will find your startup script in `Documents/PowerShell/profile.ps1`; if it 
doesn't exist, create the directory and file to make one. This is loaded on startup.

*Note, you will need to do this in order to compile Treesitter correctly since it
will attempt to use MSVC x86 compilation rather than x64 like it should.*

```
Import-Module "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
Enter-VsDevShell -VsInstallPath "C:\Program Files\Microsoft Visual Studio\2022\Community" -DevCmdArguments '-arch=x64'
```

## Adding Packer

Packer is my plugin manager of choice. You simply need to clone it for your
respective operating system to make `init.lua` launch correctly. You simply
copy and paste the respective shell commands for your OS and it will automatically
install for you.

**[Packer Repository](https://github.com/wbthomason/packer.nvim)**

## Jumper

Jumper is a build to for C/C++ programming (tested only for Windows) which dumps
CMake / MSVC compilation output to a scratch buffer. From there, you can find
error and warning outputs in the buffer and jump straight to the location as shown
in the error. It's not particularly robust and I wish there was a better way to
make this work, but for C++ development on Windows, it seems to work find for me.
Your mileage may vary.

*Untested for Linux as of now.*

![](assets/CJHDemo.gif)

### License

Free to use, modify, and distribute without warranty.

