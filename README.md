![tweemux: For Remote Pair Programming](img/tweemux.png)

For Remote Pair Programming: A handy script to create-or-join a world-readable tmux session

One of the aims of this script is to be convenient. Another of its aims is to be transparent (read: loud) about what it's doing. None of the parts of this are inherently complicated, and we'd like to make sure you can wean yourself off of this if you ever want to.

## Problem

Though tmux is an amazing tool, some of the setup for a shared session over the Internet can be tricky, at first. As you will see from the commands output of this script, it is not utterly difficult, but it's still usually more than you want you or your pair to think about when you're trying to work.

## Guest Usage

    gem install tweemux
    tweemux at somehost.org
    # or, specify a port:
    tweemux at somehost.org 3322

If all goes well, that's it!

Now, time to roll up sleeves and get into the details of how to roll out a red
carpet like this for one's pair.

## Host Usage

For starters:

    gem install tweemux

Then, create the user on your machine (this varies. On decent Unices, it's `adduser` or `useradd`. On OS X you can either get an [adduser-like script](https://raw.github.com/sharpsaw/mac-dots/master/bin/adduser) or do it through the System Preferences GUI).

If you're on a machine behind a firewall, you have these options:

* VPN. If you're on a business network with your pair, you probably can already `ping` each other's machines. Easy stuff, then.
* Directly open a port, such as going to your router config (perhaps at http://10.0.0.1 ?) and setting it to pass the external IP (see `curl ifconfig.me` or http://whatismyip.com ) through to your local box. This is smpler once you get it set up, as long as your location is stable and you have control over the router.
* Use a Virtual machine on the web, and you both ssh into that. Can work very well, and has other advantages (such as the ability to trash the machine all you want and just rebuild it later). The big downside is that you now have two lagged users rather than only one.
* SSH port forward. This is my favorite, but the downside is that you have to have access to a shell account somewhere public. Tweemux provides a tool for this:

In this example, sharpsaw.org is a machine that is not behind the firewall:

    tweemux forward local 22 from sharpsaw.org 3322

Then, after your pair can get to your SSHD socket, finally:

    tweemux host
    # (now they're ready to `tweemux at <yourhost> <your-port>`)

## Going Further

It's also nice to share a windowing environment session as well. For example, the "Guest" can host a VNC that you, as the tweemux host, can then connect to. This allows you to "point" at things with the mouse, and to share web browsing, etc.

## No Public Box?

If you don't have a public SSH account (like the way I use sharpsaw.org, above), let me know ( i-am-stuck@sharpsaw.org ). We'll solve that.

## TODO

    tweemux keys lwoodson # when their Github username == desired Unix username
    # -or-
    tweemux keys cirwin github: ConradIrwin

## Thanks to

The `wemux` script, which is similar to this, but has a different scope of features.
