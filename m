From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Wed, 4 May 2016 14:38:45 +0200
Message-ID: <20160504123845.GK6794@bccms.uni-bremen.de>
References: <20160428112648.GS30271@bccms.uni-bremen.de>
 <1461894846.3033.14.camel@themaw.net>
 <20160429141044.GA30271@bccms.uni-bremen.de>
 <1461986471.3848.84.camel@themaw.net>
 <20160430113600.GI30271@bccms.uni-bremen.de>
 <1462168902.2983.72.camel@themaw.net>
 <20160502160810.GE6794@bccms.uni-bremen.de>
 <1462262318.3034.35.camel@themaw.net>
 <20160503151345.GH6794@bccms.uni-bremen.de>
 <1462346453.6523.18.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1462365526;
	bh=qpxv0O8sguxe0s2lPX/qUmoRTXweU4v8ERdpEmxHyqI=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=OsFGSzvP7z4qd9wZxNiDi4GdcGcyyycnBAQ5JSEWCoYbqgvfuHIf5wlFti49Rr0SE
	 BuxPuxZxTk8WXYKdA8ewK4jf6+ch0p71j71NMXi8JlmybuGJii2JnENbF0HdA01MGY
	 Y/VGFBPFT3Z75VJgLLlFpC5qEMe5VD9YGMGRUxjA=
Content-Disposition: inline
In-Reply-To: <1462346453.6523.18.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello,

there was one more thing I promised to test: mounting from a nfs server=
 which only=20
has IPv6 addresses. I did this now.

The server is a centos 7 with minimal configuration. There is no IPv4
configured and IPv6 is configured with a GUA and an ULA. Of course
matching forward/reverse DNS entries. Using an autofs built with
libtirpc (either my rebuild or the packages from your ppa) there are no
client side problems, e.g. it can mount fine using one of the IPv6
addresses after the response time check.

May  4 13:50:46 core400 automount[9642]: mount_mount: mount(nfs):
calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev
[2001:638:708:1261:1000::9]:/mnt/export /local/testserver
May  4 13:50:46 core400 automount[9642]: mount_mount: mount(nfs):
mounted [2001:638:708:1261:1000::9]:/mnt/export on /local/testserver

With the autofs package from ubuntu, i.e. without libtirpc, it does not
work at all as you expected.

May  4 13:53:07 core400 automount[10949]: mount_mount: mount(nfs):
root=3D/local name=3Dtestserver what=3Dtestserver:/mnt/export, fstype=3D=
nfs4,
options=3Drw,intr,nosuid,soft,nodev
May  4 13:53:07 core400 automount[10949]: mount_mount: mount(nfs): nfs
options=3D"rw,intr,nosuid,soft,nodev", nobind=3D0, nosymlink=3D0, ro=3D=
0
May  4 13:53:07 core400 automount[10949]: mount(nfs): no hosts availabl=
e

I will have to check the server side again, apparently with
just "core*.bccms.uni-bremen.de" in /etc/exports either it does not
listen on all IPv6 addresses or it does only export to one of them (DNS
lookup order ?). But this is something I also observed on our
debian/ubuntu servers with a similar configuration. No real problems, I
can export to the ULAs directly if I want (or let autofs figure it out
for me :-).

On Wed, May 04, 2016 at 03:20:53PM +0800, Ian Kent wrote:
> On Tue, 2016-05-03 at 17:13 +0200, Christof Koehler wrote:
>=20
> But the bis schema is preferred IMHO.
>=20
I will take a second look at this then. Thank you !


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
