From: Ian Kent <raven@themaw.net>
Subject: Re: broken mount
Date: Mon, 18 Aug 2008 22:51:13 +0800
Message-ID: <1219071074.3188.10.camel@raven.themaw.net>
References: <1218733121.10481.20.camel@vesuv.TechFak.Uni-Bielefeld.DE>
	<1218801005.12073.9.camel@raven.themaw.net>
	<1218816537.31914.3.camel@vesuv.TechFak.Uni-Bielefeld.DE>
	<1218817361.12073.21.camel@raven.themaw.net>
	<1219063906.31914.26.camel@vesuv.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1219063906.31914.26.camel@vesuv.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org


On Mon, 2008-08-18 at 14:51 +0200, Lukas Kolbe wrote:
> On Sat, 2008-08-16 at 00:22 +0800, Ian Kent wrote:
> 
> > > > > The util-linux we use is version 2.12r from debian etch with the patch
> > > > > from the autofs source already applied (it is supposed to
> > > > > fix /etc/mtab-locking in mount, right?).
> > > > 
> > > > Is "mount --move" supported with 2.12r?
> > > > What does the man page say?
> > > 
> > > manpage says yes. 
> > > 
> > 
> > Backing out the above patch should solve the problem.
> > How about a debug log (before you back out the patch of course).
> 
> See the pm. So far, after backing out the patch we still have 2065
> entries containing /tmp/auto in /etc/mtab, but the number is not rising
> anymore and the mounts seem to work well ;). We probably need a reboot
> on this machine soon ...

The only thing I can see in the log is that for fstype=nfs4 and and an
escaped path as the mount target we get a fail, which fails for the
wrong reason (the ":" gets removed). But that problem looks like it was
present before the last set of patches were posted?

It would be good if we could relate the mount target to a map entry for
the things that are showing up in the mtab.

Ian
