From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: using both nfs3 and nfs4 in a single mount map
Date: Wed, 01 Aug 2007 15:13:42 +0200
Message-ID: <1185974022.22250.64.camel@sangay.TechFak.Uni-Bielefeld.DE>
References: <1185549849.22250.35.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185550740.3203.80.camel@raven.themaw.net>
	<1185551130.22250.41.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185606915.8326.22.camel@raven.themaw.net>
	<1185607363.8326.25.camel@raven.themaw.net>
	<1185802596.22250.52.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185807243.3210.26.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1185807243.3210.26.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian,

> > figaro:/users/xxx /homes/xxx nfs rw,nosuid,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=figaro 0 0
> > bongossi:/export/yyy /homes/yyy nfs rw,nosuid,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=bongossi 0 0
> > 
> > where figaro only exports nfs v3, bongossi exports both v4 and v3 and we
> > really would like to use v4.
> 
> Actually, a multi map entry in the master map would probably work.
> Initially I missed this out of version 5 (by accident) so you'll need
> the patch on kernel.org that adds it. In fact I'd recommend applying all
> the 5.0.2 patches.
> 
> So forget the last suggestion and patch and apply all the 5.0.2 patches
> on kernel.org and try a line in the master map like:

Ok, done that :).

> /homes  multi yp auto_homes -fstype=nfs4,nosuid,grpid,nobrowse,proto=tcp,port=2049 -- \
> 		yp auto_homes -fstype=nfs,nosuid,grpid,nobrowse,proto=tcp,port=2049
> 
> and see if that gets what you need. The nfs4 one needs to be first
> because the v4 servers provide both v4 and v3.

This only gives me the nfs4 mounts, it seems like the second part of the
multimount is not evaluated when the first one says "I don't have that
directory you asked me about":

root@sorpe:/# ls -la /homes/yyy
ls: /homes/yyy: Permission denied

Which is correct and comes from bongossi,

root@sorpe:/# ls -la /homes/xxx
ls: /homes/xxx: No such file or directory

which should also say permission denied and should come from figaro.

> Ian

-- 
Lukas
