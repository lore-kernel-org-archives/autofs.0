From: Ian Kent <raven@themaw.net>
Subject: Re: two /net paths to the same local mount?
Date: Thu, 24 Jun 2010 11:00:29 +0800
Message-ID: <1277348429.2841.44.camel@localhost>
References: <4C1FBABF.5060207@oracle.com>
	<35D166B0274C8DB77A6BE435@[192.168.1.100]>
	<4C225338.8070008@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=Aqbd7dHnUvgibiHdHcQfLQbQWAA=;
	b=ZHGNOEkTR8+/6xyZltuhMbT81O9m1h4feGhQfHJhJoX+Sc6XjPYsNABfKBJFY0QGpAHrOTLMSASznalaJHiNG0s5Zem6lAwojQCoPopBOZITmTVQg5AA0pCajD/NYlVaB4zkSBgpixOp1szc0YBrtcz6/cR01ds0gx+RdZaHPbk=
In-Reply-To: <4C225338.8070008@oracle.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Chris Quenelle <chris.quenelle@oracle.com>
Cc: autofs@linux.kernel.org

On Wed, 2010-06-23 at 11:32 -0700, Chris Quenelle wrote:
> Thanks for your time guys!
> 
> It turns out it's not a general bug.  I was just applying
> a pessimistic interpretation without checking.
> 
> After more testing, it turns out it's just problem
> on one machine, for two mount points under one
> host alias.
> 
> I'm interested in knowing more about how I could
> debug the situation without just rebooting and
> hoping it doesn't happen again.
> 
> Here's my scenario:
> 
> I have three exported filesystems.
> I can use three host aliases to refer to my own machine.
> (carabas, carabas.sfbay, carabas.sfbay.sun.com)
> 
> /etc/hosts says:
> [IP addr]     carabas.sfbay.sun.com carabas
> 
> 
> All filesystems work under all /net/foo aliases
> except two of them hang when accessed via one
> of the host aliases.

Are you sure the address lookup is returning what you think it does?
What's in /etc/host.conf?

> 
> % showmount -e localhost
> Export list for localhost:
> /export/home3 *
> /export/home2 *
> /export/home1 *
> 
> 
> % df -kl
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda2             69575344   3408900  66166444   5% /
> udev                   8222568       148   8222420   1% /dev
> /dev/sdb1             71671728  26507132  45164596  37% /export/home1
> /dev/sdc1             71671728   8545196  63126532  12% /export/home2
> /dev/sdd1             71671728   5375672  66296056   8% /export/home3
> /export/home1         71671728  26507128  45164600  37% /net/carabas/export/home1
> /export/home2         71671728   8545196  63126532  12% /net/carabas.sfbay/export/home2
> /export/home1         71671728  26507128  45164600  37% /net/carabas.sfbay/export/home1
> /export/home3         71671728   5375672  66296056   8% /net/carabas.sfbay/export/home3
> /export/home1         71671728  26507128  45164600  37% /net/carabas.sfbay.sun.com/export/home1
> /export/home2         71671728   8545196  63126532  12% /net/carabas.sfbay.sun.com/export/home2
> /export/home3         71671728   5375672  66296056   8% /net/carabas.sfbay.sun.com/export/home3
> 
> 
> % strace ls /net/carabas/export/home2
> ...
> ...
> mmap(NULL, 217016, PROT_READ, MAP_SHARED, 4, 0) = 0x2b2388370000
> close(4)                                = 0
> close(3)                                = 0
> open("/net/carabas/export/home2", O_RDONLY|O_NONBLOCK|O_DIRECTORY <unfinished ...>

What does a ps listing give you when it is blocked?
Any mount.nfs processes?

That's sign that automount thinks that the mount isn't local and is
probably trying to mount from a possibly non-existent ip address.

> 
> I hit ctrl-C when the ls command hangs.  Above is the tail of the strace output.
> It doesn't tell you much, the interesting stuff happens in the automounter.
> 
> Is there a error log file for the automounter that is enabled by default?
> Is there an easy recipe for restarting the automounter with debugging output on?

You need to ensure that debug logging is being recorded in syslog.
Ensure you are sending daemon.* somewhere.

Then

automount -l debug /net

will start the debug logging and

automount -l err /net

will set it back to no logging.

That is depending on the version of autofs you are using.

If you don't see this option in the automount(8) man page you don't have
this option and all you can do is enable debug logging in the
configuration.

Ian
