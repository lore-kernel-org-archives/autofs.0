From: Ian Kent <raven@themaw.net>
Subject: Re: broken mount
Date: Sat, 16 Aug 2008 00:22:39 +0800
Message-ID: <1218817361.12073.21.camel@raven.themaw.net>
References: <1218733121.10481.20.camel@vesuv.TechFak.Uni-Bielefeld.DE>
	<1218801005.12073.9.camel@raven.themaw.net>
	<1218816537.31914.3.camel@vesuv.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1218816537.31914.3.camel@vesuv.TechFak.Uni-Bielefeld.DE>
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


On Fri, 2008-08-15 at 18:08 +0200, Lukas Kolbe wrote:
> Hi Ian!
> 
> > > 
> > > filesrv:/export/support/vol/adm/share on /tmp/autoMcOAUm type nfs4
> > > filesrv:/export/support/vol/adm/share on /tmp/auto2pnUBs type nfs4
> > > filesrv:/export/support/vol/adm/share on /tmp/autovVvZv2 type nfs4
> > > 
> > > consulting /proc/mounts, none(!) of them actually exist. 
> > 
> > Urrrmmm .. what have I done to nfs4 mounts?
> 
> ;)
> 
> > That looks like it's being done by
> > autofs-5.0.3-fix-multi-mount-race.patch
> > 
> > > I don't really know which other list better to contact for this, sorry :(.
> > > 
> > > The util-linux we use is version 2.12r from debian etch with the patch
> > > from the autofs source already applied (it is supposed to
> > > fix /etc/mtab-locking in mount, right?).
> > 
> > Is "mount --move" supported with 2.12r?
> > What does the man page say?
> 
> manpage says yes. 
> 

Backing out the above patch should solve the problem.
How about a debug log (before you back out the patch of course).

Ian
