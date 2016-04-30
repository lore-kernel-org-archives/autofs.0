From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sat, 30 Apr 2016 17:16:44 +0200
Message-ID: <20160430151644.GB31813@bccms.uni-bremen.de>
References: <1461722078.4208.31.camel@themaw.net>
 <20160427165250.GM30271@bccms.uni-bremen.de>
 <1461812190.3083.101.camel@themaw.net>
 <20160428091019.GO30271@bccms.uni-bremen.de>
 <1461840658.3063.18.camel@themaw.net>
 <20160428112648.GS30271@bccms.uni-bremen.de>
 <1461894846.3033.14.camel@themaw.net>
 <20160429141044.GA30271@bccms.uni-bremen.de>
 <1461986471.3848.84.camel@themaw.net>
 <20160430113600.GI30271@bccms.uni-bremen.de>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1462029406;
	bh=CAF0E1qS9Rvk+i2DQ4hs+qk/51PTuHF7elbGqW7IVpw=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=1PekDIatPDGfZZXawiChMGb7KC0rSBAXqjVmqIGnYlxrKHJyEJukGU7sOBe+Qs7vg
	 DwVkR9anOXqLBbBKS0CWM5EieMt5VqA8z6+sG0apg57qjg6BsLtf7GYm9wACchDwtH
	 ilcJ/FZ7svtp3sxLQwpmB9UsNaOiDi6Ksj83neCQ=
Content-Disposition: inline
In-Reply-To: <20160430113600.GI30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

And here is the log.

On Sat, Apr 30, 2016 at 01:36:00PM +0200, Christof Koehler wrote:
> Hello.
> 
> On Sat, Apr 30, 2016 at 11:21:11AM +0800, Ian Kent wrote:
> > On Fri, 2016-04-29 at 16:10 +0200, Christof Koehler wrote:
> > > Hello,
> > > 
> > > > 
> > > > Would that approach help with what you're trying to achieve?
> > > > 
> > > 
> > > I am not sure of anything right now anymore after noticing what mount 
> > > does. On top, I am not sure if I understand what you are proposing :-)
> > 
> > I'll need to review what we've said already for the problem with
> > mount.nfs(8).
> Just to be clear: I am not refering to the fallback to IPv4, that has
> indeed been covered, see below. I am refering to its stand alone, i.e. called
> by hand on the command line, behaviour to alternate between available IPv6 
> addresses. I did not observe this before and it makes me unsure if my
> initial request for autofs's behaviour might have been unreasonable.
> 
> > > 
> > > Independent of that maybe a) fixing the situation where
> > > autofs/mount falls back to IPv4, which I understand is a bug, and b)
> > 
> > Partly, the situation I described so far is, IPv6 won't work at all if
> > not using libtirpc, that's fixed by building autofs with libtirpc
> > support, no big deal there, we have that already.
> > 
> > I believe we originally started talking about IPv4 fall back because of
> > the lack of libtirpc support in Ubuntu autofs.
> Yes. 
> 
> Eventually the current behaviour could be documented as "working for
> now, not guaranteed to work at all without libtirpc in future releases" 
> as a compromise ?
> 
> It would have been helpful if the man page would have included a hint that
> libtirpc is a prerequisite for IPv6, similar to its mentioning in nfs(5) 
> (search "TI-RPC").
> 
> > There was also uncertainty about how mount.nfs(8) ends with an address.
> > Lets leave that alone for the moment.
> This is clearly not an autofs issue. I will probably ask
> somewhere else if I cannot find an answer myselves.
> 
> mount.nfs4(8) does not mentions IPv6 at all, and nfs(5) does not give
> any information about a possible address selection process.
> 
> > 
> > So I went looking and found that the order of addresses returned by
> > getaddrinfo(3) is in fact a modified rfc 3484 ordering.
> > 
> > I then responded saying this ordering may be sufficient, and a fairly
> > simple way to implement the needed address selection (and I mostly
> > ignored IPv4 with this suggestion).
> My problem is that I did/do not fully understand the details of the
> sorting process you decribed. Now just reading getaddrinfo(3) saying "The  
> sorting  function  used  within getaddrinfo()  is defined  in  RFC 3484" I would
> say that the list as returned by getaddrinfo should be what I wanted (I am not 
> sure what you mean with "modified", the tweaking of gai.conf ?).
> 
> That is why I tried to explain the big picture. For me it is important that it 
> consistently selects the ULA unless specifically instructed to do otherwise.
> 
> > Having done that adding an autofs configuration option to not use IPv4
> > addresses for hosts with multiple addresses should be sufficient to
> > force IPv6 only use. Also not difficult but I Think will have some
> > special cases to consider. I didn't mention this before because I
> > thought the first thing to resolve was address selection.
> For me the actual selection of an existing ULA above IPv4 and GUA is 
> "the big thing". 
> 
> If I can pass the right IPv6 address via an executable map bypassing 
> autofs's own selection mechanims (Why should it use that mechanism if it 
> gets an IP instead of a hostname ? Would it do it ? Have to try.) I guess that 
> is all I really need, as an alternative (or kludge) to changing the selection 
> code. 
> 
> > 
> > As I say, I'll need to re-read what we have said and compare again to
> > the rfc ordering to work out if that is close to what you need but I had
> > the impression it was.
> I am now also thinking it is.
> 
> I will do the tests I promised (IPv6 address in map, with and without the binaries
> form your ppa) in the meantime.
> 
> > The remaining problem is that autofs will remove host addresses from the
> > list if it thinks they are not responding.
> That is a new one to me. You see how ignorant I unfortunately am of what is
> actually happening in the machinery used to mount. 
> 
> > Availability really must be checked because trying to mount from a host
> > that isn't responding can result in lengthy delays which is really bad
> > for interactive use.
> 
> > 
> > This is the main reason for lengthy waits, the kernel RPC can't afford
> > to give up just because an RPC call takes longer than expected for fear
> > of causing file system corruption for NFS mounts.
> I never had to think about this, noticing only the final result which
> simply works (thanks to all people who developed the software involved). 
> If the server is really down it does not work of course, but with current 
> kernels and soft mounts for non-homes that is only a minor problem (as 
> opposed to the lockups with nfs2/3 on 2.x kernels), provided that it is not 
> the users home which is gone :-)
> 
> I use autofs primarily just as an abstraction layer when moving data around, 
> not for failover or similar.  
> 
> > 
> > But having said that, the availability check can be bypassed, if
> > required, by setting single autofs configuration option.
> Which option would that be ? I cannot find it ?
> 
> > 
> > Umm .. am I in close to what we've discussed or have I misunderstood?
> Today I think you are.
> 
> > 
> > > having the possibility to pass IPv6 addresses as a result of an
> > > exectutable map lookup (as is possible with IPv4 adresses) is what I
> > > really 
> > > need.  I assume these two might be easier to do ? If I can pass IPv6
> > > addresses 
> > > from the exectuable map I can shell script what I think I need
> > > myselves. Of
> > > course I still have to check if passing IPv6 is actually not possible
> > > as
> > > I speculated earlier.
> > 
> > Right, but AFAIK (and there might be problems with it) I think that is a
> > mater of address specification.
> > 
> > The brackets vs. without brackets usage for example.
> Even nfs(5) and exports(5) disagree. Pick one and document the
> choice you like ? 
> 
> > There's also the question of whether autofs handles link local addresses
> > properly, I think they can (or are required to) specify an interface as
> > well.
> Due to the fact that a host might present the same fe80:: address
> on multiple or all of its interfaces most of all times an interface
> specifier must be included so that routing selects the right link. Quite some
> tools and programs are broken or confusing from a users perspective handling 
> this [1,2].
> 
> I understand that people will run autofs on link local addresses, though. 
> ping6(8) and nfs(5) suggest "%interface" (with out without square brackets).
> So if the syntax is documented it should be less of a problem.
> 
> That is why I ignored link local in my previous mail, they should be
> left alone (reserved for internal use by the network stack) IMO. You can
> use ULAs if you do not have/want GUAs, that is one of their legitimate use 
> cases IMO ! 
> 
> > 
> > I haven't yet had a chance to study the logs you sent so I may get more
> > information from them. Was there an example of this in those?
> Only demonstrating the nfs(5) square bracket convention calling mount and no
> brackets in other debug output:
> 
> Apr 27 16:27:21 core400 automount[2764]: get_nfs_info: called with host
> core330(2001:638:708:1261:2000::118) proto 6 version 0x40
> ...
> Apr 27 16:28:00 core400 automount[2764]: mount_mount: mount(nfs):
> calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev
> [2001:638:708:1261:2000::118]:/locals /local/core330
> ...
> Apr 27 16:28:00 core400 automount[2764]: mount_mount: mount(nfs):
> mounted [2001:638:708:1261:2000::118]:/locals on /local/core330
> > 
> > I'm going to stop here because I think sorting out these two things
> > needs to be done before re-assessing what the remaining situation is.
> > 
> 
> I will do the tests, rethink my approach  and try to understand mounts
> behaviour then. 
> 
> Thank you very much !
> 
> 
> Best Regards
> 
> Christof
> 
> [1]
> https://blogs.gentoo.org/eva/2010/12/17/things-you-didnt-known-about-ipv6-link-local-address/
> https://bugzilla.redhat.com/show_bug.cgi?id=136852
> [2] https://bugzilla.mozilla.org/show_bug.cgi?id=700999
> http://forums.mozillazine.org/viewtopic.php?f=38&t=513822&start=0
> 
> -- 
> Dr. rer. nat. Christof Köhler       email: c.koehler@bccms.uni-bremen.de
> Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
> Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
> 28359 Bremen  
> 
> PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in

-- 
Dr. rer. nat. Christof Köhler       email: c.koehler@bccms.uni-bremen.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen  

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/

--J2SCkAp4GZ/dPZZf
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="pp.gz"
Content-Transfer-Encoding: base64

H4sICBHIJFcCA3BwAM1WUW+bMBB+36849SmRSGsHAgkSk7pJe5qmSd1bVSEKJqAAZrZpmn+/
sxPaVWsTCLTaS2Ib+L67+8539+m6FmAToK6/8HyygJgL5hACcicVK5NbeufDjYqEYgl8v/ni
w3WjeMmbSklI84Lt35PAK0hYGVXJ5aeXkKsnyKj98tahjo24UoXssc4F08tIMaBQRyqDq4LH
UdEdZw8S1oLHZmNWEAB1iOOtXGJTlyzt+SDwuGBR1dQ+rLkCleXJMXTjDtDzSWS+jrMiMQ/+
IUrzKpcZSyyQ21zFWV6tIRW8hDko3ocV4y9YlOyeV5NpK0UAR+JF7XFEPYYzWNQO4MNF7UMy
nqgn4n+mqM7boBle7ALFiOINUz6oXa3B7DMBwjKXEh0M8yrBCMUakW9YBa4FVVQyA2PbxALB
fjdMKqhRGoe6tDthpLAs1UqHEeNnHgGrlNgdfL86cHRHLDjfNHVoztrdBJNyLaJyuj/QbE0N
Y0Mf8GD2GWap1MEPqlQ6lthaObpkVVw2eWJJnipcJ+wBbueEUN+1l75Hlj6du9THE+L7lC7v
/H0EZHf76khI1ppnNhPZVFOTySgstgYTWv9/M2+Nuc4EmscxE3glfehk3wjMCSYuV2xy0cnV
i6nW9qOior8AnraaHWITdAqNhdkZByNbima9Zqc50ldKcCzPe1Rrf1pzNO+5TGwzrMydjLIO
GQDGzdZ3GCEVzKZ1w/xNkAPd0NYHhxaiq1vQXmdtddDL6uCF1cF7Wo2/TzwXbxJdYMHm91jG
A6JXclcWebXRG8GDHgVwjU0BGbEhpBwTNCoKvLTYBzPIuDwh7eTIwylgFcX678IDExKdAfLo
nG2XjsmDA6KOsSHpxpKXOOWQS2SjDj0X9bSHiISvIAVsWb7OFPTwoBZNxULNERa5RJElK7Dj
Ynhlcy+Z0oVAP5U4/+Alkk1dc6Hgx7cbBzgGDX59/TlCOmlJdcjKDXb88K8ZpH8fPs1hmv1M
mTsOMwkzDgN70XFjvZGmYe/cadhZrcjKWy7cQeBvTcOvor8+DXuDpuFnon7TsPcO0/CcjiPq
MZzBonYAHy5qH5LxRD0R/zNFXYwk6uI9RV18hKiLDxL1D6bcWERhEgAA

--J2SCkAp4GZ/dPZZf--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
