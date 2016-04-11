From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Mon, 11 Apr 2016 18:35:13 +0200
Message-ID: <20160411163513.GC15079@bccms.uni-bremen.de>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
 <1460090760.3135.53.camel@themaw.net>
 <1460110224.2979.35.camel@themaw.net>
 <1460342530.6494.31.camel@themaw.net>
 <20160411163241.GB15079@bccms.uni-bremen.de>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1460392514;
	bh=O9cp84Ni7k7jn5dZVv7klGxmnDVrq8kGt9USu0wTyog=;
	h=Date:From:To:Reply-To:References:In-Reply-To;
	b=jsGX2ubYUPcgIHmcE6Ragfx6V+0Gh09mBfhvrNT8KSEalNlYl5maYV5siKUW+92Pk
	 tic/Dmw3DAxFuqecQhNQxwCd92xJ5Vqbgy2MF8zT7B1tLi/SwvqVQj+56gwYBJu6X1
	 FTdE/KTfAPHDhWo2iv36VcPqlDResET9o3HcTsso=
Content-Disposition: inline
In-Reply-To: <20160411163241.GB15079@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: autofs@vger.kernel.org

Oops, replace 0.25.2 by 0.2.5 ... Sorry.

On Mon, Apr 11, 2016 at 06:32:41PM +0200, Christof Koehler wrote:
> Hello,
>=20
> I will try to consolidate the answer in a single email without messin=
g
> up the quoting too much.
>=20
> > But we can't really start to work out what needs to be done unless
> > libtirpc is being used.
>=20
> > And I think the best chance is to use 5.1.1 and possibly back port =
any
> > changes.
>=20
> > As I say, the only other thing we can do is add some targeted debug
> > logging and see if we can spot what is going wrong.
>=20
> I will then stick to the plan to defer this
> until ubuntu 16.04 has been released which should contain autofs 5.1.=
1
> and libtirpc 0.25.2. From the libtirpc git repo and the sourceforge p=
age
> I see that 0.25.2 is from 2014, but not even debian unstable is
> using a newer version (and from the changelog things like gss_api
> support are the main changes ?).=20
>=20
> I will use a virtual machine with ubuntu 16.04 (or if preferable debi=
an=20
> testing or unstable) and then start experimenting. In that environmen=
t we=20
> can do to autofs and also libtirpc (and nfs-common if necessary) what=
ever=20
> is needed to get the necessary information.=20
>=20
> I will let you know when I start with that and what the baseline with
> the original packages of the distribution and simple rebuild of autof=
s
> --with-libtirpc is.
>=20
> >> Apr  8 18:05:25 core324 automount[963]: get_nfs_info: called with =
host
> >> core330(fd5f:852:a27c:1261:2000::118) proto 6 version 0x40
> >> Apr  8 18:05:25 core324 automount[963]: get_nfs_info: called with =
host
> >> core330(2001:638:708:1261:2000::118) proto 6 version 0x40
> >> Apr  8 18:05:25 core324 automount[963]: mount(nfs): no hosts avail=
able
>=20
> > Sadly that doesn't tell us much either, only that the rpc communica=
tion
> > has failed to get a result in some expected way.
>=20
> Well, at least it shows that this autofs built at least is somehow aw=
are of
> all the different IP adresses and trying the IPv4 one first. Of cours=
e
> no other conclusions can be drawn from this.
>=20
> > That's right, as I say the RPC communication isn't failing in an
> > unexpected way so we aren't seeing any error messages.
> >=20
> > About all that can be done is to add a patch that adds some extra
> > logging to try and get to the bottom of it.
>=20
> That should be possible with a virtual machine as mentioned above.
>=20
> > The first thing that stands out is that if libtirpc is not being us=
ed
> > all IPv6 hosts will be ignored because (my impression is that) glib=
c RPC
> > doesn't support IPv6.
>=20
> The libtirpc documentation says that libtirpc is needed for IPv6 read=
y
> rpc support, http://nfsv4.bullopensource.org/doc/tirpc_rpcbind.php as
> linked from sourceforge.
> Might even be that glibc does actually no longer contain any rpc
> functionality ?
> https://archives.gentoo.org/gentoo-dev/message/186be8dc9753d18aafc9a5=
a616b3b991
> This would be supported by information on the tirpc web page mentione=
d
> above.
>=20
> As far as I understand your analysis you are saying the IPv6
> mount in the "2001" case is just working by accident, right ?
>=20
> > It's mount.nfs(8) mounting from the IPv6 address (when given a host=
 name
> > not an address) in the former case and not autofs that's getting yo=
u an
> > IPv6 mount. And, AFAICS, the mount.nfs your using does use libtirpc=
=2E
> Yes.
> # ldd /sbin/mount.nfs4|grep tirpc
>         libtirpc.so.1 =3D> /lib/x86_64-linux-gnu/libtirpc.so.1 (0x000=
07ffff7d9d000)
> and libtirpc is a hard package dependency of nfs-common.
>=20
> Best Regards
>=20
> Christof
> --=20
> Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-b=
remen.de
> Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
> Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
> 28359 Bremen =20
>=20
> PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in

--=20
Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-bre=
men.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen =20

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
