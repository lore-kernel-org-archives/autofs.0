From: raven@themaw.net
Subject: Re: Program map and submount problem
Date: Sun, 25 Jan 2004 20:53:01 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0401252045570.1861@raven.themaw.net>
References: <200401232348.i0NNmJN4021507@miguelito.qualcomm.com>
 <Pine.LNX.4.58.0401241202080.1751@raven.themaw.net>
 <Pine.GSO.4.58.0401250122260.10196@miguelito.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0401250122260.10196@miguelito.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Sun, 25 Jan 2004, Mike Marion wrote:

> Really weird.. I don't see this message in my mailbox, but happened to see it
> in the archive.  Oh well.. might've just deleted when clearing out the duplicates caused by your isp's wonky mail server.

Something my mail server doesn't like about yours.

I've been watching the log lately because (I've switched to using my 
own server) of my mail trouble and I seem to be getting timeouts 
connecting to yours. My server should show up as wombat.indigo.net.au in 
your log.

> 
> > The gotya is that if it gets to the umount stage it's already to late to
> > save it.
> 
> Yeah, from what I was able to understand in the code (I read a lot of the
> automount.c file yesterday) I kind of came to the same conclusion.
> 
> > Bottom line is that I can fix this for 4.1.1 (out soonish) combined with
> > my kernel module only. So, sorry to those that can't or have chosen not to
> > upgrade there module. I can't think of a more general way to fix it.
> >
> > Are up for testing the fix Mike?
> 
> Sure.  I've been doing debugging on a lab box we have just for such work, so
> I'd be more then happy to help test a possible fix (or any beta code you
> might have).  We have a pretty big direct map that was originally written for
> Sun's automounter, along with a nis map for homedirs, and we do /net mounting
> as well... so any testing we can do will likely tickle most of the code and
> help find any bugs.

Great. I'm about done for the bug fix release. I'll get some testing done 
tomorrow and send it out to the people with stuff in it.

Ian
