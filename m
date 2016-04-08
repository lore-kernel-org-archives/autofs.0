From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 8 Apr 2016 14:25:52 +0200
Message-ID: <20160408122552.GW15153@bccms.uni-bremen.de>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
 <1460090760.3135.53.camel@themaw.net>
 <1460110224.2979.35.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1460118354;
	bh=1YAHsAIo3rCHnMh6ZIXNwtIrNEfFKSSNxZrmrqSIeF8=;
	h=Date:From:To:Reply-To:References:In-Reply-To;
	b=ZvKSfwSRLHOf5BNT/zZ+JtfQFjDvxYrUerYmiLiDq+pmqO2ZEoKeqdMFbw/d1QZsJ
	 jKTUmfbnnCWdUc1ha28KEz/eXRIxxC3qN1GIvZMohWX5QNnfaCfwBSEy4XGOryHe8w
	 PIq3Xm2fWGZ4lTnXWCZdqexvAym5c8qzQqTWs5ec=
Content-Disposition: inline
In-Reply-To: <1460110224.2979.35.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@vger.kernel.org

Hello again,
> I've been thinking about this and I have a couple of thoughts.
>=20
> As far a IPv6 goes using glibc RPC is, I think, not going to work!
>=20
> That's the first thing that needs to be sorted out.
>=20
> I've been using libtirpc in Fedora and RHEL builds for nearly 10 year=
s
> so I don't think the library problem is with autofs.
>=20
> This is an indication someone is doing something a little dumb:
>=20
> automount[20444]: open_mount:247: parse(sun): cannot open mount modul=
e
> nfs (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined symbol:
> clnt_dg_create)

concerning my failures to build autofs. First the client has all
libtirpc packages I think are necessary:
# dpkg -l libtirpc\*|grep ii
ii  libtirpc-dev                                   0.2.2-5ubuntu2
ii  libtirpc1:amd64                                0.2.2-5ubuntu2

We have libtirpc1 on the machines by default and I had to
install libtirpc-dev so that ./configure would conclude that
--with-libtirpc should do anything.=20

Actually I tried to compile autofs 5.1.1 from source and a new 5.0.7
package from ubuntu's source deb.

Using the sources at https://www.kernel.org/pub/linux/daemons/autofs/v5=
/
I was basically confused what to do about the patches. Do I have to
apply everything in patches-5.1.2 to autofs-5.1.1.tar.gz to get 5.1.2 ?=
=20
How do I do that automatically ? I noticed that autofs-5.1.1.tar.gz
misses the patch mentioned in message 15 of
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D737679
but contained in autofs-5.1.1-revert-fix-libtirpc-name-clash.patch.

So to make it short I certainly messed something up
somewhere, the final binary and libs were no success . Additionally
installation did not play nice, although --prefix=3D was set it overwro=
te
configuration files in /etc.  But I think I
cleaned everything up afterwards.

If someone can provide some hints I would try it again.

After that I rebuild the 5.0.7 package from source deb after adding
--with-libtirpc to debian/rules as suggested in the bug reports. I
installed from that package.  I checked with ldd after installing
that ldd /usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so was build with a
reference to libtirpc.=20

This try gave the error message in the ubuntu bug
report https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1564380

So, any hints are appreciated. As long as I can stick to 5.0.7 rebuilt
from the source deb installing/re-installing is no problem and I can tr=
y
different things you might want. Assuming I can get the program to work=
 :-)

Thank you very much for all your help !


Best Regards

Christof



--=20
Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-bre=
men.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen =20

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
