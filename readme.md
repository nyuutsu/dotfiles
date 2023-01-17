Hi! These are my dotfiles.

If anyone benefits from something in here then I am thrilled.

I recommend not running any scripts unless you are are me.

They'll probably work! But you probably do not want to overwrite your gitconfig with mine, you know?

# On files in `/nyuu`

Some of what is in here is shamelessly yoinked from others' configs.

Some of it is hard-won from experimentation.

I'm especially happy with the:

* i3 config

* Xcompose

* ~~blobmoji urxvt compatibility variant~~ *coming soon*

# On files in `/etc` and `/usr`

Some of these are system config files, which are sort of like dotfiles.

Some of these are files said system config files expect to be present.

# On applying changes

The most reliable way to apply changes is probably to reboot.

Some apply when you reopen the program or terminal.

Some apply when you run`xrdb ~/.Xresources` or `fc-cache`.

Some, such as `.Xcompose`, *might* load when you start x. I don't know for sure; I apply those changes by restarting.

# On scripts

🚨 `homedots.sh` basically does `cp -Rs --remove-destination /nyuu/. ~/` 🚨

To break that down:

1. it looks at every file in the directory structure in `/nyuu`

2. 🚨 if you have an analogous (same dir & same filename) file, your file is deleted 🚨

3. a symlink is created pointing from the file in `/nyuu` to the location in `~/`

You probably do not want this! So you should not run it!

If you must do so anyway, you might need to run `chmod +x` on it first.

# Misc

* vimrc to be included shortly

* os install script to be included eventually