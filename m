From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Automount USB Drive using Volume Name as Mount Point
Date: Wed, 24 Jan 2007 11:31:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701241113250.4010@simba.math.ucla.edu>
References: <918171.95307.qm@web35503.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <918171.95307.qm@web35503.mail.mud.yahoo.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Sandra Bonus <mrsbonus1@yahoo.com>
Cc: autofs@linux.kernel.org

On Mon, 22 Jan 2007, Sandra Bonus wrote:

> I'm not sure if this question is an autofs question or perhaps for some 
> other software component.

On a desktop or laptop sytem this would be handled by "the new hotplug":
haldaemon, dbus and gnome-volume-manager.

> ...This mounts one drive as /misc/usb
> This works fine except it would be ideal if each drive actually mounted as 
> /misc/HDD1 and /misc/HDD2 so that scripts can more easily differentiate 
> the disks

Autofs mounts the drive when you refer to it.  I think what you really want 
is to mount it when hotplugged.  Hal is smart enough to read the volume 
label, if there is one, and create a same-name mount point.  The default 
would be /media/$THE_LABEL (e.g. /media/HDD1).

> If I log in using Gnome then this seems to have no problem mounting each 
> drive and placing an icon on the desktop using the volume label. However, 
> I almost never use Gnome and the machine in question is a server.

As it happens, I also use neither Gnome nor KDE as my window manager, and I 
recently posted what I did to make it mount upon hotplug.  Since you want a 
server-wide hotplug manager, rather than specific to one user (me) at the 
console, you'll need to be creative to start it up, e.g. make a new boot 
script.

	http://www.math.ucla.edu/~jimc/documents/bugfix.html

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
