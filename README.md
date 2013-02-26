![tweemux: For Remote Pair Programming](img/tweemux.png)

For Remote Pair Programming: A handy script to create-or-join a world-readable tmux session (smaller than wemux)

One of the aims of this script is to be convenient. Another of its aims is to be transparent (read: loud) about what it's doing. None of the parts of this are inherently complicated, and any of them is prone to need additional debugging, so it's best that `tweemux`'s behavior is visible.

## Problem

Though tmux is an amazing tool, some of the parts of it are low-level. As you can see from the tmux portion of this script's source, there isn't much you have to do to get a shared session, but it's still more than you want you or your pair to think about when you're trying to work.  The `wemux` script is similar to this, but I don't care for its complexity/optionality/config (and the thing that really bothers me is that it has a 'read-only' mode that only is read-only because of the command used to connect to the socket — the socket itself is still `chmod 777`, so you might as well be honest about the idea that the session could be connected by any user in writeable mode).

Once you've solved the "shared tmux" problem, that's actually the easier part of it. This script goes a little further and helps with the user and SSH connection problems.

## Host Usage

For starters:

    gem install tweemux

Then, create the user on your machine (this varies. On decent Unices, it's `adduser` or `useradd`. On OS X you can either get an [adduser-like script](https://raw.github.com/sharpsaw/mac-dots/master/bin/adduser) or do it through the System Preferences GUI).

If you're on a machine behind a firewall, use one that is *not* behind a firewall that you also have SSH access to (in this example, sharpsaw.org is the one not behind the firewall):

    tweemux forward local 22 from sharpsaw.org 3322
    # ^ Or, if you're in control of the router, you can just open a port and
    # point your pair at your actual IP (`curl ifconfig.me` comes in handy for
    # finding the public IP)

Then finally:

    tweemux host

## Guest Usage

    gem install tweemux
    tweemux at sharpsaw.org 3322 # uses the 'forward' set up from above

## Going Further

It's also nice to share a windowing environment session as well. For example, the "Guest" can host a VNC that you, as the tweemux host, can then connect to. This allows you to "point" at things with the mouse, and to share web browsing, etc.

## No Public Box?

If you don't have a public SSH account (like the way I use sharpsaw.org, above), let me know ( i-am-stuck@sharpsaw.org ). We'll solve that.

## TODO

    tweemux bro lwoodson # when their Github username == desired Unix username
    # -or-
    tweemux bro cirwin github: ConradIrwin
    # -or-
    tweemux sis ghopper # synonym for 'bro'

