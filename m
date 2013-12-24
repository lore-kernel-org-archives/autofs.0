From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet committed
Date: Tue, 24 Dec 2013 17:42:53 +0800
Message-ID: <CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	<CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	<1387875881.7351.12.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8o+xPfzZn6Xyo5HKQGtgoeeK6Odk2wex97I6Fec3X9Q=;
        b=Zn+SCBLbYghZy0kf3n2v7ArobyiQwdfzl1malQpfyiKlooD7Vhi8GUxXgiJzgk6R6x
         d8788afTktsoKVU62jxFtPbPdwjAK0XsGR6U9Ua+HurxBCrbeDRFYWroJI+bKh8siUp0
         Rx09214h1KJ4TooYjtsercSGltUMooxKl6QkT3INwsXEWZaa33w6JnwSqvFZiFtNQgzO
         WtuJyBpLHQmpaoNXDgPKjx1RTyxwnI16kYg8nKgps7l5T2zq4yV6SnW4b0GP3JjypRCb
         FoZUnjSUmFqFFgH83zzIheD3xcHZwAiVd2tS8w/ZqEGTJcGOZQYgt6ppPCU+0/PpcUZY
         2V2g==
In-Reply-To: <1387875881.7351.12.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, Dec 24, 2013 at 5:04 PM, Ian Kent <raven@themaw.net> wrote:
> On Tue, 2013-12-24 at 16:38 +0800, Dennis Lan (dlan) wrote:
>> Hi Ian:
>>   Do you mind push a temporary branch into your git repo (if you don't
>> want to queue other patches)?
>> That would much convenient for me to test.
>
> Try branch autofs-5.0.public.
> As master and autofs-5.0 branches diverge the autofs-5.0 will be the
> place for version 5.0.
>
>

Hi Ian
 Have problem with branch autofs-5.0.public
most obvious error
461:Dec 24 17:29:12 ofire automount[11496]: mount(nfs): no hosts available
462:Dec 24 17:29:12 ofire automount[11496]: dev_ioctl_send_fail: token = 79


ofire ~ # cat /etc/autofs/auto.misc
cd              -fstype=iso9660,ro,nosuid,nodev :/dev/cdrom

# the following entries are samples to pique your imagination
mkynfs          -ro,soft,intr,nfsvers=4         mickeycn:/home/dennis
mkyand          -ro,soft,intr,nfsvers=4         mickeycn:/home/android

winxp           -fstype=cifs,credentials=/etc/autofs/auto.auth
://192.168.90.168/share
share           -fstype=cifs,credentials=/etc/autofs/auto.auth
://192.168.90.3/For-sd/

ofire ~ # grep -n automount /var/log/messages
149:Dec 24 17:29:05 ofire automount[11496]: st_expire: state 1 path /net
150:Dec 24 17:29:05 ofire automount[11496]: expire_proc: exp_proc =
140156272908032 path /net
151:Dec 24 17:29:05 ofire automount[11496]: expire_cleanup: got thid
140156272908032 path /net stat 0
152:Dec 24 17:29:05 ofire automount[11496]: expire_cleanup: sigchld:
exp 140156272908032 finished, switching from 2 to 1
153:Dec 24 17:29:05 ofire automount[11496]: st_ready: st_ready():
state = 2 path /net
448:Dec 24 17:29:12 ofire automount[11496]: handle_packet: type = 3
449:Dec 24 17:29:12 ofire automount[11496]:
handle_packet_missing_indirect: token 79, name mkynfs, request pid
11679
450:Dec 24 17:29:12 ofire automount[11496]: attempting to mount entry
/mnt/misc/mkynfs
451:Dec 24 17:29:12 ofire automount[11496]: lookup_mount:
lookup(file): looking up mkynfs
452:Dec 24 17:29:12 ofire automount[11496]: lookup_mount:
lookup(file): mkynfs -> -ro,soft,intr,nfsvers=4
mickeycn:/home/dennis
453:Dec 24 17:29:12 ofire automount[11496]: parse_mount: parse(sun):
expanded entry: -ro,soft,intr,nfsvers=4      mickeycn:/home/dennis
454:Dec 24 17:29:12 ofire automount[11496]: parse_mount: parse(sun):
gathered options: ro,soft,intr,nfsvers=4
455:Dec 24 17:29:12 ofire automount[11496]: parse_mount: parse(sun):
dequote("mickeycn:/home/dennis") -> mickeycn:/home/dennis
456:Dec 24 17:29:12 ofire automount[11496]: parse_mount: parse(sun):
core of entry: options=ro,soft,intr,nfsvers=4,
loc=mickeycn:/home/dennis
457:Dec 24 17:29:12 ofire automount[11496]: sun_mount: parse(sun):
mounting root /mnt/misc, mountpoint mkynfs, what
mickeycn:/home/dennis, fstype nfs, options ro,soft,intr,nfsvers=4
458:Dec 24 17:29:12 ofire automount[11496]: mount_mount: mount(nfs):
root=/mnt/misc name=mkynfs what=mickeycn:/home/dennis, fstype=nfs,
options=ro,soft,intr,nfsvers=4
459:Dec 24 17:29:12 ofire automount[11496]: mount_mount: mount(nfs):
nfs options="ro,soft,intr,nfsvers=4", nobind=0, nosymlink=0, ro=1
460:Dec 24 17:29:12 ofire automount[11496]: get_nfs_info: called with
host mickeycn(192.168.90.12) proto 6 version 0x40
461:Dec 24 17:29:12 ofire automount[11496]: mount(nfs): no hosts available
462:Dec 24 17:29:12 ofire automount[11496]: dev_ioctl_send_fail: token = 79
463:Dec 24 17:29:12 ofire automount[11496]: failed to mount /mnt/misc/mkynfs
464:Dec 24 17:29:12 ofire automount[11496]: handle_packet: type = 3
465:Dec 24 17:29:12 ofire automount[11496]:
handle_packet_missing_indirect: token 80, name mkynfs, request pid
11679
466:Dec 24 17:29:12 ofire automount[11496]: dev_ioctl_send_fail: token = 80
516:Dec 24 17:29:13 ofire automount[11496]: st_expire: state 1 path /net
517:Dec 24 17:29:13 ofire automount[11496]: expire_proc: exp_proc =
140156272908032 path /net
518:Dec 24 17:29:13 ofire automount[11496]: expire_cleanup: got thid
140156272908032 path /net stat 0
519:Dec 24 17:29:13 ofire automount[11496]: expire_cleanup: sigchld:
exp 140156272908032 finished, switching from 2 to 1
520:Dec 24 17:29:13 ofire automount[11496]: st_ready: st_ready():
state = 2 path /net
