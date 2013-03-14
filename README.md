![tweemux: For Remote Pair Programming](img/tweemux.png)

For Remote Pair Programming: A handy script to create-or-join a world-readable tmux session

One of the aims of this script is to be convenient. Another of its aims is to be transparent (read: loud) about what it's doing. None of the parts of this are inherently complicated, and we'd like to make sure you can wean yourself off of this if you ever want to.

## Problem

Though tmux is an amazing tool, some of the setup for a shared session over the Internet can be tricky, at first. As you will see from the commands output of this script, it is not utterly difficult, but it's still usually more than you want you or your pair to think about when you're trying to work.

## Guest Usage

    gem install tweemux
    tweemux on somehost.org
    # or, optionally, specify a user and port:
    tweemux on someuser@somehost.org 3322

That should be all it takes for the guest to get started!

Now, time to roll up sleeves and get into the details of the other end: hosting.

## Host Usage

For starters:

    gem install tweemux

Then, create the user on your machine. This process varies.
* On decent Unices, it's `adduser` or `useradd` then perhaps a bit of tinkering with `/etc/ssh/sshd_config` (rking uses [this script](https://raw.github.com/sharpsaw/linux-dots/master/bin/brogrammer) to cover both of those tasks)
* On OS X, we've prepared a [Sweet MacSetup doc](MacSetup.md) (thanks @[Ogredude](https://github.com/ogredude))

Now, you can install the 'keyholes' for this user from Github. This means they
will be able to get in without manually typing a password, just like when they
`git push` to Github:

    tweemux hubkey cirwin github: ConradIrwin
    # or, if their Unix username is their Github username, there's a shorthand:
    tweemux hubkey rking

Now, for perhaps the trickiest part: they'll need a route to your sshd port.
See the [Routing](#Routing) section below for more details, but the short story is: if you're on a
machine behind a firewall (and most home and business users are), you have
these options: Use a VPN, directly open a port, use a host on the Internet, or
SSH port forward. Tweemux provides a tool for this last one:

In this example, sharpsaw.org is a machine that is not behind the firewall:

    tweemux forward local 22 from sharpsaw.org 3322

Then, after your pair can get to your SSHD socket, finally:

    tweemux host # starts the shareable session
    tweemux log # Optional step: watch the ssh logs for them to come in

Now they're ready to `tweemux on <yourhost> <your-port>` !

Keep in mind that most of this setup is one-time or per-user. After you get it
going, you just rock along with a `tweemux forward…` and `tweemux host` then
they `tweemux on`. Not much more than that!

## Going Further

### GUI sharing

It's also nice to share a windowing environment session as well. For example, the "Guest" can host a VNC that you, as the tweemux host, can then connect to. This allows you to "point" at things with the mouse, and to share web browsing, etc.

### Tip: ~/.ssh/config

    tweemux on someuser@somehost.org 3322

Then you might consider doing adding a some ~/.ssh/config goodness:

    Host smh
      Hostname somehost
      User someuser
      port 3322

Now you're down to just:

    tweemux on smh

## Routing

Your options are:
* VPN. If you're on a business network with your pair, you probably can already `ping` each other's machines. Easy stuff, then.
* Directly open a port, such as going to your router config (perhaps at http://10.0.0.1 ?) and setting it to pass the external IP (see `curl ifconfig.me` or http://whatismyip.com ) through to your local box. This is smpler once you get it set up, as long as your location is stable and you have control over the router.
* Use a machine on the Internet, that you both ssh into that. Can work very well, but the big downside is that you now have two lagged users rather than only one.
* SSH port forward. This is my favorite, but the downside is that you have to have access to a shell account somewhere public. This is where `tweemux forward local 22 from somebox.com 2323` comes in.

## No Public Box?

If you don't have a public SSH account (like the way I use sharpsaw.org, above), let me know ( i-am-stuck@sharpsaw.org ). We'll solve that.

## Comms

Once you've shared the tmux session, you've got a lot. But you still need more bandwidth with your pair.

There are a few solutions:

- *Use inline comments* to type back and forth. Properly configured shells can also allow you to prefix with a `#` and say whatever you want. The downside is that only one person can be typing at any one time. A custom that helps is if you type what you're saying, then leave a trailing `#` with no space after it to indicate that you're done and waiting on your pair to type. This is a bit crufty, but some people are shy and only want to do the tmux share.
- *Use IRC*. If you make a tmux pane and connect it to IRC (or some other text-based chat), both local users plus that shared session can all join the same channel. This provides the person that isn't driving the keyboard to switch to their local chat window and type something for the other person to see. (TODO: build this in as a tweemux feature).
- *Use voice*. A much more powerful way to work.
  * You "can" use Skype, but it's a commercial product and is continuously flaky.
  * There is also the Google Chat alternative, which is nice in some ways, but also ties you to a commercial entity.
  * A better alternative is to sign up for a [SIP account](https://ekiga.net/), then get a [SIP client](https://en.wikipedia.org/wiki/List_of_SIP_software#Clients). For Linux, I use (Ekiga)[https://en.wikipedia.org/wiki/Ekiga), and for OS X I use [Telephone.app](http://www.tlphn.com/).
  * Don't forget, if you can't get the Internetty stuff to work, there's always calling each other on cell phones.

## TODO

# PeopleAdmin/tweemux open issues
  27: `tweemux` with no commandline arguments produces ugly error.
  25: 1.8 + System-wide install
  23: `tweemux host` from within session should upgrade to shareable
  22: Provide higher-level window/font sync functionality
  21: 'tweemux capabilities at ___'
  19: If tmux isn't in the path when you SSH in, nothing will work. 5
  18: Rogue Mode 3
  17: Mention Google Voice/Hangouts 1
  16: Promote regular tmux session to tweemux
  15: Guest usage to connect to a different socket path
  14: Add pseudo_restart of 'retry'
  12: Mosh possible
  11: Basics of Tmux
   8: Port fw without ssh [enhancement] [question]
   7: adduser/useradd call [enhancement]
   4: brew install someurl [Mac]

## Thanks to

The `wemux` script, which is similar to this, but has a different scope of features.
