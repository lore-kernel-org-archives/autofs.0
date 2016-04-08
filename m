From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 8 Apr 2016 13:47:06 +0200
Message-ID: <20160408114706.GV15153@bccms.uni-bremen.de>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
 <1460090760.3135.53.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PxDrs/Fpf4pPiewX"
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1460116028;
	bh=zm6e+lwjJyBbSAyoh5HnNRE8HFMV917SDARJrYQTDXE=;
	h=Date:From:To:Reply-To:References:In-Reply-To;
	b=hF2CRsNrb/z41hi5Eb3ndvS4G/c+g8/whBPzEJKv0YwBbOv3f8COfRM+3pln0n/xS
	 lW3cGCPSqN5COyun0/YLTYfNnTZzTukS3UttVQki/QVFNwcVsClxQA8LjVZSBcatP3
	 BCgR1mHIfdyqsHVA+bm7KxamiIvyZF7G2UwThXDk=
Content-Disposition: inline
In-Reply-To: <1460090760.3135.53.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org


--PxDrs/Fpf4pPiewX
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I will provide logs (syslog, passing "debug" to automount) and additional information 
first with this email and comment on my attempts to build a new autofs
later. 

The file ipv4.txt.gz contains the log for a situation where
server and client have GUA and ULA and autofs falls back to IPv4. The
file 2001.txt.gz contains the log for a mount via 2001 GUA in a
situation where server and client have only GUA entries in DNS. The
mount in question is /local/core330.

At the bottom is some more information probably necessary to understand the
attached logs.

If you need some other debug output please let me know how to get it.

As far as I can see the main difference is that in 2001.txt.gz we have
Apr  8 13:31:49 core324 automount[18359]: mount_mount: mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev core330:/locals /local/core330

and in ipv4.txt.gz
Apr  8 13:27:05 core324 automount[18359]: mount_mount: mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev 192.168.220.118:/locals /local/core330


Also, I did some more tests using just mount. Just to demonstrate what
the behaviour of mount is. Please observe the result in the last
situation (number 5), there is some round robin (?) behaviour involved I did not expect.
I remember that for multi-homed IPv4 the DNS would resolve randomly one
or the other address. Might be the same for IPv6 ?

To stress the point: I am always only changing DNS AAAA records, not
the machines actual network configuration.

1. Server with 2001 and fd5f, client with 2001:
  mount -v  -t nfs4 core330:/locals /mnt/disk1/
  mount.nfs4: trying text-based options 'addr=fd5f:852:a27c:1261:2000::118,clientaddr=fd5f:852:a27c:1261:2000::104'

2. Server with 2001, client with 2001:
  mount.nfs4: trying text-based options 'addr=2001:638:708:1261:2000::118,clientaddr=2001:638:708:1261:2000::104'

3. Server with 2001, client with 2001 and fd5f:
  mount.nfs4: trying text-based options 'addr=2001:638:708:1261:2000::118,clientaddr=2001:638:708:1261:2000::104'

4. Server with fd5f, client with fd5f:
  mount.nfs4: trying text-based options 'addr=fd5f:852:a27c:1261:2000::118,clientaddr=fd5f:852:a27c:1261:2000::104'

5. Server with 2001 and fd5f, client with 2001 and fd5f: Mounting repeatedly I see both !
  mount.nfs4: trying text-based options 'addr=fd5f:852:a27c:1261:2000::118,clientaddr=fd5f:852:a27c:1261:2000::104'
  mount.nfs4: trying text-based options 'addr=2001:638:708:1261:2000::118,clientaddr=2001:638:708:1261:2000::104'


Best Regards

Christof

The logs contain output for the addtitonal mountpoints /sge, /home and
eventually /usr/local, these are not relevant but in a production environment 
I cannot remove them.

The server in question is core330.bccms.uni-bremen.de, the client is
core324.bccms.uni-bremen.de. 

A dig of the server from the client gives either
core330.bccms.uni-bremen.de. 604800 IN  AAAA 2001:638:708:1261:2000::118
core330.bccms.uni-bremen.de. 604800 IN  AAAA fd5f:852:a27c:1261:2000::118
core330.bccms.uni-bremen.de. 604800 IN  A       192.168.220.118
or without the fd5f ULA.

The client is either
core324.bccms.uni-bremen.de. 604800 IN  AAAA fd5f:852:a27c:1261:2000::104
core324.bccms.uni-bremen.de. 604800 IN  AAAA 2001:638:708:1261:2000::104
core324.bccms.uni-bremen.de. 604800 IN  A       192.168.220.104
or without the fd5f ULA.

I should probably point out that we have a custom addresslabel in place on server
and client to prevent usage of privacy adresses:

root@core324:~# ip -6 addrlabel
prefix ::1/128 label 0 
prefix 2001:638:708:1261:2000::/96 label 99 
prefix 2001:638:708:1261:1000::/96 label 99 
prefix ::/96 label 3 
prefix ::ffff:0.0.0.0/96 label 4 
prefix 2001::/32 label 6 
prefix 2001:10::/28 label 7 
prefix 3ffe::/16 label 12 
prefix 2002::/16 label 2 
prefix fec0::/10 label 11 
prefix fc00::/7 label 5 
prefix ::/0 label 1



On Fri, Apr 08, 2016 at 12:46:00PM +0800, Ian Kent wrote:
> On Thu, 2016-04-07 at 16:19 +0200, Christof Koehler wrote:
> > Hello everybody,
> > 
> > I am on ubuntu 14.04 with autofs 5.0.7 and I observe an (for me)
> > unexpected behaviour as detailed below. Apparently using autofs NFS4
> > mounts fall back to using IPv4 addresses although valid IPv6 addresses
> > are available under certain circumstances, while a plain mount works
> > as
> > expected.
> 
> Can you provide a full debug log.
> 
> It might be autofs interfering with the mount but mount.nfs(8) is a more
> likely candidate.
> 
> > 
> > Setup:
> > ------
> > Both, NFS server and client, are configured with an IPv4 address and
> > an
> > IPv6 GUA and IPv6 ULA. For brevity I will shorten the IPv4 address to
> > 192, the GUA to 2001 and the ULA to fd5f  below. I will only change
> > the
> > DNS AAAA record in the following, the network configuration on
> > server/client or the A records never change. Server and client have
> > always working IPv4 and IPv6 GUA and ULA.
> > 
> > Test with mount:
> > ----------------
> > Using a plain "mount  -t nfs4 server:/locals /mnt/disk1/" on the
> > client
> > gives depending on the DNS entries for the server the expected
> > source/target selection:
> > 
> > Server DNS entry|	client address used to mount
> > 2001		|	2001
> > fd5f		|	fd5f
> > 2001+fd5f	|	fd5f
> > 
> > So in all cases RFC 6724/3484 is observed selecting the addresses.
> > Please note that the server has two AAAA records (multi-homed) in the
> > last test.
> > 
> > Test with autofs:
> > -----------------
> > A map lookup will yield "-fstype=nfs4,rw,intr,nosuid,soft,nodev
> > server:/locals"
> > for the mount. Now I change again the servers AAAA records with the
> > following result:
> > 
> > Server DNS entry|	client address used to mount
> > 2001		|	2001
> > fd5f		|	fd5f
> > 2001+fd5f	|	192
> > 
> > For a multi-homed NFS4 server autofs apparently falls back to IPv4
> > although valid IPv6 options exist. As shown above just mounting
> > without
> > autofs would stick to RFC 6724/3484 instead. I believe that autofs
> > should 
> > also select fd5f ULAs in the multi-homed case.
> > 
> > Is this a known behaviour ? Do any workarounds exist ? I could not
> > find
> > anything.
> > 
> > I tried to compile autofs 5.1.1 with --with-libtirpc because
> > of https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1101779 but
> > could not get the binary to work. I filed a bug report for the
> > behaviour
> > described above 
> > https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1564380
> > but suspect that this is better suited for this list.
> > 
> > Best Regards
> > 
> > Christof
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in

-- 
Dr. rer. nat. Christof Köhler       email: c.koehler@bccms.uni-bremen.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen  

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/

--PxDrs/Fpf4pPiewX
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="ipv4.txt.gz"
Content-Transfer-Encoding: base64

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

--PxDrs/Fpf4pPiewX
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="2001.txt.gz"
Content-Transfer-Encoding: base64

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
JyWbJyGb85DFCln9D1PgsWbi4gAA

--PxDrs/Fpf4pPiewX--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
