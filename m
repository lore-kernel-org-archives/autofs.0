From: Ian Kent <raven@themaw.net>
Subject: Re: opensuse 10/autofs-4.1.4-6 Automount getting stuck with
	superblock/time out/no mount found errors
Date: Fri, 5 May 2006 10:47:56 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605051032010.6748@raven.themaw.net>
References: <694d2f6c0605040946u25257f96ga8dbb5f1c24fe1f2@mail.gmail.com>
	<x491wv9xzfg.fsf@redhat.com>
	<694d2f6c0605041837s4e87cccfsce78e3038d7d6b9f@mail.gmail.com>
	<Pine.LNX.4.64.0605050949570.2898@raven.themaw.net>
	<694d2f6c0605041913s58953350jdb737123b7a21bdb@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <694d2f6c0605041913s58953350jdb737123b7a21bdb@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Neil Millar <nmillar@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 5 May 2006, Neil Millar wrote:

> On 05/05/06, Ian Kent <raven@themaw.net> wrote:
> > On Fri, 5 May 2006, Neil Millar wrote:
> > 
> > > Looking at the debug output i'm less convinced now that it is problems
> > > with automount rather than nfs in general, but the return codes may help
> > > confirm that?
> > 
> > Yes. That superblock error is a bit suspicious.
> > 
> > However, before we go further please check to see if your autofs package
> > includes the patch:
> > 
> > http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-locking-fix-1.patch
> 
> The suse package doesn't appear to have that patch included. Should
> I try that?

I don't think it will solve the problem but I think some of the messages 
are because the locking is also failing. OTOH the locking could be timing 
out because NFS umount is blocked.

I'd add it and see if we can get rid of some of the error messages and 
maybe get closer to what's actually happening.

Unfortunately, the lock is meant to prevent corruption of /etc/mtab and 
because it's shared by all mounts and umounts it can't be specific to 
individual mounts so it affects all mounts.

I'd add it anyway.

Another way to eliminate unrelated error messages might be to disable the 
mount locking using:

http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-configureable-locking.patch

but you will need to be carefull to ensure that util-linux mount/umount 
locking is working. SuSE might already have a patched util-linux. See the 
patch for more information. The reason this is better is because it moves 
the locking of mtab to a much smaller window so the hung mount will not 
have taken the lock since it probably hasn't umounted the file system yet. 
So other unrelated mount/umounts won't also then fail.

Ian
