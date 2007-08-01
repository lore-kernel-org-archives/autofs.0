From: "Murata, Dennis" <DENNIS.MURATA@saic.com>
Subject: Re: using both nfs3 and nfs4 in a single mount map
Date: Wed, 1 Aug 2007 09:27:49 -0700
Message-ID: <56D01C1B776AEE4385D29F25E83E515C0B40973F@0599-its-exmb02.us.saic.com>
References: <1185549849.22250.35.camel@sangay.TechFak.Uni-Bielefeld.DE><1185550740.3203.80.camel@raven.themaw.net><1185551130.22250.41.camel@sangay.TechFak.Uni-Bielefeld.DE><1185606915.8326.22.camel@raven.themaw.net><1185607363.8326.25.camel@raven.themaw.net><1185802596.22250.52.camel@sangay.TechFak.Uni-Bielefeld.DE><1185807243.3210.26.camel@raven.themaw.net>
	<1185974022.22250.64.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
in-reply-to: <1185974022.22250.64.camel@sangay.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>, Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

I have also tried the multi feature with autofs-5.0.2-7 on a RHEL 5
workstation.  The auto.master entry I used on RHEL 3 autofs-4.1.3--184
was:

/pa  multi:file /etc/auto.pa -- yp auto.pa

The /etc/auto.pa and the yp map auto.pa were single line entries:

*  server:/local/foo/&
and
*  server:/local/foo1/&
 
I modified the auto.master entry for autofs-5.0.2-7:

/pa multi file /etc/auto.pa -- yp auto.pa

And tried to use the same /etc/auto.pa and nis auto.pa.  This did not
work, it would not search the second entry.  If I added +auto.pa to the
/etc/auto.pa file, it would only search the yp map.  If I changed the
file /etc/auto.pa from using a wildcard to specifying each directory
things started working.  Is this the problem you are seeing?  Is there
anyway to allow wildcards in both maps?

Wayne

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Lukas Kolbe
Sent: Wednesday, August 01, 2007 8:14 AM
To: Ian Kent
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] using both nfs3 and nfs4 in a single mount map

Hi Ian,

> > figaro:/users/xxx /homes/xxx nfs 
> > rw,nosuid,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo=6
> > 00,retrans=2,sec=sys,addr=figaro 0 0 bongossi:/export/yyy /homes/yyy

> > nfs 
> > rw,nosuid,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,tim
> > eo=600,retrans=2,sec=sys,addr=bongossi 0 0
> > 
> > where figaro only exports nfs v3, bongossi exports both v4 and v3 
> > and we really would like to use v4.
> 
> Actually, a multi map entry in the master map would probably work.
> Initially I missed this out of version 5 (by accident) so you'll need 
> the patch on kernel.org that adds it. In fact I'd recommend applying 
> all the 5.0.2 patches.
> 
> So forget the last suggestion and patch and apply all the 5.0.2 
> patches on kernel.org and try a line in the master map like:

Ok, done that :).

> /homes  multi yp auto_homes
-fstype=nfs4,nosuid,grpid,nobrowse,proto=tcp,port=2049 -- \
> 		yp auto_homes
-fstype=nfs,nosuid,grpid,nobrowse,proto=tcp,port=2049
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


_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
