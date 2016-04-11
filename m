From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Mon, 11 Apr 2016 10:42:10 +0800
Message-ID: <1460342530.6494.31.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Tq+Kh+OW6Nt+GGqfEsAcx5Ou1sg=; b=hKBlcq
	hIkw14yGu3AOCqfW78lkhxPXi0ecHS2HMkh6JAHknf+eXoffyr5+nwG2xSErbdE3
	ckvcw7OGF0drraY4niswpOqvGmdv9kdaxKfe89UZhuG5Ukjhku6dMC0J/PtxOYgJ
	cddLZnzwncpV1YOBh/hZ7clhBeqqOJgPj2NKA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Tq+Kh+OW6Nt+GGq
	fEsAcx5Ou1sg=; b=Y3HwfUxtoK9uGF4qQmjUYlOlHj0kIoJI/NvAI88bjsX/vqY
	tesc9d8p4hIyalgTdVhsMuvgib9g4rWsEiOBTLj2QuaZdoag9162Bdl/X+cZivhE
	hKibG0OYaAx2RZxtPGCZHGe5fCNaaZ2NmFi9SmkkkxTGA0P+AegeKfmRXS+8=
In-Reply-To: <1460110224.2979.35.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Fri, 2016-04-08 at 18:10 +0800, Ian Kent wrote:
> On Fri, 2016-04-08 at 12:46 +0800, Ian Kent wrote:
> > On Thu, 2016-04-07 at 16:19 +0200, Christof Koehler wrote:
> > > Hello everybody,
> > > 
> > > I am on ubuntu 14.04 with autofs 5.0.7 and I observe an (for me)
> > > unexpected behaviour as detailed below. Apparently using autofs
> > > NFS4
> > > mounts fall back to using IPv4 addresses although valid IPv6
> > > addresses
> > > are available under certain circumstances, while a plain mount
> > > works
> > > as
> > > expected.
> > 
> > Can you provide a full debug log.
> > 
> > It might be autofs interfering with the mount but mount.nfs(8) is a
> > more
> > likely candidate.
> > 
> > > 
> > > Setup:
> > > ------
> > > Both, NFS server and client, are configured with an IPv4 address
> > > and
> > > an
> > > IPv6 GUA and IPv6 ULA. For brevity I will shorten the IPv4 address
> > > to
> > > 192, the GUA to 2001 and the ULA to fd5f  below. I will only
> > > change
> > > the
> > > DNS AAAA record in the following, the network configuration on
> > > server/client or the A records never change. Server and client
> > > have
> > > always working IPv4 and IPv6 GUA and ULA.
> > > 
> > > Test with mount:
> > > ----------------
> > > Using a plain "mount  -t nfs4 server:/locals /mnt/disk1/" on the
> > > client
> > > gives depending on the DNS entries for the server the expected
> > > source/target selection:
> > > 
> > > Server DNS entry|	client address used to mount
> > > 2001		|	2001
> > > fd5f		|	fd5f
> > > 2001+fd5f	|	fd5f
> > > 
> > > So in all cases RFC 6724/3484 is observed selecting the addresses.
> > > Please note that the server has two AAAA records (multi-homed) in
> > > the
> > > last test.
> > > 
> > > Test with autofs:
> > > -----------------
> > > A map lookup will yield "-fstype=nfs4,rw,intr,nosuid,soft,nodev
> > > server:/locals"
> > > for the mount. Now I change again the servers AAAA records with
> > > the
> > > following result:
> > > 
> > > Server DNS entry|	client address used to mount
> > > 2001		|	2001
> > > fd5f		|	fd5f
> > > 2001+fd5f	|	192
> > > 
> > > For a multi-homed NFS4 server autofs apparently falls back to IPv4
> > > although valid IPv6 options exist. As shown above just mounting
> > > without
> > > autofs would stick to RFC 6724/3484 instead. I believe that autofs
> > > should 
> > > also select fd5f ULAs in the multi-homed case.
> > > 
> > > Is this a known behaviour ? Do any workarounds exist ? I could not
> > > find
> > > anything.
> > > 
> > > I tried to compile autofs 5.1.1 with --with-libtirpc because
> > > of https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1101779 b
> > > ut
> > > could not get the binary to work. I filed a bug report for the
> > > behaviour
> > > described above 
> > > https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1564380
> > > but suspect that this is better suited for this list.
> 
> I've been thinking about this and I have a couple of thoughts.
> 
> As far a IPv6 goes using glibc RPC is, I think, not going to work!

I'm still trying to understand what happens here and I've only just now
looked at the logs you provided and compared to the source.

The first thing that stands out is that if libtirpc is not being used
all IPv6 hosts will be ignored because (my impression is that) glibc RPC
doesn't support IPv6.

Basically the get_proximity() function will return PROXIMITY_UNSUPPORTED
due to:

	case AF_INET6:
#ifndef WITH_LIBTIRPC
                return PROXIMITY_UNSUPPORTED;
#else

and the add_new_host() function will not add the host to the hosts list
due to:

        /*
         * If we tried to add an IPv6 address and we don't have IPv6
         * support return success in the hope of getting an IPv4
         * address later.
         */
        if (prx == PROXIMITY_UNSUPPORTED)
                return 1;

And the log doesn't give any hint as to what's happening.

The only thing that the log shows is that in 2001 autofs thinks there is
a single IPv4 address so it attempts to mount using the host name as it
should.

But in ipv4 autofs is using the IPv4 address which implies it thinks
there is more than one (IPv4) address for the host being considered so
it uses the IP address for the mount.

There's appears to be an autofs problem with this later case because (I
think) your description implies there is only one IPv4 address in all
cases.

Not only that, in both cases only one address has proximity calculated
for it which also implies there is only one address. So if there was no
mistake in the code it should also use the host name for the later
mount.

It's mount.nfs(8) mounting from the IPv6 address (when given a host name
not an address) in the former case and not autofs that's getting you an
IPv6 mount. And, AFAICS, the mount.nfs your using does use libtirpc.

Finally, if libtirpc is used there is no preference given to IPv6 over
IPv4 which may not be what is expected and might not be what should be
done.

But we can't really start to work out what needs to be done unless
libtirpc is being used.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
