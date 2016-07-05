From: Xen <list@xenhideout.nl>
Subject: documentation issues
Date: Tue, 05 Jul 2016 23:17:55 +0200
Message-ID: <cec586e96030cbbc150886909bf34a45@dds.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@vger.kernel.org

Hi,

a few things.

A user attempting to use autofs for the first time will assume that 
autofs will mount mount poins that already exist. Nowhere is it stated 
that mount points will only get created when accessed (through a "direct 
path").

Such a user (such as me) trying to use this thing (even with a tutorial 
on Ubuntu site) will be flabbergasted that nothing happens; he/she 
expects mount entries to appear, but nothing happens.

This renders the "nobrowse" default dysfunctional for a desktop user, 
who expects to see something before going there. It only works for 
automated systems, really.

Further, you will only become aware of "browse" after having been able 
to use the system, because otherwise you won't go reading entire manuals 
just to see what is wrong.

So in my case someone explained to me that the mount points would only 
get created when accessed, at which point I finally was able to have 
some result.


So I say two things:

- browse only works for static maps, and what person with a static map 
is going to run into performance issues when mount points are created in 
advance? Can we please remove this from the default config? (turning it 
off).

- browse being turned off by default combined with a complete lack of 
mention that you need to access these "nonexistent" directory paths / 
components before you will be able to see them, turns autofs into a 
complete mystery for someone who is not privy to the details yet.


Further I would say that on a desktop OS, the most likely use case is 
going to be this:

- have several shares in your home network
- want to access them through a GUI
- prefer automounting since mounting at boot can be problematic
- need to see them before you can access them in a GUI
- only alternative is "bookmarks" or "places" that work regardless of 
the things not being visible/listed in the directory.

Then I will also say,

that there is no documentation on the format of the map files other than 
auto.master. The documentation for map files is this:

cat /etc/auto.misc.

That is the documentation.

After you've figured out that e.g. auto.smb wants the servername as the 
key ($1) the documentation becomes this:

/etc/auto.smb <servername>

>> watch results pour out.

But auto.smb doesn't mention that it wants the servername as the key.

Of course, it does mention that:

# You'll be able to access Windows and Samba shares in your network
# under /cifs/host.domain/share

But at this point you still don't know that the "host.domain" part will 
be invisible until you access it.

I'm sorry if I sound abrasive but I was doing freaking straces and even 
kernel traces before realizing how this was supposed to work. There is 
just no documentation on it. The most important thing is missing. Is not 
mentioned.

I wasted so much time trying to figure out how this was supposed to 
work... in the game of Zelda 1 I believe in some dungeon there is a wall 
somewhere that you can walk through. You need to go through that wall to 
get ahead in the game, but there is no visual indication that you can go 
through. It is a secret.

Well. So is this :P.

How is anyone supposed to know that automounting a "mount point" does 
not require a mount point to exist in advance?????

I had even (previously, for something else) been reading kernel source 
code in namei.c or whatever and came across autofs in e.g. lookup_slow 
or something. Even then it never dawned to me that the typical use case 
would be for some mount point to not exist yet.

So you start this thing and you cannot write to the mount point any 
longer so you know it is getting managed.

But nothing ever shows. I even .... well let's not say that here :P.

;-) I had done "touch a" and the file was not created; however I had put 
some command in auto.smb that would output $1 to some file. So the file 
said "a" but it never occured to me that this was the result of my 
"touch a" command ;-). Stupid!.

So I would plead for just two things for other people:

a) get rid of the browse_mode = no, in the configuration file, for 
static mounts
b) say something about mounts not being created automatically in the man 
page for auto.master, if nothing else. If you also do (a), this only 
applies now to programmatic mounts.

=============================================================

You could also do nothing but change the default auto.master:
-------------------------------------------------------------

# This is the sample auto.master file installed on your system.
# This map contains entries for mount points that are to be managed
# by autofs.
#
# Each of these mount points will be mounted with the required map
# file as the parameter to the autofs filesystem module that will
# manage this mount point for you in one of its threads.

# Each entry mentions a mount point that must already exist on your
# system, as well as a map file to be loaded onto that mount point.
# Its format is as follows:


# <mount-point>  [map-type[,format]:]<map> [options]

# where <mount-point> indicates a directory on your filesystem and
#       <map> indicates the map file to be used for it.

# For further details see the man page for auto.master(5).

# Example:
#
# /misc  /etc/auto.misc  browse
#
# This will create entries from /etc/auto.misc under /misc. The browse
# option guarantees that its entries will be created straight away as
# sub-directories to /misc.

# Without the browse option, they would only be created after being
# accessed, e.g. by direct reference. The browse option is only
# applicable to static map files.
#
#
# /net   -hosts
#
# This mounts all accessible NFS shares from hosts in your network
# under /net/<hostname>/ when you first access that path.


# NOTE: mounts done from a hosts map will be mounted with the
#       "nosuid" and "nodev" options unless the "suid" and "dev"
#       options are explicitly given.
#
#
# Include *.autofs from /etc/auto.master.d/ and the included files
# must conform to the format of this file.

+dir:/etc/auto.master.d

# Include another central master map if it can be found using
# nsswitch sources. Note that duplicate entries will be discarded
# as keys must be unique and the keys from this file will take
# precedence. That means you can only specify each mount point once.

+auto.master

# Note that map files can be scripts that take the accessed path as a
# parameter. E.g. the following would mount all Samba shares from a
# certain host under /cifs/<hostname>/* when /cifs/<hostname> was
# accessed:

# /cifs   program:/etc/auto.smb
#
# See /etc/auto.smb for more documentation.

-------------------------------------------------------------

I mean you could rewrite more documentation but this is the simplest I 
could do right here right now.

I think that would clarify a lot for everyone but of course perhaps you 
would want to rewrite more so the central documentation is also up to 
date, but please see this as a more modest attempt for making it more 
accessible to a new user.

Regards,

Bart Schouten.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
