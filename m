From: wusheng zhang <zwusheng@gmail.com>
Subject: autofs, closing file error.
Date: Sat, 13 Aug 2011 21:03:58 +0800
Message-ID: <CABc702S9AtDk1nszh+=izXzZr8iV6FYN0TuA3AN7fYGCUnLgUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0585996047571307143=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=ErdGj9A3CTvmTLsBqEDQXGY6ZiEPwxn2nvkDsuk9gMU=;
	b=LDphiV7ghLD3V4WnL9Pa09HPX4jRf4xIr8lXyx/1zEEG0PiN1OI395tqKBm7NtjJ5q
	nNsTXaBYWXQqPKzjU7xR0Kz7+zmVaGTNZsmEe6aUoHzhvlT6tLwPi2eTmiWxDS74Aho4
	SSiUv423y5LBAgG8ZhlMnIBxeKJ6LVqsJ9l5I=
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

--===============0585996047571307143==
Content-Type: multipart/alternative; boundary=000e0cd56cc8c2ea9504aa62a933

--000e0cd56cc8c2ea9504aa62a933
Content-Type: text/plain; charset=ISO-8859-1

Dear list:
I am not sure, it is suitable posing the message  to this list. But this
obsessed me for a long time.


####Problem description:
I am running a fortran program, that doing some computation works and saves
data to the
working directory.
I started the program at an automounted directory, here, in my situation,
the directory is
/work/zws_work/origin1.

when the program run, I got CLOSE error randomly.
I also run the same copy of binary on a local disk, It never fail.

so I doubt is it the autofs problem?

But I have no idea how recognize and solve it,
Switching to a newer version  of automount daemon may solve this problem?

### contents of /etc/auto.master
/work   /etc/auto.work --timeout=300

###system information
[root@ln0 ~]# uname -a;automount -V
Linux ln0 2.6.18-194.17.1.0.1.el5_lustre.1.8.5 #1 SMP Wed Aug 3 18:09:09 CST
2011 x86_64 x86_64 x86_64 GNU/Linux

Linux automount version 5.0.1-0.rc2.143.el5

Directories:
        config dir:     /etc/sysconfig
        maps dir:       /etc
        modules dir:    /usr/lib64/autofs

Compile options:
  DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD WITH_LDAP
  WITH_SASL
[zws@c37b20 origin1]$ cat /etc/redhat-release
Red Hat Enterprise Linux Server release 5.5 (Tikanga)

#####[root@ln0 ~]# cat /etc/auto.work
* -rw,soft,intr,proto=udp ibworkserver:/home/&

the fortran code fragment:
1269   fid = 4444
1270   fn = trim(pwd) // '/' // trim(name)

1272   open(fid,file=trim(fn),form='unformatted')

1273   write(fid) model%tmp%elec_down%len
1274   write(fid) model%tmp%elec_down%num
1275   write(fid) model%tmp%elec_down%dim
1276   write(fid) model%tmp%elec_down%up_dif
1277   write(fid) model%tmp%elec_down%down_dif
1278
1279   do i=1,model%tmp%elec_down%num
1280     write(fid)
1281     write(fid)
model%tmp%elec_down%sub(i)%num_up,model%tmp%elec_down%sub(i)%num_down
1282     write(fid)
model%tmp%elec_down%sub(i)%row_dim,model%tmp%elec_down%sub(i)%sdim
1283     do y=1,model%tmp%elec_down%sub(i)%sdim
1284       do x=1,model%tmp%elec_down%sub(i)%row_dim
1285         write(fid) model%tmp%elec_down%sub(i)%mat(x,y)
1286       end do
1287     end do
1288   end do
1289
1290
1291
1292
1293   status = 0
1303   INQUIRE(UNIT=fid, OPENED=opened, NAME=fname)
1304   print *, 'model_to_disk about closing after inquire:', trim(fn),
',opened=', opened, ',fname=', trim(fname)
1305   close(fid)
1306 .....

at this code fragment, I randomly get error like this:

19367  truns_to_disk about closing after
inquire:/work/zws_work/origin1/systruns24
19368  ,opened= T ,fname=/work/zws_work/origin1/systruns24

19370 forrtl: Input/output error
19371 forrtl: severe (28): CLOSE error, unit 4444, file "Unknown"
19372 Image              PC                Routine            Line
Source
19373 Kitaev_DMRG1       0000000000533CED  Unknown               Unknown
Unknown
19374 Kitaev_DMRG1       00000000005327F5  Unknown               Unknown
Unknown
19375 Kitaev_DMRG1       00000000004DCE00  Unknown               Unknown
Unknown
19376 Kitaev_DMRG1       000000000049F7CF  Unknown               Unknown
Unknown
19377 Kitaev_DMRG1       000000000049F002  Unknown               Unknown
Unknown
19378 Kitaev_DMRG1       000000000049CE61  Unknown               Unknown
Unknown
19379 Kitaev_DMRG1       0000000000409D44  wave_to_disk_            1073
space_info.f90
19380 Kitaev_DMRG1       000000000046B5DF  left_to_right_            705
warm_up.f90
19381 Kitaev_DMRG1       0000000000497571  MAIN__                     45
quantum.f90
19382 Kitaev_DMRG1       0000000000403A7C  Unknown               Unknown
Unknown
19383 libc.so.6          0000003AF641D994  Unknown               Unknown
Unknown
19384 Kitaev_DMRG1       0000000000403989  Unknown               Unknown
Unknown

--000e0cd56cc8c2ea9504aa62a933
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear list:<br>I am not sure, it is suitable posing the message=A0 to this l=
ist. But this obsessed me for a long time.<br><br><br>
<span style=3D"background-color: rgb(204, 0, 0);">####Problem description:<=
/span><br>I am running a fortran program, that doing some computation works=
 and saves data to the <br>working directory.<br>I started the program at a=
n automounted directory, here, in my situation, the directory is<br>
/work/zws_work/origin1.<br><br>when the program run, I got CLOSE error rand=
omly.<br>I also run the same copy of binary on a local disk, It never fail.=
<br><br>so I doubt is it the autofs problem?<br><br>But I have no idea how =
recognize and solve it, <br>
Switching to a newer version=A0 of automount daemon may solve this problem?=
<br><br><span style=3D"background-color: rgb(255, 255, 0);">### contents of=
 /etc/auto.master</span><br>/work=A0=A0 /etc/auto.work --timeout=3D300<br><=
br style=3D"background-color: rgb(255, 204, 0);">
<span style=3D"background-color: rgb(255, 204, 0);">###system information</=
span><br>[root@ln0 ~]# uname -a;automount -V<br>Linux ln0 2.6.18-194.17.1.0=
.1.el5_lustre.1.8.5 #1 SMP Wed Aug 3 18:09:09 CST 2011 x86_64 x86_64 x86_64=
 GNU/Linux<br>
<br>Linux automount version 5.0.1-0.rc2.143.el5<br><br>Directories:<br>=A0=
=A0=A0=A0=A0=A0=A0 config dir:=A0=A0=A0=A0 /etc/sysconfig<br>=A0=A0=A0=A0=
=A0=A0=A0 maps dir:=A0=A0=A0=A0=A0=A0 /etc<br>=A0=A0=A0=A0=A0=A0=A0 modules=
 dir:=A0=A0=A0 /usr/lib64/autofs<br><br>Compile options:<br>=A0 DISABLE_MOU=
NT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD WITH_LDAP <br>
=A0 WITH_SASL <br>[zws@c37b20 origin1]$ cat /etc/redhat-release <br>Red Hat=
 Enterprise Linux Server release 5.5 (Tikanga)<br><br><span style=3D"backgr=
ound-color: rgb(255, 255, 0);">#####[root@ln0 ~]# cat /etc/auto.work </span=
><br>
* -rw,soft,intr,proto=3Dudp ibworkserver:/home/&amp;<br><br>the fortran cod=
e fragment:<br>1269=A0=A0 fid =3D 4444<br>1270=A0=A0 fn =3D trim(pwd) // &#=
39;/&#39; // trim(name)<br><br>1272=A0=A0 open(fid,file=3Dtrim(fn),form=3D&=
#39;unformatted&#39;)<br>
<br>1273=A0=A0 write(fid) model%tmp%elec_down%len<br>1274=A0=A0 write(fid) =
model%tmp%elec_down%num<br>1275=A0=A0 write(fid) model%tmp%elec_down%dim<br=
>1276=A0=A0 write(fid) model%tmp%elec_down%up_dif<br>1277=A0=A0 write(fid) =
model%tmp%elec_down%down_dif<br>
1278=A0=A0=A0=A0 <br>1279=A0=A0 do i=3D1,model%tmp%elec_down%num<br>1280=A0=
=A0=A0=A0 write(fid)<br>1281=A0=A0=A0=A0 write(fid) model%tmp%elec_down%sub=
(i)%num_up,model%tmp%elec_down%sub(i)%num_down<br>1282=A0=A0=A0=A0 write(fi=
d) model%tmp%elec_down%sub(i)%row_dim,model%tmp%elec_down%sub(i)%sdim<br>
1283=A0=A0=A0=A0 do y=3D1,model%tmp%elec_down%sub(i)%sdim<br>1284=A0=A0=A0=
=A0=A0=A0 do x=3D1,model%tmp%elec_down%sub(i)%row_dim<br>1285=A0=A0=A0=A0=
=A0=A0=A0=A0 write(fid) model%tmp%elec_down%sub(i)%mat(x,y)<br>1286=A0=A0=
=A0=A0=A0=A0 end do<br>1287=A0=A0=A0=A0 end do<br>1288=A0=A0 end do<br>
1289 <br>1290=A0=A0 <br>1291=A0=A0 <br>1292=A0=A0=A0=A0 <br>1293=A0=A0 stat=
us =3D 0 <br>1303=A0=A0 INQUIRE(UNIT=3Dfid, OPENED=3Dopened, NAME=3Dfname)<=
br>1304=A0=A0 print *, &#39;model_to_disk about closing after inquire:&#39;=
, trim(fn), &#39;,opened=3D&#39;, opened, &#39;,fname=3D&#39;, trim(fname)<=
br>
1305=A0=A0 close(fid)<br>1306 .....<br><br>at this code fragment, I randoml=
y get error like this:<br><br>19367=A0 truns_to_disk about closing after in=
quire:/work/zws_work/origin1/systruns24<br>19368=A0 ,opened=3D T ,fname=3D/=
work/zws_work/origin1/systruns24<br>
<br>19370 forrtl: Input/output error<br>19371 forrtl: severe (28): CLOSE er=
ror, unit 4444, file &quot;Unknown&quot;<br>19372 Image=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 PC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Routi=
ne=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Line=A0=A0=A0=A0=A0=A0=A0 Source<br>193=
73 Kitaev_DMRG1=A0=A0=A0=A0=A0=A0 0000000000533CED=A0 Unknown=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Unknown=A0 Unknown<br>
19374 Kitaev_DMRG1=A0=A0=A0=A0=A0=A0 00000000005327F5=A0 Unknown=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Unknown=A0 Unknown<br>19375 Kitaev_DMRG1=
=A0=A0=A0=A0=A0=A0 00000000004DCE00=A0 Unknown=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Unknown=A0 Unknown<br>19376 Kitaev_DMRG1=A0=A0=A0=A0=A0=A0 =
000000000049F7CF=A0 Unknown=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Unkno=
wn=A0 Unknown<br>
19377 Kitaev_DMRG1=A0=A0=A0=A0=A0=A0 000000000049F002=A0 Unknown=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Unknown=A0 Unknown<br>19378 Kitaev_DMRG1=
=A0=A0=A0=A0=A0=A0 000000000049CE61=A0 Unknown=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Unknown=A0 Unknown<br>19379 Kitaev_DMRG1=A0=A0=A0=A0=A0=A0 =
0000000000409D44=A0 wave_to_disk_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1073=A0 =
space_info.f90<br>
19380 Kitaev_DMRG1=A0=A0=A0=A0=A0=A0 000000000046B5DF=A0 left_to_right_=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 705=A0 warm_up.f90<br>19381 Kitaev_DMRG1=A0=
=A0=A0=A0=A0=A0 0000000000497571=A0 MAIN__=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 45=A0 quantum.f90<br>19382 Kitaev_DMRG1=A0=A0=
=A0=A0=A0=A0 0000000000403A7C=A0 Unknown=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Unknown=A0 Unknown<br>
19383 libc.so.6=A0=A0=A0=A0=A0=A0=A0=A0=A0 0000003AF641D994=A0 Unknown=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Unknown=A0 Unknown<br>19384 Kitaev_=
DMRG1=A0=A0=A0=A0=A0=A0 0000000000403989=A0 Unknown=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 Unknown=A0 Unknown<br><br>

--000e0cd56cc8c2ea9504aa62a933--


--===============0585996047571307143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0585996047571307143==--

