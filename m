From: Ian Kent <raven@themaw.net>
Subject: Re: Regular deadlocks
Date: Tue, 28 Jun 2016 08:27:02 +0800
Message-ID: <1467073622.3767.17.camel@themaw.net>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
	 <1466906389.739.25.camel@themaw.net>
	 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
	 <1466987208.3191.6.camel@themaw.net>
	 <17c66f92-bda8-1eb9-621c-47e39406acc2@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=4AzAGBrIRKOwt1lfOy03Tp8gqCA=; b=joeS27
	Z0JTxvlTXIo+akg0ILBJpWjx+55nS+fj8sPCsyEAwcI2IVC6VeFPX8OGN4n6ST3r
	dVQ4xCTnqkErWge+sFoxkxDSDZKscIl4YxJJZtJcn+k4whumjEkC99J0sxVyqJUP
	4gzVZ3ODupO8jk6RgWHwpmjejjMxQvNLf4g6o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4AzAGBrIRKOwt1l
	fOy03Tp8gqCA=; b=hSP5Y/T1sU2HX3GFjtzjuNI72WyOqQlUdQERvwtMs2xPT4k
	vJTWnTNuyEt/gORItPtGt9cWzetSjK4y92i+gGXjQfuPw2975uGmbTNoPZkC9QlQ
	uC8s0gU70Gle712jDiRMu3weYPFA3CUQin4eiaA9JY6Q88AOvk/f4SQ98cu4=
In-Reply-To: <17c66f92-bda8-1eb9-621c-47e39406acc2@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>, autofs@vger.kernel.org

On Mon, 2016-06-27 at 16:04 +0200, Cyril B. wrote:
> On 06/27/2016 02:26 AM, Ian Kent wrote:
> > How is autofs configured.
> > 
> > If --disable-mount-locking is not used then any mount can block all other
> > mounts, if it is used then there can be mtab corruption if still using a
> > text
> > based mtab.
> 
> I use --disable-mount-locking.
> 
> > I always use --disable-mount-locking and nowadays the mtab is usually a
> > symlink
> > into the proc file system so corruption isn't a problem.
> 
> /etc/mtab is actually not a symlink on my systems.
> 
> 
> Anyway, I have more details for you as the issue appeared today and I 
> could investigate some more. This is on a server that only mounts one 
> single NFS server (http12), so the multi-servers blocking issue is 
> irrelevant here.
> 
> A few minutes before the "deadlock" occurred, /nfs/http12 was unmounted 
> by autofs, I assume because it was idle. I have TIMEOUT=600. That 
> explains why the issue appears much more frequently on a server which is 
> way less busy (and usually in the middle of the night): the NFS server 
> needs to be idle enough to be unmounted.
> 
> However, I still had many /home/userX mounted (by autofs), which point 
> to /nfs/http12/userX. Shouldn't autofs not unmount /nfs/http12 when at 
> least one /home/userX is mounted? To be clear, here's an extract from my 
> /proc/mounts BEFORE the NFS server is unmounted by autofs:

This doesn't look like the full picture.
Where are the autofs file system mounts?

Mounted doesn't necessarily mean busy or in use but that also depends on the
mount hierarchy and how it has been constructed.

And symlinks are never be "busy", they can't be a pwd and they aren't opened as
a file.

> 
> http12:/ /nfs/http12 nfs4 
> rw,nosuid,noatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,soft,proto=t
> cp6,timeo=1000,retrans=2,sec=sys,clientaddr=2a00:42:1:50:1::1,local_lock=none,
> addr=2a00:42:1:20:1::1 
> 0
>   0

This looks like an nfs4 fsid 0 mount.

Is this one mounted by a program map similar to what you described earlier?
Do you then rely on the nfs cross device automounting to mount the user mounts?

Or is this one mounted external to autofs and used by autofs automounts?
Or are you using autofs to mount this one and some other map to mount the other
mounts?

> http12://user1 /home/user1 nfs4 
> rw,nosuid,noatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,soft,proto=t
> cp6,timeo=1000,retrans=2,sec=sys,clientaddr=2a00:42:1:50:1::1,local_lock=none,
> addr=2a00:42:1:20:
> 1::1 0 0
> http12://user2 /home/user2 nfs4 
> rw,nosuid,noatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,soft,proto=t
> cp6,timeo=1000,retrans=2,sec=sys,clientaddr=2a00:42:1:50:1::1,local_lock=none,
> addr=2a00:42:1:2
> 0:1::1 0 0

But then there are these, that don't seem to be related to the mount above,
perhaps they reference the first mount. 

Can you describe again how this fits together?

At this point a full debug log would probably answer most of my questions.

> 
> 
> Also, I couldn't find any blocked mount process that would explain the 
> "deadlock". I had a 'ps aux|grep mount' done every 10 seconds:
> 
> Mon Jun 27 05:00:00 CEST 2016
> root        3437  0.0  0.0 218676  5500 ?        Ssl  Jun24   0:26 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> 
> Mon Jun 27 05:00:10 CEST 2016
> root        3437  0.0  0.0 218676  5500 ?        Ssl  Jun24   0:27 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618146  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618214  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618215  0.0  0.0      0     0 ?        Z    05:00   0:00 
> [umount] <defunct>
> root     2618224  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618227  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618230  0.0  0.0      0     0 ?        Z    05:00   0:00 
> [umount] <defunct>
> root     2618240  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618248  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618250  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618252  0.1  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> 
> Mon Jun 27 05:00:20 CEST 2016
> root        3437  0.0  0.0 218676  5500 ?        Ssl  Jun24   0:27 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618146  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618214  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618224  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618227  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618240  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618248  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618250  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618252  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618701  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> root     2618702  0.0  0.0 218676  2168 ?        S    05:00   0:00 
> /usr/sbin/automount --pid-file /var/run/autofs.pid
> 
> And it remained in that state afterwards. I don't know if the defunct 
> umount are suspicious, I guess not.
> 
> One last thing: a manual umount of /home/userY was done by a script at 
> 6:26 (/home/userY was NOT mounted though), and it remained blocked. I'm 
> not sure if it's a consequence of autofs being blocked or something else.
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
