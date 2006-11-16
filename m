From: Timo Wendt <twendt@online.de>
Subject: Re: autofs 5 not recognizing manual umounts properly
Date: Thu, 16 Nov 2006 13:48:25 +0100
Message-ID: <16B02FD4-DC07-4D2D-AC2F-9DAEFA10D462@online.de>
References: <10272992.2537671162323983680.JavaMail.servlet@kundenserver>
	<1162720118.13896.25.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary="===============8564587283663096083=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1162720118.13896.25.camel@localhost>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


--===============8564587283663096083==
Content-Type: multipart/alternative; boundary=Apple-Mail-45-690511682


--Apple-Mail-45-690511682
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hi,

that are really good news. Thanks for the effort. I will see if I can  
check these patches out.

Timo


Am 05.11.2006 um 10:48 schrieb Ian Kent:

> On Tue, 2006-10-31 at 20:46 +0100, twendt@online.de wrote:
>>> On Sat, 2006-10-28 at 18:41 +0200, Timo Wendt wrote:
>>>> Hi,
>>>>
>>>>
>>>> I have just installed FC6 to do some tests with autofs 5 as I  
>>>> need to
>>>> use direct mounts. The new version works really great. The only  
>>>> thing
>>>> I figured out so far that does not work fine is, when I umount  
>>>> one of
>>>> the automounted fs manually.
>>>> If I then try to list the contents of that directory it says,  
>>>> that it
>>>> is empty. As soon as I try to create a file in that directory, it
>>>> fails and seems to realize, that the directory should be mounted  
>>>> and
>>>> remounts it, without creating the file though.
>>>
>>> And what kernel are you using?
>>> And the version of autofs?
>>>
>>> Ian
>>>
>>>
>> Hi,
>>
>> sorry for the delay I didn't get to check this yesterday.
>>
>> I have the following maps:
>>
>> /etc/auto.master:
>>
>> /- /etc/auto.direct
>>
>> /etc/auto.direct:
>>
>> /home/timo      192.168.178.187:/mnt
>>
>> The IP is actually the local IP, therefore I get bind mounts  
>> instead of NFS mounts.
>>
>> Here is what I am doing:
>>
>> [root@localhost autofs-5.0.1]# mount
>> /dev/mapper/vg00-lvroot on / type ext3 (rw)
>> proc on /proc type proc (rw)
>> sysfs on /sys type sysfs (rw)
>> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
>> /dev/hda5 on /boot type ext3 (rw)
>> tmpfs on /dev/shm type tmpfs (rw)
>> /dev/mapper/vg00-lvxen on /xen_domains type ext3 (rw)
>> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
>> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
>> nfsd on /proc/fs/nfsd type nfsd (rw)
>>
>> [root@localhost autofs-5.0.1]# ll /home/timo
>> total 0
>> -rw-r--r-- 1 root root 0 Oct 27 20:09 a
>>
>> [root@localhost autofs-5.0.1]# umount /mnt
>>
>> [root@localhost autofs-5.0.1]# mount
>> /dev/mapper/vg00-lvroot on / type ext3 (rw)
>> proc on /proc type proc (rw)
>> sysfs on /sys type sysfs (rw)
>> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
>> /dev/hda5 on /boot type ext3 (rw)
>> tmpfs on /dev/shm type tmpfs (rw)
>> /dev/mapper/vg00-lvxen on /xen_domains type ext3 (rw)
>> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
>> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
>> nfsd on /proc/fs/nfsd type nfsd (rw)
>>
>> [root@localhost autofs-5.0.1]# ll /home/timo
>> total 0
>>
>> [root@localhost autofs-5.0.1]# ll /home/timo
>> total 0
>>
>> [root@localhost autofs-5.0.1]# touch /home/timo/b
>> touch: cannot touch `/home/timo/b': Permission denied
>>
>> [root@localhost autofs-5.0.1]# mount
>> /dev/mapper/vg00-lvroot on / type ext3 (rw)
>> proc on /proc type proc (rw)
>> sysfs on /sys type sysfs (rw)
>> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
>> /dev/hda5 on /boot type ext3 (rw)
>> tmpfs on /dev/shm type tmpfs (rw)
>> /dev/mapper/vg00-lvxen on /xen_domains type ext3 (rw)
>> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
>> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
>> nfsd on /proc/fs/nfsd type nfsd (rw)
>> /mnt on /home/timo type none (rw,bind)
>>
>> [root@localhost autofs-5.0.1]# ll /home/timo
>> total 0
>> -rw-r--r-- 1 root root 0 Oct 27 20:09 a
>>
>
> There are three kernel patches that resulted from testing that aren't
> present in the FC6 kernel. They are working their way through the rc
> process for 2.6.19 at the moment. I've attached them.
>
> I think that the autofs4-2.6.18-rc4-mm1-follow_link-false- 
> negative.patch
> patch resolves this issue. This patch allows autofs4 to recognize a
> direct mount trigger as a mount point even if it has remnant dentrys
> (basically stale or never instantiated directories). I'm a little
> surprised as I didn't think this was a case where remnant dentrys are
> created and I can't see where it happens in the log. The other two
> patches address quite different issues.
>
> Additionally, I noticed that the manual umount can lead to a file  
> handle
> leak and the patch
> autofs-5.0.1-rc2-check-fh-on-mount-trigger.patch should fix that.
>
> I haven't tested this last patch yet apart from that it compiles.
>
> I must reiterate that manually umounting mounts is not recommended
> although it should be fine for simple indirect and direct mounts.
> Multi-mounts are another matter altogether. If you know the autofs
> internals of how they work, manually umounting such a tree (including
> the internal autofs trigger mounts) in the correct order may work but
> you could easily get yourself into the situation where entries won't
> mount or expire, which would require a restart to fix.
>
> Ian
>
> <autofs4-2.6.18-rc4-mm1-follow_link-false-negative.patch>
> <autofs4-2.6.18-rc4-mm2-clear-pending.patch>
> <autofs4-2.6.18-rc6-mm2-zero-timeout.txt>
> <autofs-5.0.1-rc2-check-fh-on-mount-trigger.patch>


--Apple-Mail-45-690511682
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><P style=3D"margin: =
0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica; min-height: =
14.0px">Hi,<BR></P><P style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: =
12.0px Helvetica; min-height: 14.0px"><BR =
class=3D"khtml-block-placeholder"></P><P style=3D"margin: 0.0px 0.0px =
0.0px 0.0px; font: 12.0px Helvetica; min-height: 14.0px">that are really =
good news. Thanks for the effort. I will see if I can check these =
patches out.</P><P style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: =
12.0px Helvetica; min-height: 14.0px"><BR =
class=3D"khtml-block-placeholder"></P><P style=3D"margin: 0.0px 0.0px =
0.0px 0.0px; font: 12.0px Helvetica; min-height: 14.0px">Timo</P><BR =
class=3D"Apple-interchange-newline"></SPAN> </DIV><BR><DIV><DIV>Am =
05.11.2006 um 10:48 schrieb Ian Kent:</DIV><BR =
class=3D"Apple-interchange-newline"><BLOCKQUOTE type=3D"cite"><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">On Tue, 2006-10-31 at 20:46 +0100, <A =
href=3D"mailto:twendt@online.de">twendt@online.de</A> wrote:</DIV> =
<BLOCKQUOTE type=3D"cite"><BLOCKQUOTE type=3D"cite"><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">On Sat, 2006-10-28 at 18:41 +0200, Timo Wendt =
wrote:</DIV> <BLOCKQUOTE type=3D"cite"><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Hi,</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">I have just =
installed FC6 to do some tests with autofs 5 as I need to</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">use direct mounts. The new version works really =
great. The only thing</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">I figured out so far that =
does not work fine is, when I umount one of</DIV><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">the =
automounted fs manually.</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">If I then try =
to list the contents of that directory it says, that it</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">is empty. As soon as I try to create a file in that =
directory, it</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">fails and seems to realize, that =
the directory should be mounted and</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">remounts it, =
without creating the file though.</DIV> </BLOCKQUOTE><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">And what =
kernel are you using?</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">And the version of =
autofs?</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Ian</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV> =
</BLOCKQUOTE><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Hi,</DIV><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">sorry for the =
delay I didn't get to check this yesterday.</DIV><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">I have the =
following maps:</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">/etc/auto.master:</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">/- =
/etc/auto.direct</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">/etc/auto.direct:</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">/home/timo<SPAN class=3D"Apple-converted-space">=A0 =A0 =A0 =
</SPAN>192.168.178.187:/mnt</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">The IP is actually the local IP, =
therefore I get bind mounts instead of NFS mounts.</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Here is =
what I am doing:</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">[root@localhost autofs-5.0.1]# mount</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">/dev/mapper/vg00-lvroot on / type ext3 =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">proc on /proc type proc =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">sysfs on /sys type sysfs =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">devpts on /dev/pts type devpts =
(rw,gid=3D5,mode=3D620)</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">/dev/hda5 on =
/boot type ext3 (rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">tmpfs on /dev/shm type =
tmpfs (rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">/dev/mapper/vg00-lvxen on =
/xen_domains type ext3 (rw)</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">none on =
/proc/sys/fs/binfmt_misc type binfmt_misc (rw)</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">nfsd on /proc/fs/nfsd type nfsd =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">[root@localhost autofs-5.0.1]# ll =
/home/timo</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">total 0</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">-rw-r--r-- 1 root root 0 Oct 27 20:09 a</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">[root@localhost autofs-5.0.1]# umount /mnt</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">[root@localhost autofs-5.0.1]# mount</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">/dev/mapper/vg00-lvroot on / type ext3 (rw)</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">proc on /proc type proc (rw)</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">sysfs on /sys type sysfs (rw)</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">devpts on /dev/pts type devpts =
(rw,gid=3D5,mode=3D620)</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">/dev/hda5 on =
/boot type ext3 (rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">tmpfs on /dev/shm type =
tmpfs (rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">/dev/mapper/vg00-lvxen on =
/xen_domains type ext3 (rw)</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">none on =
/proc/sys/fs/binfmt_misc type binfmt_misc (rw)</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">nfsd on /proc/fs/nfsd type nfsd =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">[root@localhost autofs-5.0.1]# ll =
/home/timo</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">total 0</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">[root@localhost autofs-5.0.1]# ll /home/timo</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">total 0</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">[root@localhost autofs-5.0.1]# =
touch /home/timo/b</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">touch: cannot touch =
`/home/timo/b': Permission denied</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">[root@localhost autofs-5.0.1]# =
mount</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">/dev/mapper/vg00-lvroot on / =
type ext3 (rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">proc on /proc type proc =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">sysfs on /sys type sysfs =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">devpts on /dev/pts type devpts =
(rw,gid=3D5,mode=3D620)</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">/dev/hda5 on =
/boot type ext3 (rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">tmpfs on /dev/shm type =
tmpfs (rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">/dev/mapper/vg00-lvxen on =
/xen_domains type ext3 (rw)</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">none on =
/proc/sys/fs/binfmt_misc type binfmt_misc (rw)</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">nfsd on /proc/fs/nfsd type nfsd =
(rw)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">/mnt on /home/timo type none =
(rw,bind)</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">[root@localhost autofs-5.0.1]# ll =
/home/timo</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">total 0</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">-rw-r--r-- 1 root root 0 Oct 27 20:09 a</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV> </BLOCKQUOTE><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">There =
are three kernel patches that resulted from testing that =
aren't</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">present in the FC6 kernel. They =
are working their way through the rc</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">process for =
2.6.19 at the moment. I've attached them.</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">I think that =
the autofs4-2.6.18-rc4-mm1-follow_link-false-negative.patch</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">patch resolves this issue. This patch allows autofs4 =
to recognize a</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">direct mount trigger as a mount =
point even if it has remnant dentrys</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">(basically =
stale or never instantiated directories). I'm a little</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">surprised as I didn't think this was a case where =
remnant dentrys are</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">created and I can't see =
where it happens in the log. The other two</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">patches =
address quite different issues.</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Additionally, I noticed that the =
manual umount can lead to a file handle</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">leak and =
the patch<SPAN class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">autofs-5.0.1-rc2-check-fh-on-mount-trigger.patch =
should fix that.</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I haven't tested this last patch yet apart from that =
it compiles.</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I must reiterate that manually umounting mounts is =
not recommended</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">although it should be fine for =
simple indirect and direct mounts.</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Multi-mounts =
are another matter altogether. If you know the autofs</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">internals of how they work, manually umounting such =
a tree (including</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">the internal autofs trigger =
mounts) in the correct order may work but</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">you =
could easily get yourself into the situation where entries =
won't</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">mount or expire, which would =
require a restart to fix.</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Ian</DIV><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; =
"><BR><SPAN><DIV>&lt;autofs4-2.6.18-rc4-mm1-follow_link-false-negative.pat=
ch&gt;</DIV></SPAN><SPAN><DIV>&lt;autofs4-2.6.18-rc4-mm2-clear-pending.pat=
ch&gt;</DIV></SPAN><SPAN><DIV>&lt;autofs4-2.6.18-rc6-mm2-zero-timeout.txt&=
gt;</DIV></SPAN><SPAN><DIV>&lt;autofs-5.0.1-rc2-check-fh-on-mount-trigger.=
patch&gt;</DIV></SPAN></DIV></BLOCKQUOTE></DIV><BR></BODY></HTML>=

--Apple-Mail-45-690511682--


--===============8564587283663096083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8564587283663096083==--

