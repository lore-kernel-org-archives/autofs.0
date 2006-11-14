From: Ian Kent <raven@themaw.net>
Subject: Re: autofs mount discarding directory in mount point
Date: Tue, 14 Nov 2006 22:22:30 +0800
Message-ID: <1163514150.3297.49.camel@localhost>
References: <45597D53.6848.53F40EC@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45597D53.6848.53F40EC@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
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
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: autofs@linux.kernel.org

On Tue, 2006-11-14 at 08:24 +0100, Ulrich Windl wrote:
> Hi,
> 
> I have a problem where autofs (Novell SLES10, autofs-4.1.4-23.4) discards the 
> first and only directory for an NFS mount; for two directories the thing seems to 
> work OK. I've browsed the sources, but couldn't easily find the problem.

I'm sure this problem has been resolved long ago but I can't remember.
It may be the check for whether an entry is a multi-mount or not that is
at fault but I have no idea what patches are included in SLES10.

This pre-analysis is really something that the downstream package
maintainer needs to do so that I can hopefully make some sense of what
may or may not be included in the package already.

You might check to see if
http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-multi-parse-fix.patch
has been applied.

> 
> The problem is that "server:/foo" which should be mounted to "/net/server/foo" is 
> actually mounted to "/net/server" (with "foo's content" in "server")
> 
> Here's my trace:
> 
> automount[24703]: lookup(program): server -> -fstype=nfs,hard,intr,nodev,nosuid     
> /foo server:/foo
> automount[24703]: parse(sun): core of entry: 
> options=fstype=nfs,hard,intr,nodev,nosuid, loc=/foo server:/foo
> automount[24703]: parse(sun): mounting root /net, mountpoint server, what /foo 
> server:/foo, fstype nfs, options hard,intr,nodev,nosuid
> Nov  9 16:56:47 rksapas03 automount[24703]: mount(nfs): root=/net name=server
> what=/foo server:/foo, fstype=nfs, options=hard,intr,nodev,nosuid
> automount[24703]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, 
> ro=0
> automount[24703]: mount(nfs): host /foo: lookup failure
> automount[24703]: mount(nfs): winner = server local = 0
> automount[24703]: mount(nfs): from /foo server:/foo elected server:/foo
> automount[24703]: mount(nfs): calling mkdir_path /net/server
> automount[24703]: mount(nfs): calling mount -t nfs -s -o hard,intr,nodev,nosuid 
> server:/foo /net/server
> automount[24703]: mount(nfs): mounted server:/foo on /net/server
> 
> 
> (Actual names replaced for clarity)
> 
> Regards,
> Ulrich
> P.S. I'm not subscribed to this list.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
