From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: submount vs automount
Date: Fri, 25 Jun 2004 17:19:07 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406251656490.3332@xena.cft.ca.us>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
	<Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
	<40DC6F84.5020701@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40DC6F84.5020701@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org

On Fri, 25 Jun 2004, Mike Waychison wrote:
> > Get the source from Sourceforge if you're in that situation.)
> 
> IIRC, SuSE has this module as an external rpm: km_submount.  You'd have
> to rebuild that rpm.

Aha, missed that one.  The way submount is structured, the source RPM 
probably has both the module and the utility.

> > D.  There is an option to mount the filesystem (floppy or CD) with the
> > UID-GID of the originally requesting user...
> 
> This is just semantically racy.  If someone ssh'es into you laptop and
> accesses the mount before you do, you can't access it.  A better
> approach IMHO is to mount with the UID of the user on :0, unmounting it
> on logout if possible. Thoughts?

It's an interesting denial of service attack.  Agreed that it's better to 
identify and use the user on the physical console.  logindevperm is 
generally set up to re-own a number of special files specially for a 
console login.  But here, the ownership determination has to occur a 
long time after the login.  With X-windows, it may not always be clear what 
the console is and who is logged on to it, particularly in unusual 
configurations, like multi-headed.

> > The idea is that
> > when you suspend a laptop, the suspend script explicitly unmounts the
> > crypto filesystem.
> 
> How is this possible?  When you suspend, you'll still have open files to
> the file system.

I'm thinking of parking the unencrypted secret keys in a small crypto 
filesystem.  Generally the programs (postfix, openvpn, pluto, apache, etc.)
either read the key once at startup (or HUP) and then close it, or read it 
once when each connection starts.  They don't hold it open -- so the 
filesystem can be unmounted and remounted during a suspend.  You're quite 
right that this approach would work poorly if you're editing secret data in 
an encrypted work area, and you expect to unmount it across a suspend, yet 
leave the editor running.  Of course, that would violate any competent 
security procedures...

> A better approach would have the loop backed device (I'm assuming you
> are using this for the crypto) flush the keys, and have *it* ask you to
> refresh them.  It will however have to remember who to ask :)

Flushing the key: good.  Reaching from the bowels of the kernel to pop a 
dialog box: not so good.

> > Here's a spiffy redesign: when the user hits the eject button on the CD,
> > autofs.ko is aware of it (probably the hardest part) and signals the
> daemon
> > to unmount if possible.  If that could be made to work, it would
> eliminate
> > the stupid Windoze-style polling.  But floppies work differently.

> This won't work and has been discussed at length before on
> linux-hotplug-devel.  A lot of removeable medias don't have any way for
> the system to know you are ejecting them.  A good example is CF media.
> It was determined that polling was the only way to have this work.

I suppose you're right, too many device types can't tell you they're 
ejecting until it's too late.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
