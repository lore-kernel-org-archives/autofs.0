From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sat, 30 Apr 2016 13:36:00 +0200
Message-ID: <20160430113600.GI30271@bccms.uni-bremen.de>
References: <20160426152711.GF30271@bccms.uni-bremen.de>
 <1461722078.4208.31.camel@themaw.net>
 <20160427165250.GM30271@bccms.uni-bremen.de>
 <1461812190.3083.101.camel@themaw.net>
 <20160428091019.GO30271@bccms.uni-bremen.de>
 <1461840658.3063.18.camel@themaw.net>
 <20160428112648.GS30271@bccms.uni-bremen.de>
 <1461894846.3033.14.camel@themaw.net>
 <20160429141044.GA30271@bccms.uni-bremen.de>
 <1461986471.3848.84.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1462016161;
	bh=ktcgRaew3RLhknMhCzTPCbLOF2NpF0u6ZF8yw5cq90U=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=d+SVGnHd0JGErJH2TfTadXuoBjeFbHgffzKEhTv4rTJXp53caakBQ7/tw6zdmaT57
	 iXfEgB4ape/4JDygwdM8UtoVdSePvP0cFycHuJoKbKgesD8Fixr6zq06vbJiT6Gxo9
	 7O34zeO61l27p+hk9fD4/58NYFa4cmG33dUl2Rgc=
Content-Disposition: inline
In-Reply-To: <1461986471.3848.84.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello.

On Sat, Apr 30, 2016 at 11:21:11AM +0800, Ian Kent wrote:
> On Fri, 2016-04-29 at 16:10 +0200, Christof Koehler wrote:
> > Hello,
> >=20
> > >=20
> > > Would that approach help with what you're trying to achieve?
> > >=20
> >=20
> > I am not sure of anything right now anymore after noticing what mou=
nt=20
> > does. On top, I am not sure if I understand what you are proposing =
:-)
>=20
> I'll need to review what we've said already for the problem with
> mount.nfs(8).
Just to be clear: I am not refering to the fallback to IPv4, that has
indeed been covered, see below. I am refering to its stand alone, i.e. =
called
by hand on the command line, behaviour to alternate between available I=
Pv6=20
addresses. I did not observe this before and it makes me unsure if my
initial request for autofs's behaviour might have been unreasonable.

> >=20
> > Independent of that maybe a) fixing the situation where
> > autofs/mount falls back to IPv4, which I understand is a bug, and b=
)
>=20
> Partly, the situation I described so far is, IPv6 won't work at all i=
f
> not using libtirpc, that's fixed by building autofs with libtirpc
> support, no big deal there, we have that already.
>=20
> I believe we originally started talking about IPv4 fall back because =
of
> the lack of libtirpc support in Ubuntu autofs.
Yes.=20

Eventually the current behaviour could be documented as "working for
now, not guaranteed to work at all without libtirpc in future releases"=
=20
as a compromise ?

It would have been helpful if the man page would have included a hint t=
hat
libtirpc is a prerequisite for IPv6, similar to its mentioning in nfs(5=
)=20
(search "TI-RPC").

> There was also uncertainty about how mount.nfs(8) ends with an addres=
s.
> Lets leave that alone for the moment.
This is clearly not an autofs issue. I will probably ask
somewhere else if I cannot find an answer myselves.

mount.nfs4(8) does not mentions IPv6 at all, and nfs(5) does not give
any information about a possible address selection process.

>=20
> So I went looking and found that the order of addresses returned by
> getaddrinfo(3) is in fact a modified rfc 3484 ordering.
>=20
> I then responded saying this ordering may be sufficient, and a fairly
> simple way to implement the needed address selection (and I mostly
> ignored IPv4 with this suggestion).
My problem is that I did/do not fully understand the details of the
sorting process you decribed. Now just reading getaddrinfo(3) saying "T=
he =20
sorting  function  used  within getaddrinfo()  is defined  in  RFC 3484=
" I would
say that the list as returned by getaddrinfo should be what I wanted (I=
 am not=20
sure what you mean with "modified", the tweaking of gai.conf ?).

That is why I tried to explain the big picture. For me it is important =
that it=20
consistently selects the ULA unless specifically instructed to do other=
wise.

> Having done that adding an autofs configuration option to not use IPv=
4
> addresses for hosts with multiple addresses should be sufficient to
> force IPv6 only use. Also not difficult but I Think will have some
> special cases to consider. I didn't mention this before because I
> thought the first thing to resolve was address selection.
=46or me the actual selection of an existing ULA above IPv4 and GUA is=20
"the big thing".=20

If I can pass the right IPv6 address via an executable map bypassing=20
autofs's own selection mechanims (Why should it use that mechanism if i=
t=20
gets an IP instead of a hostname ? Would it do it ? Have to try.) I gue=
ss that=20
is all I really need, as an alternative (or kludge) to changing the sel=
ection=20
code.=20

>=20
> As I say, I'll need to re-read what we have said and compare again to
> the rfc ordering to work out if that is close to what you need but I =
had
> the impression it was.
I am now also thinking it is.

I will do the tests I promised (IPv6 address in map, with and without t=
he binaries
form your ppa) in the meantime.

> The remaining problem is that autofs will remove host addresses from =
the
> list if it thinks they are not responding.
That is a new one to me. You see how ignorant I unfortunately am of wha=
t is
actually happening in the machinery used to mount.=20

> Availability really must be checked because trying to mount from a ho=
st
> that isn't responding can result in lengthy delays which is really ba=
d
> for interactive use.

>=20
> This is the main reason for lengthy waits, the kernel RPC can't affor=
d
> to give up just because an RPC call takes longer than expected for fe=
ar
> of causing file system corruption for NFS mounts.
I never had to think about this, noticing only the final result which
simply works (thanks to all people who developed the software involved)=
=2E=20
If the server is really down it does not work of course, but with curre=
nt=20
kernels and soft mounts for non-homes that is only a minor problem (as=20
opposed to the lockups with nfs2/3 on 2.x kernels), provided that it is=
 not=20
the users home which is gone :-)

I use autofs primarily just as an abstraction layer when moving data ar=
ound,=20
not for failover or similar. =20

>=20
> But having said that, the availability check can be bypassed, if
> required, by setting single autofs configuration option.
Which option would that be ? I cannot find it ?

>=20
> Umm .. am I in close to what we've discussed or have I misunderstood?
Today I think you are.

>=20
> > having the possibility to pass IPv6 addresses as a result of an
> > exectutable map lookup (as is possible with IPv4 adresses) is what =
I
> > really=20
> > need.  I assume these two might be easier to do ? If I can pass IPv=
6
> > addresses=20
> > from the exectuable map I can shell script what I think I need
> > myselves. Of
> > course I still have to check if passing IPv6 is actually not possib=
le
> > as
> > I speculated earlier.
>=20
> Right, but AFAIK (and there might be problems with it) I think that i=
s a
> mater of address specification.
>=20
> The brackets vs. without brackets usage for example.
Even nfs(5) and exports(5) disagree. Pick one and document the
choice you like ?=20

> There's also the question of whether autofs handles link local addres=
ses
> properly, I think they can (or are required to) specify an interface =
as
> well.
Due to the fact that a host might present the same fe80:: address
on multiple or all of its interfaces most of all times an interface
specifier must be included so that routing selects the right link. Quit=
e some
tools and programs are broken or confusing from a users perspective han=
dling=20
this [1,2].

I understand that people will run autofs on link local addresses, thoug=
h.=20
ping6(8) and nfs(5) suggest "%interface" (with out without square brack=
ets).
So if the syntax is documented it should be less of a problem.

That is why I ignored link local in my previous mail, they should be
left alone (reserved for internal use by the network stack) IMO. You ca=
n
use ULAs if you do not have/want GUAs, that is one of their legitimate =
use=20
cases IMO !=20

>=20
> I haven't yet had a chance to study the logs you sent so I may get mo=
re
> information from them. Was there an example of this in those?
Only demonstrating the nfs(5) square bracket convention calling mount a=
nd no
brackets in other debug output:

Apr 27 16:27:21 core400 automount[2764]: get_nfs_info: called with host
core330(2001:638:708:1261:2000::118) proto 6 version 0x40
=2E..
Apr 27 16:28:00 core400 automount[2764]: mount_mount: mount(nfs):
calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev
[2001:638:708:1261:2000::118]:/locals /local/core330
=2E..
Apr 27 16:28:00 core400 automount[2764]: mount_mount: mount(nfs):
mounted [2001:638:708:1261:2000::118]:/locals on /local/core330
>=20
> I'm going to stop here because I think sorting out these two things
> needs to be done before re-assessing what the remaining situation is.
>=20

I will do the tests, rethink my approach  and try to understand mounts
behaviour then.=20

Thank you very much !


Best Regards

Christof

[1]
https://blogs.gentoo.org/eva/2010/12/17/things-you-didnt-known-about-ip=
v6-link-local-address/
https://bugzilla.redhat.com/show_bug.cgi?id=3D136852
[2] https://bugzilla.mozilla.org/show_bug.cgi?id=3D700999
http://forums.mozillazine.org/viewtopic.php?f=3D38&t=3D513822&start=3D0

--=20
Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-bre=
men.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen =20

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
