From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Mon, 02 May 2016 14:01:42 +0800
Message-ID: <1462168902.2983.72.camel@themaw.net>
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
	 <20160430113600.GI30271@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=mya7BbmKq5Gw+GZ6j8aTT+ImW0c=; b=Dgamo2
	oLBCBsgDtEF1sokqoM3WaWTnKHzGRYS1U44MVGyp35icYjhLe6XipeU7pEX8bUeg
	csDv3K11/+364ZKUKOSI8QDyY6N/LUkDUyd98+cjQ0NmUcy+1cBjBP0jVXD4G4Nf
	kuI7nJDwpuYBgAL11CJvQg7j29Szxjf1kpKIQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=mya7BbmKq5Gw+GZ
	6j8aTT+ImW0c=; b=igBwyHSOYi59H1g9NYCdfnR51uMO1bbEKvYeD/3ck1z5Uv7
	iviz9XAduHRd0Tdo0ZGm52Ln4viSY2O9gcaIamA60qFNWwXmSh1X3PVOjIJj9DMn
	AUOLREDgBHpnaWERdkfbxldGVNSZCMgoTQwk3TnuQ0Pvciu1/XIUoyCHGAfw=
In-Reply-To: <20160430113600.GI30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Sat, 2016-04-30 at 13:36 +0200, Christof Koehler wrote:
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
> > > I am not sure of anything right now anymore after noticing what
> > > mount 
> > > does. On top, I am not sure if I understand what you are proposing
> > > :-)
> > 
> > I'll need to review what we've said already for the problem with
> > mount.nfs(8).
> Just to be clear: I am not refering to the fallback to IPv4, that has
> indeed been covered, see below. I am refering to its stand alone, i.e.
> called
> by hand on the command line, behaviour to alternate between available
> IPv6 
> addresses. I did not observe this before and it makes me unsure if my
> initial request for autofs's behaviour might have been unreasonable.
> 
> > > 
> > > Independent of that maybe a) fixing the situation where
> > > autofs/mount falls back to IPv4, which I understand is a bug, and
> > > b)
> > 
> > Partly, the situation I described so far is, IPv6 won't work at all
> > if
> > not using libtirpc, that's fixed by building autofs with libtirpc
> > support, no big deal there, we have that already.
> > 
> > I believe we originally started talking about IPv4 fall back because
> > of
> > the lack of libtirpc support in Ubuntu autofs.
> Yes. 
> 
> Eventually the current behaviour could be documented as "working for
> now, not guaranteed to work at all without libtirpc in future
> releases" 
> as a compromise ?

I'll update the man pages to talk about libtirpc.
In particular I'll say that libtirpc is required for IPv6.

I think the address order change I mentioned is needed regardless
because the implementation I have is insufficient.

I didn't have time and didn't go looking for more information when I
implemented it (which was quite a while ago now), assuming I would
update it when it started being used based on discussion and
investigation at that time (and it seems it is that time now).

> 
> It would have been helpful if the man page would have included a hint
> that
> libtirpc is a prerequisite for IPv6, similar to its mentioning in
> nfs(5) 
> (search "TI-RPC").

Yes, that detail was lost in the effort of implementation, sadly many
things can get missed due to this.

But IPv6 wasn't the only reason for changing to libtirpc.
The glibc RPC code was to be deprecated and (I believe) the glibc
maintainers didn't want to continue to maintain it.

> 
> > There was also uncertainty about how mount.nfs(8) ends with an
> > address.
> > Lets leave that alone for the moment.
> This is clearly not an autofs issue. I will probably ask
> somewhere else if I cannot find an answer myselves.
> 
> mount.nfs4(8) does not mentions IPv6 at all, and nfs(5) does not give
> any information about a possible address selection process.

And, after having a quick look I see that it doesn't do anything special
wrt. address selection.

I only looked at code concerned with option strings (interpret as option
strings that are passed directly to the kernel at mount, the most common
method used by mount.nfs(8), even for not so new kernels nowadays) and
it just uses the first address in the list returned by getaddrinfo(3).

I checked nfs-utils versions 1.3.3 and 1.2.6, they were essentially the
same in this respect.

What I didn't see is trying different addresses over retry on failure
but mount.nfs(8) has never claimed to do that.

> 
> > 
> > So I went looking and found that the order of addresses returned by
> > getaddrinfo(3) is in fact a modified rfc 3484 ordering.
> > 
> > I then responded saying this ordering may be sufficient, and a
> > fairly
> > simple way to implement the needed address selection (and I mostly
> > ignored IPv4 with this suggestion).
> My problem is that I did/do not fully understand the details of the
> sorting process you decribed. Now just reading getaddrinfo(3) saying
> "The  
> sorting  function  used  within getaddrinfo()  is defined  in  RFC
> 3484" I would
> say that the list as returned by getaddrinfo should be what I wanted
> (I am not 
> sure what you mean with "modified", the tweaking of gai.conf ?).

I arrived at this by, looking again at the man page, going to the glibc
source for getaddrinfo(3), and checking results of a Google search.

The glibc source clearly uses a function with rfc 3484 as part of its
name so I assume it tries to implement that selection sorting procedure.

I also saw a few mailing list posts that implied the selection had been
modified over time and there was mention of rfc 6724 in some posts.

So that lead me to think that minor changes had been made due to real
world situations and that, since rfc 6724 had come up, and the glibc
folks are standards aware, that some changes had been made based on that
too.

Just what is actually implemented is a somewhat larger task that I'd
rather not pursue, ;)
 
> 
> That is why I tried to explain the big picture. For me it is important
> that it 
> consistently selects the ULA unless specifically instructed to do
> otherwise.
> 
> > Having done that adding an autofs configuration option to not use
> > IPv4
> > addresses for hosts with multiple addresses should be sufficient to
> > force IPv6 only use. Also not difficult but I Think will have some
> > special cases to consider. I didn't mention this before because I
> > thought the first thing to resolve was address selection.
> For me the actual selection of an existing ULA above IPv4 and GUA is 
> "the big thing". 
> 
> If I can pass the right IPv6 address via an executable map bypassing 
> autofs's own selection mechanims (Why should it use that mechanism if
> it 
> gets an IP instead of a hostname ? Would it do it ? Have to try.) I
> guess that 
> is all I really need, as an alternative (or kludge) to changing the
> selection 
> code. 

I can help with that if there are any problems.

I don't think I require square brackets on IPv6 addresses but they
shouldn't cause the mount to fail either, if they are present.

It's a little hard to work out actually because the parsing code for sun
format mount maps (but not the master map) is in several different
locations (a background task I have is to change this to a YACC parser
and do almost all the parsing in one place).

I do add them for utilities that need them if they aren't present, such
as mount.

That might need to change for the sake of consistency, not sure.

If an IP address is used then the mount "host" doesn't have multiple
addresses as far as autofs is concerned but autofs will still check the
host is responding to avoid lengthy delays (but see below).

> 
> > 
> > As I say, I'll need to re-read what we have said and compare again
> > to
> > the rfc ordering to work out if that is close to what you need but I
> > had
> > the impression it was.
> I am now also thinking it is.
> 
> I will do the tests I promised (IPv6 address in map, with and without
> the binaries
> form your ppa) in the meantime.
> 
> > The remaining problem is that autofs will remove host addresses from
> > the
> > list if it thinks they are not responding.
> That is a new one to me. You see how ignorant I unfortunately am of
> what is
> actually happening in the machinery used to mount. 

LOL, right, but that's a direct consequence of the lengthy delays I've
spoken about.

The list is constructed on the fly at mount time and those that don't
respond are removed leaving only hosts (or addresses) that need a mount
to be attempted.

That's why you see the "no hosts available" message sometimes which has
been a problem at times as it tends to appear when things aren't working
as needed or expected.

There's no monitor thread that updates previously seen hosts
availability (as there is in amd, but that application will probably
never support IPv6).

> > Availability really must be checked because trying to mount from a
> > host
> > that isn't responding can result in lengthy delays which is really
> > bad
> > for interactive use.
> 
> > 
> > This is the main reason for lengthy waits, the kernel RPC can't
> > afford
> > to give up just because an RPC call takes longer than expected for
> > fear
> > of causing file system corruption for NFS mounts.
> I never had to think about this, noticing only the final result which
> simply works (thanks to all people who developed the software
> involved). 
> If the server is really down it does not work of course, but with
> current 
> kernels and soft mounts for non-homes that is only a minor problem (as
> opposed to the lockups with nfs2/3 on 2.x kernels), provided that it
> is not 
> the users home which is gone :-)
> 
> I use autofs primarily just as an abstraction layer when moving data
> around, 
> not for failover or similar.  

Right.

> > 
> > But having said that, the availability check can be bypassed, if
> > required, by setting single autofs configuration option.
> Which option would that be ? I cannot find it ?

I was going to say, if you specify a sensible value for mount_wait the
probing won't be done, but I see in the code that's not quite true. If
we have more than one non-local address in the list the probe may still
get done.

But setting a value for mount_wait other than the default of -1 and
ensuring there is only one value in the list of hosts (such as when
using an address) the probe will not be done. Otherwise the probe is
done.

As can be seen here:
        /*
         * Check for either a list containing only proximity local hosts
         * or a single host entry whose proximity isn't local. If so
         * return immediately as we don't want to add probe latency for
         * the common case of a single filesystem mount request.
         *
         * But, if the kernel understands text nfs mount options then
         * mount.nfs most likely bypasses its probing and lets the kernel
         * do all the work. This can lead to long timeouts for hosts that
         * are not available so check the kernel version and mount.nfs
         * version and probe singleton mounts if the kernel version is
         * greater than 2.6.22 and mount.nfs version is greater than 1.1.1.
         * But also allow the MOUNT_WAIT configuration parameter to override
         * the probing.
         */
        if (nfs_mount_uses_string_options &&
            defaults_get_mount_wait() == -1 &&
           (kern_vers = linux_version_code()) > KERNEL_VERSION(2, 6, 22)) {
                if (!this)
                        return 1;
        } else {
                if (!this || !this->next)
                        return 1;
        }

But since a patch in the Debian autofs package changes the kernel
version check code (removes it) I will need to check the maintainer
patch doesn't interfere with this case.

> 
> > 
> > Umm .. am I in close to what we've discussed or have I
> > misunderstood?
> Today I think you are.
> 
> > 
> > > having the possibility to pass IPv6 addresses as a result of an
> > > exectutable map lookup (as is possible with IPv4 adresses) is what
> > > I
> > > really 
> > > need.  I assume these two might be easier to do ? If I can pass
> > > IPv6
> > > addresses 
> > > from the exectuable map I can shell script what I think I need
> > > myselves. Of
> > > course I still have to check if passing IPv6 is actually not
> > > possible
> > > as
> > > I speculated earlier.
> > 
> > Right, but AFAIK (and there might be problems with it) I think that
> > is a
> > mater of address specification.
> > 
> > The brackets vs. without brackets usage for example.
> Even nfs(5) and exports(5) disagree. Pick one and document the
> choice you like ? 
> 
> > There's also the question of whether autofs handles link local
> > addresses
> > properly, I think they can (or are required to) specify an interface
> > as
> > well.
> Due to the fact that a host might present the same fe80:: address
> on multiple or all of its interfaces most of all times an interface
> specifier must be included so that routing selects the right link.
> Quite some
> tools and programs are broken or confusing from a users perspective
> handling 
> this [1,2].
> 
> I understand that people will run autofs on link local addresses,
> though. 
> ping6(8) and nfs(5) suggest "%interface" (with out without square
> brackets).
> So if the syntax is documented it should be less of a problem.
> 
> That is why I ignored link local in my previous mail, they should be
> left alone (reserved for internal use by the network stack) IMO. You
> can
> use ULAs if you do not have/want GUAs, that is one of their legitimate
> use 
> cases IMO ! 
> 
> > 
> > I haven't yet had a chance to study the logs you sent so I may get
> > more
> > information from them. Was there an example of this in those?
> Only demonstrating the nfs(5) square bracket convention calling mount
> and no
> brackets in other debug output:
> 
> Apr 27 16:27:21 core400 automount[2764]: get_nfs_info: called with
> host
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
> > needs to be done before re-assessing what the remaining situation
> > is.
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
> https://blogs.gentoo.org/eva/2010/12/17/things-you-didnt-known-about-i
> pv6-link-local-address/
> https://bugzilla.redhat.com/show_bug.cgi?id=136852
> [2] https://bugzilla.mozilla.org/show_bug.cgi?id=700999
> http://forums.mozillazine.org/viewtopic.php?f=38&t=513822&start=0
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
