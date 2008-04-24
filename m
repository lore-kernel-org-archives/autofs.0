From: "Young, Darren" <Darren.Young@chicagogsb.edu>
Subject: Re: LDAP Server
Date: Thu, 24 Apr 2008 17:20:59 -0500
Message-ID: <07A371D457B501478C1DB3C3DE8372D701783ADC@GSBHEX2V.gsb.uchicago.edu>
References: <07A371D457B501478C1DB3C3DE8372D701783790@GSBHEX2V.gsb.uchicago.edu>
	<x49wsmngmjq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017837DC@GSBHEX2V.gsb.uchicago.edu>
	<x49skxbgll7.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D70178387D@GSBHEX2V.gsb.uchicago.edu>
	<x49lk33giw0.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017838DA@GSBHEX2V.gsb.uchicago.edu>
	<x493apbghkr.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D701783912@GSBHEX2V.gsb.uchicago.edu>
	<x49mynjezqq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D701783ACF@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <07A371D457B501478C1DB3C3DE8372D701783ACF@GSBHEX2V.gsb.uchicago.edu>
Content-class: urn:content-classes:message
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
To: "Young, Darren" <darren.young@gsb.uchicago.edu>, Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Think I might have found the problem. Sun DS side:

[24/Apr/2008:17:17:03 -0500] conn=933393 op=-1 msgId=-1 - fd=159
slot=159 LDAP connection from 128.135.211.58 to 128.135.211.132
[24/Apr/2008:17:17:03 -0500] conn=933393 op=0 msgId=1 - BIND dn=""
method=sasl version=3 mech=DIGEST-MD5
[24/Apr/2008:17:17:03 -0500] conn=933393 op=0 msgId=1 - RESULT err=14
tag=97 nentries=0 etime=0, SASL bind in progress
[24/Apr/2008:17:17:03 -0500] conn=933393 op=1 msgId=2 - BIND dn=""
method=sasl version=3 mech=DIGEST-MD5
[24/Apr/2008:17:17:03 -0500] conn=933393 op=1 msgId=2 - RESULT err=49
tag=97 nentries=0 etime=0 
[24/Apr/2008:17:17:03 -0500] conn=933393 op=2 msgId=3 - UNBIND
[24/Apr/2008:17:17:03 -0500] conn=933393 op=2 msgId=-1 - closing - U1
[24/Apr/2008:17:17:03 -0500] conn=933393 op=-1 msgId=-1 - closed.

Found a post about a "dn mangling" bug in DS 5.2 that appears to look
like that access log entry.

> -----Original Message-----
> From: autofs-bounces@linux.kernel.org [mailto:autofs-
> bounces@linux.kernel.org] On Behalf Of Young, Darren
> Sent: Thursday, April 24, 2008 5:16 PM
> To: Jeff Moyer
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] LDAP Server
> 
> So in fact that rpm wasn't installed, it is now. During startup I now
> see:
> 
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: Starting automounter
> version 5.0.1-0.rc2.55, master map auto.master
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: using kernel protocol
> version 5.00
> Apr 24 16:23:44 gsbtestfilervm automount[9111]:
lookup_nss_read_master:
> reading master files auto.master
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: parse_init:
parse(sun):
> init gathered global options: (null)
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: mount_init:
> mount(bind):
> bind_works = 1
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: lookup_read_master:
> lookup(file): read entry /misc
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: lookup_read_master:
> lookup(file): read entry /net
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: lookup_read_master:
> lookup(file): read entry +auto.master
> Apr 24 16:23:44 gsbtestfilervm automount[9111]:
lookup_nss_read_master:
> reading master files auto.master
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: parse_init:
parse(sun):
> init gathered global options: (null)
> Apr 24 16:23:44 gsbtestfilervm automount[9111]:
lookup_nss_read_master:
> reading master ldap auto.master
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: parse_server_string:
> lookup(ldap): Attempting to parse LDAP information from string
> "auto.master".
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: parse_server_string:
> lookup(ldap): mapname auto.master
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: parse_ldap_config:
ldap
> authentication configured with the following options:
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: parse_ldap_config:
> use_tls: 0, tls_required: 0, auth_required: 2, sasl_mech: DIGEST-MD5
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: parse_ldap_config:
> user:
> cn=Directory Manager, secret: specified, client principal: (null)
> Apr 24 16:23:44 gsbtestfilervm automount[9111]: sasl_bind_mech:
> Attempting sasl bind with mechanism DIGEST-MD5
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: sasl_log_func:
> DIGEST-MD5 client step 2
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: getuser_func: called
> with context (nil), id 16386.
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: getuser_func: called
> with context (nil), id 16385.
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: getpass_func: context
> (nil), id 16388
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: do_sasl_bind: Error
> parsing response to sasl_bind request: Invalid credentials.
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: do_sasl_bind: The LDAP
> server indicated that the LDAP SASL bind was incomplete, but did not
> provide the required data to proceed. LDAP SASL bind with mechanism
> DIGEST-MD5 failed.
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: sasl_bind_mech: sasl
> bind with mechanism DIGEST-MD5 failed
> Apr 24 16:23:45 gsbtestfilervm automount[9111]:
unbind_ldap_connection:
> use_tls: 0
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: lookup_init:
> lookup(ldap): cannot initialize authentication setup
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: lookup_read_master:
> lookup(file): failed to read included master map auto.master
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: master_do_mount:
> mounting /misc
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: lookup_nss_read_map:
> reading map file /etc/auto.misc
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: parse_init:
parse(sun):
> init gathered global options: (null)
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: mount_init:
> mount(bind):
> bind_works = 1
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: mounted indirect mount
> on /misc with timeout 300, freq 75 seconds
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: master_do_mount:
> mounting /net
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: lookup_nss_read_map:
> reading map hosts (null)
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: parse_init:
parse(sun):
> init gathered global options: (null)
> Apr 24 16:23:45 gsbtestfilervm automount[9111]: mounted indirect mount
> on /net with timeout 300, freq 75 seconds
> 
> Tcpdump shows:
> 
> 16:21:09.916465 IP (tos 0x0, ttl  64, id 16351, offset 0, flags [DF],
> proto: TCP (6), length: 146) 128.135.211.58.40186 >
> gsbids1.uchicago.edu.ldap: P, cksum 0xfdee (correct),
> 3897304996:3897305090(94) ack 1276633679 win 46 <nop,nop,timestamp
> 67442952 1159496622>
>         0x0000:  4500 0092 3fdf 4000 4006 52b9 8087 d33a
> E...?.@.@.R....:
>         0x0010:  8087 d384 9cfa 0185 e84c 27a4 4c17 e24f
> .........L'.L..O
>         0x0020:  8018 002e fdee 0000 0101 080a 0405 1908
> ................
>         0x0030:  451c 83ae 305c 0201 0363 5704 186f 3d67
> E...0\...cW..o=g
>         0x0040:  7362 2c64 633d 7563 6869 6361 676f 2c64
> sb,dc=uchicago,d
>         0x0050:  633d 6564 750a 0102 0a01 0002 0101 0201
> c=edu...........
>         0x0060:  7801 0100 a02a a31b 040b 6f62 6a65 6374
> x....*....object
>         0x0070:  436c 6173 7304 0c70 6f73 6978 4163 636f
> Class..posixAcco
>         0x0080:  756e 74a3 0b04 0375 6964 0404 7063 6170
> unt....uid..pcap
>         0x0090:  3000                                     0.
> 16:21:09.927759 IP (tos 0x0, ttl  60, id 4465, offset 0, flags [DF],
> proto: TCP (6), length: 66) gsbids1.uchicago.edu.ldap >
> 128.135.211.58.40186: P, cksum 0x05fe (correct), 1:15(14) ack 94 win
> 49232 <nop,nop,timestamp 1159496623 67442952>
>         0x0000:  4500 0042 1171 4000 3c06 8577 8087 d384
> E..B.q@.<..w....
>         0x0010:  8087 d33a 0185 9cfa 4c17 e24f e84c 2802
> ...:....L..O.L(.
>         0x0020:  8018 c050 05fe 0000 0101 080a 451c 83af
> ...P........E...
>         0x0030:  0405 1908 300c 0201 0365 070a 0100 0400
> ....0....e......
>         0x0040:  0400                                     ..
> 16:21:09.928180 IP (tos 0x0, ttl  64, id 16352, offset 0, flags [DF],
> proto: TCP (6), length: 161) 128.135.211.58.40186 >
> gsbids1.uchicago.edu.ldap: P, cksum 0xf6f8 (correct), 94:203(109) ack
> 15
> win 46 <nop,nop,timestamp 67442956 1159496623>
>         0x0000:  4500 00a1 3fe0 4000 4006 52a9 8087 d33a
> E...?.@.@.R....:
>         0x0010:  8087 d384 9cfa 0185 e84c 2802 4c17 e25d
> .........L(.L..]
>         0x0020:  8018 002e f6f8 0000 0101 080a 0405 190c
> ................
>         0x0030:  451c 83af 306b 0201 0463 6604 186f 3d67
> E...0k...cf..o=g
>         0x0040:  7362 2c64 633d 7563 6869 6361 676f 2c64
> sb,dc=uchicago,d
>         0x0050:  633d 6564 750a 0102 0a01 0002 0100 0201
> c=edu...........
>         0x0060:  7801 0100 a02e a319 040b 6f62 6a65 6374
> x.........object
>         0x0070:  436c 6173 7304 0a70 6f73 6978 4772 6f75
> Class..posixGrou
>         0x0080:  70a3 1104 096d 656d 6265 7255 6964 0404
> p....memberUid..
>         0x0090:  7063 6170 300b 0409 6769 644e 756d 6265
> pcap0...gidNumbe
>         0x00a0:  72                                       r
> 16:21:09.928794 IP (tos 0x0, ttl  60, id 4466, offset 0, flags [DF],
> proto: TCP (6), length: 66) gsbids1.uchicago.edu.ldap >
> 128.135.211.58.40186: P, cksum 0x047f (correct), 15:29(14) ack 203 win
> 49232 <nop,nop,timestamp 1159496623 67442956>
>         0x0000:  4500 0042 1172 4000 3c06 8576 8087 d384
> E..B.r@.<..v....
>         0x0010:  8087 d33a 0185 9cfa 4c17 e25d e84c 286f
> ...:....L..].L(o
>         0x0020:  8018 c050 047f 0000 0101 080a 451c 83af
> ...P........E...
>         0x0030:  0405 190c 300c 0201 0465 070a 0100 0400
> ....0....e......
>         0x0040:  0400                                     ..
> 16:21:09.951506 IP (tos 0x0, ttl  64, id 16353, offset 0, flags [DF],
> proto: TCP (6), length: 52) 128.135.211.58.40186 >
> gsbids1.uchicago.edu.ldap: ., cksum 0x0afb (correct), ack 29 win 46
> <nop,nop,timestamp 67442999 1159496623>
>         0x0000:  4500 0034 3fe1 4000 4006 5315 8087 d33a
> E..4?.@.@.S....:
>         0x0010:  8087 d384 9cfa 0185 e84c 286f 4c17 e26b
> .........L(oL..k
>         0x0020:  8010 002e 0afb 0000 0101 080a 0405 1937
> ...............7
>         0x0030:  451c 83af                                E...
> 16:21:13.453371 IP (tos 0x0, ttl  64, id 34773, offset 0, flags [DF],
> proto: TCP (6), length: 60) 128.135.211.58.40187 >
> gsbids1.uchicago.edu.ldap: S, cksum 0x3649 (correct),
> 3900285239:3900285239(0) win 5840 <mss 1460,sackOK,timestamp 67446498
> 0,nop,wscale 7>
>         0x0000:  4500 003c 87d5 4000 4006 0b19 8087 d33a
> E..<..@.@......:
>         0x0010:  8087 d384 9cfb 0185 e879 a137 0000 0000
> .........y.7....
>         0x0020:  a002 16d0 3649 0000 0204 05b4 0402 080a
> ....6I..........
>         0x0030:  0405 26e2 0000 0000 0103 0307            ..&.........
> 16:21:13.454353 IP (tos 0x0, ttl  60, id 4467, offset 0, flags [DF],
> proto: TCP (6), length: 64) gsbids1.uchicago.edu.ldap >
> 128.135.211.58.40187: S, cksum 0xb853 (correct),
> 2478728317:2478728317(0) ack 3900285240 win 49232 <nop,nop,timestamp
> 1159496972 67446498,mss 1460,nop,wscale 0,nop,nop,sackOK>
>         0x0000:  4500 0040 1173 4000 3c06 8577 8087 d384
> E..@.s@.<..w....
>         0x0010:  8087 d33a 0185 9cfb 93be 647d e879 a138
> ...:......d}.y.8
>         0x0020:  b012 c050 b853 0000 0101 080a 451c 850c
> ...P.S......E...
>         0x0030:  0405 26e2 0204 05b4 0103 0300 0101 0402
> ..&.............
> 16:21:13.454410 IP (tos 0x0, ttl  64, id 34774, offset 0, flags [DF],
> proto: TCP (6), length: 52) 128.135.211.58.40187 >
> gsbids1.uchicago.edu.ldap: ., cksum 0xb940 (correct), ack 1 win 46
> <nop,nop,timestamp 67446499 1159496972>
>         0x0000:  4500 0034 87d6 4000 4006 0b20 8087 d33a
> E..4..@.@......:
>         0x0010:  8087 d384 9cfb 0185 e879 a138 93be 647e
> .........y.8..d~
>         0x0020:  8010 002e b940 0000 0101 080a 0405 26e3
> .....@........&.
>         0x0030:  451c 850c                                E...
> 16:21:13.455477 IP (tos 0x0, ttl  64, id 34775, offset 0, flags [DF],
> proto: TCP (6), length: 78) 128.135.211.58.40187 >
> gsbids1.uchicago.edu.ldap: P, cksum 0x7623 (correct), 1:27(26) ack 1
> win
> 46 <nop,nop,timestamp 67446500 1159496972>
>         0x0000:  4500 004e 87d7 4000 4006 0b05 8087 d33a
> E..N..@.@......:
>         0x0010:  8087 d384 9cfb 0185 e879 a138 93be 647e
> .........y.8..d~
>         0x0020:  8018 002e 7623 0000 0101 080a 0405 26e4
> ....v#........&.
>         0x0030:  451c 850c 3018 0201 0160 1302 0103 0400
> E...0....`......
>         0x0040:  a30c 040a 4449 4745 5354 2d4d 4435       ....DIGEST-
> MD5
> 16:21:13.456448 IP (tos 0x0, ttl  60, id 4468, offset 0, flags [DF],
> proto: TCP (6), length: 52) gsbids1.uchicago.edu.ldap >
> 128.135.211.58.40187: ., cksum 0xf902 (correct), ack 27 win 49232
> <nop,nop,timestamp 1159496972 67446500>
>         0x0000:  4500 0034 1174 4000 3c06 8582 8087 d384
> E..4.t@.<.......
>         0x0010:  8087 d33a 0185 9cfb 93be 647e e879 a152
> ...:......d~.y.R
>         0x0020:  8010 c050 f902 0000 0101 080a 451c 850c
> ...P........E...
>         0x0030:  0405 26e4                                ..&.
> 16:21:13.460184 IP (tos 0x0, ttl  60, id 4469, offset 0, flags [DF],
> proto: TCP (6), length: 209) gsbids1.uchicago.edu.ldap >
> 128.135.211.58.40187: P, cksum 0x06b0 (correct), 1:158(157) ack 27 win
> 49232 <nop,nop,timestamp 1159496973 67446500>
>         0x0000:  4500 00d1 1175 4000 3c06 84e4 8087 d384
> E....u@.<.......
>         0x0010:  8087 d33a 0185 9cfb 93be 647e e879 a152
> ...:......d~.y.R
>         0x0020:  8018 c050 06b0 0000 0101 080a 451c 850d
> ...P........E...
>         0x0030:  0405 26e4 3081 9a02 0101 6181 940a 010e
> ..&.0.....a.....
>         0x0040:  0400 0400 8781 8a6e 6f6e 6365 3d22 704d
> .......nonce="pM
>         0x0050:  4c49 4274 4542 4163 4563 7a6e 4675 7666
> LIBtEBAcEcznFuvf
>         0x0060:  4b5a 352f 4863 4f46 3149 4f6e 2b7a 6559
> KZ5/HcOF1IOn+zeY
>         0x0070:  4954 3342 7734 534b 773d 222c 7265 616c
> IT3Bw4SKw=",real
>         0x0080:  6d3d 2267 7362 6964 7331 2e75 6368 6963
> m="gsbids1.uchic
>         0x0090:  6167 6f2e 6564 7522 2c71 6f70 3d22 6175
> ago.edu",qop="au
>         0x00a0:  7468 222c 6d61 7862 7566 3d36 3535 3335
> th",maxbuf=65535
>         0x00b0:  2c63 6861 7273 6574 3d75 7466 2d38 2c61
> ,charset=utf-8,a
>         0x00c0:  6c67 6f72 6974 686d 3d6d 6435 2d73 6573
> lgorithm=md5-ses
>         0x00d0:  73                                       s
> 16:21:13.460332 IP (tos 0x0, ttl  64, id 34776, offset 0, flags [DF],
> proto: TCP (6), length: 52) 128.135.211.58.40187 >
> gsbids1.uchicago.edu.ldap: ., cksum 0xb87a (correct), ack 158 win 54
> <nop,nop,timestamp 67446505 1159496973>
>         0x0000:  4500 0034 87d8 4000 4006 0b1e 8087 d33a
> E..4..@.@......:
>         0x0010:  8087 d384 9cfb 0185 e879 a152 93be 651b
> .........y.R..e.
>         0x0020:  8010 0036 b87a 0000 0101 080a 0405 26e9
> ...6.z........&.
>         0x0030:  451c 850d                                E...
> 16:21:13.470349 IP (tos 0x0, ttl  64, id 34777, offset 0, flags [DF],
> proto: TCP (6), length: 357) 128.135.211.58.40187 >
> gsbids1.uchicago.edu.ldap: P, cksum 0x65ea (correct), 27:332(305) ack
> 158 win 54 <nop,nop,timestamp 67446515 1159496973>
>         0x0000:  4500 0165 87d9 4000 4006 09ec 8087 d33a
> E..e..@.@......:
>         0x0010:  8087 d384 9cfb 0185 e879 a152 93be 651b
> .........y.R..e.
>         0x0020:  8018 0036 65ea 0000 0101 080a 0405 26f3
> ...6e.........&.
>         0x0030:  451c 850d 3082 012d 0201 0260 8201 2602
> E...0..-...`..&.
>         0x0040:  0103 0400 a382 011d 040a 4449 4745 5354
> ..........DIGEST
>         0x0050:  2d4d 4435 0482 010d 7573 6572 6e61 6d65
> -MD5....username
>         0x0060:  3d22 636e 3d44 6972 6563 746f 7279 204d
> ="cn=Directory.M
>         0x0070:  616e 6167 6572 222c 7265 616c 6d3d 2267
> anager",realm="g
>         0x0080:  7362 6964 7331 2e75 6368 6963 6167 6f2e
> sbids1.uchicago.
>         0x0090:  6564 7522 2c6e 6f6e 6365 3d22 704d 4c49
> edu",nonce="pMLI
>         0x00a0:  4274 4542 4163 4563 7a6e 4675 7666 4b5a
> BtEBAcEcznFuvfKZ
>         0x00b0:  352f 4863 4f46 3149 4f6e 2b7a 6559 4954
> 5/HcOF1IOn+zeYIT
>         0x00c0:  3342 7734 534b 773d 222c 636e 6f6e 6365
> 3Bw4SKw=",cnonce
>         0x00d0:  3d22 4647 7067 4f64 664d 4434 4859 536b
> ="FGpgOdfMD4HYSk
>         0x00e0:  4d75 6a4e 7839 6536 6971 6f50 465a 4745
> MujNx9e6iqoPFZGE
>         0x00f0:  6c58 5632 4d62 6351 5951 7751 413d 222c
> lXV2MbcQYQwQA=",
>         0x0100:  6e63 3d30 3030 3030 3030 312c 716f 703d
> nc=00000001,qop=
>         0x0110:  6175 7468 2c64 6967 6573 742d 7572 693d
> auth,digest-uri=
>         0x0120:  226c 6461 702f 6773 6269 6473 312e 7563
> "ldap/gsbids1.uc
>         0x0130:  6869 6361 676f 2e65 6475 222c 7265 7370
> hicago.edu",resp
>         0x0140:  6f6e 7365 3d66 3934 3039 3063 6632 3161
> onse=f94090cf21a
>         0x0150:  3232 6139 3733 6162 3333 6666 6131 3436
> 22a973ab33ffa146
>         0x0160:  6665 6539 30                             fee90
> 16:21:13.471522 IP (tos 0x0, ttl  60, id 4470, offset 0, flags [DF],
> proto: TCP (6), length: 52) gsbids1.uchicago.edu.ldap >
> 128.135.211.58.40187: ., cksum 0xf724 (correct), ack 332 win 49232
> <nop,nop,timestamp 1159496973 67446515>
>         0x0000:  4500 0034 1176 4000 3c06 8580 8087 d384
> E..4.v@.<.......
>         0x0010:  8087 d33a 0185 9cfb 93be 651b e879 a283
> ...:......e..y..
>         0x0020:  8010 c050 f724 0000 0101 080a 451c 850d
> ...P.$......E...
>         0x0030:  0405 26f3                                ..&.
> 16:21:13.480130 IP (tos 0x0, ttl  60, id 4471, offset 0, flags [DF],
> proto: TCP (6), length: 130) gsbids1.uchicago.edu.ldap >
> 128.135.211.58.40187: P, cksum 0x80e1 (correct), 158:236(78) ack 332
> win
> 49232 <nop,nop,timestamp 1159496974 67446515>
>         0x0000:  4500 0082 1177 4000 3c06 8531 8087 d384
> E....w@.<..1....
>         0x0010:  8087 d33a 0185 9cfb 93be 651b e879 a283
> ...:......e..y..
>         0x0020:  8018 c050 80e1 0000 0101 080a 451c 850e
> ...P........E...
>         0x0030:  0405 26f3 304c 0201 0261 470a 0131 0400
> ..&.0L...aG..1..
>         0x0040:  0440 5341 534c 282d 3129 3a20 6765 6e65
> .@SASL(-1):.gene
>         0x0050:  7269 6320 6661 696c 7572 653a 2075 6e61
> ric.failure:.una
>         0x0060:  626c 6520 6361 6e6f 6e69 6679 2075 7365
> ble.canonify.use
>         0x0070:  7220 616e 6420 6765 7420 6175 7870 726f
> r.and.get.auxpro
>         0x0080:  7073                                     ps
> 16:21:13.490588 IP (tos 0x0, ttl  64, id 34778, offset 0, flags [DF],
> proto: TCP (6), length: 59) 128.135.211.58.40187 >
> gsbids1.uchicago.edu.ldap: P, cksum 0x8185 (correct), 332:339(7) ack
> 236
> win 54 <nop,nop,timestamp 67446535 1159496974>
>         0x0000:  4500 003b 87da 4000 4006 0b15 8087 d33a
> E..;..@.@......:
>         0x0010:  8087 d384 9cfb 0185 e879 a283 93be 6569
> .........y....ei
>         0x0020:  8018 0036 8185 0000 0101 080a 0405 2707
> ...6..........'.
>         0x0030:  451c 850e 3005 0201 0342 00              E...0....B.
> 16:21:13.494464 IP (tos 0x0, ttl  60, id 4472, offset 0, flags [DF],
> proto: TCP (6), length: 52) gsbids1.uchicago.edu.ldap >
> 128.135.211.58.40187: F, cksum 0xf6b8 (correct), 236:236(0) ack 339
win
> 49232 <nop,nop,timestamp 1159496975 67446535>
>         0x0000:  4500 0034 1178 4000 3c06 857e 8087 d384
> E..4.x@.<..~....
>         0x0010:  8087 d33a 0185 9cfb 93be 6569 e879 a28a
> ...:......ei.y..
>         0x0020:  8011 c050 f6b8 0000 0101 080a 451c 850f
> ...P........E...
>         0x0030:  0405 2707                                ..'.
> 16:21:13.501638 IP (tos 0x0, ttl  64, id 34779, offset 0, flags [DF],
> proto: TCP (6), length: 52) 128.135.211.58.40187 >
> gsbids1.uchicago.edu.ldap: F, cksum 0xb6c7 (correct), 339:339(0) ack
> 237
> win 54 <nop,nop,timestamp 67446546 1159496975>
>         0x0000:  4500 0034 87db 4000 4006 0b1b 8087 d33a
> E..4..@.@......:
>         0x0010:  8087 d384 9cfb 0185 e879 a28a 93be 656a
> .........y....ej
>         0x0020:  8011 0036 b6c7 0000 0101 080a 0405 2712
> ...6..........'.
>         0x0030:  451c 850f                                E...
> 16:21:13.502722 IP (tos 0x0, ttl  60, id 4473, offset 0, flags [DF],
> proto: TCP (6), length: 52) gsbids1.uchicago.edu.ldap >
> 128.135.211.58.40187: ., cksum 0xf6ac (correct), ack 340 win 49232
> <nop,nop,timestamp 1159496975 67446546>
>         0x0000:  4500 0034 1179 4000 3c06 857d 8087 d384
> E..4.y@.<..}....
>         0x0010:  8087 d33a 0185 9cfb 93be 656a e879 a28b
> ...:......ej.y..
>         0x0020:  8010 c050 f6ac 0000 0101 080a 451c 850f
> ...P........E...
>         0x0030:  0405 2712                                ..'.
> 
> 
> Could be: ?
> "unable canonify user and get auxprops"?
> 
> > -----Original Message-----
> > From: Jeff Moyer [mailto:jmoyer@redhat.com]
> > Sent: Thursday, April 24, 2008 3:59 PM
> > To: Young, Darren
> > Cc: autofs@linux.kernel.org
> > Subject: Re: [autofs] LDAP Server
> >
> > "Young, Darren" <Darren.Young@ChicagoGSB.edu> writes:
> >
> > > Apr 24 14:35:33 gsbtestfilervm automount[8138]: Starting
> automounter
> > > version 5.0.1-0.rc2.55, master map auto.master
> > >
> > > On:
> > >
> > > [root@gsbtestfilervm log]# cat /etc/redhat-release
> > > Red Hat Enterprise Linux Server release 5.1 (Tikanga)
> > >
> > > Added daemon.* to syslog and started autofs:
> > >
> > > Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_ldap_config:
> > ldap
> > > authentication configured with the following options:
> > > Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_ldap_config:
> > > use_tls: 0, tls_required: 0, auth_required: 2, sasl_mech: DIGEST-
> MD5
> > > Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_ldap_config:
> > user:
> > > cn=Directory Manager, secret: specified, client principal: (null)
> > > Apr 24 14:47:16 gsbtestfilervm automount[8283]: sasl_bind_mech:
> > > Attempting sasl bind with mechanism DIGEST-MD5
> > > Apr 24 14:47:16 gsbtestfilervm automount[8283]: sasl_log_func: No
> > worthy
> > > mechs found
> > > Apr 24 14:47:16 gsbtestfilervm automount[8283]: sasl_bind_mech:
> > > sasl_client start failed with error: SASL(-4): no mechanism
> > available:
> > > No worthy mechs found
> >
> > Hmm.  Do you have the cyrus-sasl-md5 package installed?  rpm -q
> > cyrus-sasl-md5 will tell you.  If so, then can you get a packet
> capture
> > during the autofs start (and failure)?  Be sure to capture packet
> data
> > by specifying a snaplen of 0 if using tcpdump.
> >
> > Thanks!
> > Jeff
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
