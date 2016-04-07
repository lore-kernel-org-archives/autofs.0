From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Thu, 7 Apr 2016 16:19:06 +0200
Message-ID: <20160407141906.GU15153@bccms.uni-bremen.de>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1460038748;
	bh=aEa94tGk6t4oIarqgfPHADDpuXKZmlMMXgyqh66AqNg=;
	h=Date:From:To:Reply-To;
	b=FWyLbZ2cQxAqIZEnTgsEFo1I3SdEi4AdM4hPNm+vsMQ58m1flTWOpaitwSXaIlfSp
	 kA6GcSwY+V9Gy1Rvrq1IbAI0BDpUvDRfo8kYFj8hUc2P9w6hvvQaBaH2Gw/rpyY6BY
	 7jRYrVBKHU5bmUmJf8z3P22CwT0O6DF0dN4HWuqc=
Content-Disposition: inline
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@vger.kernel.org

Hello everybody,

I am on ubuntu 14.04 with autofs 5.0.7 and I observe an (for me)
unexpected behaviour as detailed below. Apparently using autofs NFS4
mounts fall back to using IPv4 addresses although valid IPv6 addresses
are available under certain circumstances, while a plain mount works as
expected.

Setup:
------
Both, NFS server and client, are configured with an IPv4 address and an
IPv6 GUA and IPv6 ULA. For brevity I will shorten the IPv4 address to
192, the GUA to 2001 and the ULA to fd5f  below. I will only change the
DNS AAAA record in the following, the network configuration on
server/client or the A records never change. Server and client have
always working IPv4 and IPv6 GUA and ULA.

Test with mount:
----------------
Using a plain "mount  -t nfs4 server:/locals /mnt/disk1/" on the client
gives depending on the DNS entries for the server the expected
source/target selection:

Server DNS entry|	client address used to mount
2001		|	2001
fd5f		|	fd5f
2001+fd5f	|	fd5f

So in all cases RFC 6724/3484 is observed selecting the addresses.
Please note that the server has two AAAA records (multi-homed) in the
last test.

Test with autofs:
-----------------
A map lookup will yield "-fstype=3Dnfs4,rw,intr,nosuid,soft,nodev serve=
r:/locals"
for the mount. Now I change again the servers AAAA records with the
following result:

Server DNS entry|	client address used to mount
2001		|	2001
fd5f		|	fd5f
2001+fd5f	|	192

=46or a multi-homed NFS4 server autofs apparently falls back to IPv4
although valid IPv6 options exist. As shown above just mounting without
autofs would stick to RFC 6724/3484 instead. I believe that autofs shou=
ld=20
also select fd5f ULAs in the multi-homed case.

Is this a known behaviour ? Do any workarounds exist ? I could not find
anything.

I tried to compile autofs 5.1.1 with --with-libtirpc because
of https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1101779 but
could not get the binary to work. I filed a bug report for the behaviou=
r
described above https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1=
564380
but suspect that this is better suited for this list.

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
