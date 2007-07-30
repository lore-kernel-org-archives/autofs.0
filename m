From: Ian Kent <raven@themaw.net>
Subject: Re: using both nfs3 and nfs4 in a single mount map
Date: Mon, 30 Jul 2007 22:38:58 +0800
Message-ID: <1185806338.3210.16.camel@raven.themaw.net>
References: <1185549849.22250.35.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185550740.3203.80.camel@raven.themaw.net>
	<1185551130.22250.41.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185606915.8326.22.camel@raven.themaw.net>
	<1185607363.8326.25.camel@raven.themaw.net>
	<1185802596.22250.52.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1185802596.22250.52.camel@sangay.TechFak.Uni-Bielefeld.DE>
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

On Mon, 2007-07-30 at 15:36 +0200, Lukas Kolbe wrote:
> Hi Ian, thanks for your support!
> > > 
> > > Presumably the exports are distinct, in which case using a list of
> > > server should allow autofs to try each one?
> 
> Yep, they are - differnet homes come from different servers. 
>  
> > > What about trying something like:
> > 
> > On second thoughts this may get only the nfs4 or only the nfs3 servers
> > as well.
> 
> Automount now mounts fine from all servers, but still nfs3
> only. /proc/mounts shows me:
> 
> figaro:/users/xxx /homes/xxx nfs rw,nosuid,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=figaro 0 0
> bongossi:/export/yyy /homes/yyy nfs rw,nosuid,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=bongossi 0 0
> 
> where figaro only exports nfs v3, bongossi exports both v4 and v3 and we
> really would like to use v4.

That is difficult because the selection is supposed to return the
largest list of servers that support the highest protocol version,
sorted by rpc ping response time.

If we change it to return a list ordered by nfs version with each
version sorted by rpc response then it no longer satisfies the
requirements of replicated server selection.

> 
> In fact, we have to use v4 here as every home directory is a seperate
> ZFS volume, and nfs3 has issues scaling to over a hundered simultanous
> mounts on linux that nfs4 has not.
> 
> On the old fileservers, we have the homes sitting in about 10 to 20
> different volumes and use a hack to only mount these few volumes per
> nfs3 and then bind-mount each individual home locally.
> 
> > > 
> > > In the master map put:
> > > /homes	auto_homes	nosuid,grpid,nobrowse,proto=tcp,port=2049
> > > 
> > > In NIS auto_homes put:
> > > *	thor:/export/rbg/homes/staff/& figaro:/users/rbghiwis01/rbghiwis/& figaro:/users/stud09/stud/&
> > > 
> > > With the order determined by the server likely to get the most hits.
> > > 
> > > Ensure that /etc/nsswitch has:
> > > automount: files nis
> 
> This works indeed like a charme, autofs is also expiring the mounts
> correctly. 
> 
> > > and /etc/auto_homes, either doesn't exist or contains, as the last line,
> > > +auto_homes
> > > 
> > > And finally this patch.
> > > Beware, I haven't even compile tested this and I know I excluded the
> > > NFS4 here for a reason, which I can't remember atm.
> 
> I don't really know what this patch is supposed to do :), but it applied
> and works. 
> I suppose it should try nfs4 if no explicit -fstype= is given?

At some point I found I had to treat nfs4 a little differently and
that's why they were seperated.

> 
> 
> Apropros expiring mounts: I get 
> 
> Jul 30 15:31:12 sorpe automount[14121]: umount_multi: could not stat fs of /homes/yyy
> 
> in syslog and /homes/yyy is still mounted; but I guess this is an Issue
> that I'll try to cover after the nfs3 versus nfs4 thing.

Not sure about that but perhaps later.

> By the way thanks to your patient support I slowly begin to understand
> how autofs really works. Thanks!
> 
