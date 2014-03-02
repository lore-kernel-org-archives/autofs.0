From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Sun, 02 Mar 2014 19:03:33 +0800
Message-ID: <1393758213.9725.60.camel@perseus.fritz.box>
References: <1391145206.2486.25.camel@perseus.fritz.box>
			 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
			 <530484B7.6030305@molgen.mpg.de>
			 <1392896501.2508.16.camel@perseus.fritz.box>
			 <1392898704.2508.26.camel@perseus.fritz.box>
			 <530625D0.7020808@molgen.mpg.de>
			 <1392946952.2495.3.camel@perseus.fritz.box>
			 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
			 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
			 <5310F30D.9040407@molgen.mpg.de> <53125771.4030000@molgen.mpg.de>
			 <531280C5.1050906@molgen.mpg.de>
		 <1393726632.9725.3.camel@perseus.fritz.box>
		 <5312EBAC.2070200@molgen.mpg.de>
	 <1393753284.9725.31.camel@perseus.fritz.box>
	 <5313066F.6040302@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=h5vRasuU2wKO69/GPEWNdOrD3sc=; b=Vt+Su6CReOhRiiRTg83Q9M9i0C8T
	fbZoUNmXh70ElPk8suRRfzJJivOSap2ZB7ZaY8wNEs11fU9qP5+/zpldB9zgJ3rz
	Yhg/r75oBN5zef+1Tj7TIE0gRsK2qLpNa1NdEGmWw0MqKhw8/PB++GKuCOBvLCQ9
	z40Id8hEhgXspi4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=h5vRasuU2wKO69/GPEWNdO
	rD3sc=; b=cvTyQp4DQ3Wgfts55kIrb0JeI2rwTGGDhFzIqPymYpp33YjLtsSEi6
	ki30krqubYceYXLt0R265TXwjQEngFbUO6WEWPIZf+SDn3GRxAi0NAA/G+lGRjEB
	+lJwyDss4b8S/M/jl5mKwvF5AW1YZkKnY/XKwkW2XOFQA8uMg3uYw=
In-Reply-To: <5313066F.6040302@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <aviro@redhat.com>, autofs <autofs@vger.kernel.org>

On Sun, 2014-03-02 at 11:22 +0100, Donald Buczek wrote:
> Am 02.03.2014 10:41, schrieb Ian Kent:
> > On Sun, 2014-03-02 at 09:28 +0100, Donald Buczek wrote:
> >> Am 02.03.2014 03:17, schrieb Ian Kent:
> >>> mnt_hash->next == mnt_hash->prev, mount has been unlinked from the mount
> >>> tree so is not "visible". As far as we are concerned this mount has
> >>> gone.
> >> No, prev and next both point to the list_head in the mount_hashtable.
> > Fair call, ->mnt_mp != NULL too which implies the mount hasn't been
> > unlinked.
> 
> The problem is, that the mount is in another namespace. I've put mnt_ns 
> into my perl script:
> 
> > root:kasslerbraten:/home/buczek/autofs/# ./peekmounts |grep mariux32
> >  mountpoint 0xffff880125e44480 : count=   1 denty=0xffff88007c86da10 
> > (mariux32)
> >  struct mount 0xffff8800a3a9a6c0 : mountpoint dentry 
> > 0xffff88007c86da10 (mariux32) mountpoint struct 0xffff880125e44480 NS 
> > 0xffff8801271f9300
> > root:kasslerbraten:/home/buczek/autofs/# ./peekmounts |grep project
> >  mountpoint 0xffff8800c1d068a0 : count=   2 denty=0xffff8800c8b2e450 
> > (project)
> >  struct mount 0xffff8800c9e5e200 : mountpoint dentry 
> > 0xffff8800c8b2e450 (project) mountpoint struct 0xffff8800c1d068a0 NS 
> > 0xffff88012d00ed00
> >  struct mount 0xffff8800a3a9a940 : mountpoint dentry 
> > 0xffff8800c8b2e450 (project) mountpoint struct 0xffff8800c1d068a0 NS 
> > 0xffff8801271f9300
> 
> We have a /project without a mounted /project/mariux32 and a /project 
> with a mounted /project/mariux32 in another namespace.

Yep, I'm struggling to follow the namespace list handling atm.
It is something I'm going to need get to terms with because of issues
like this.

> 
> This goes in the direction you mentioned in your other mail ("Illegal as 
> far as autofs is concerned because an autofs mount is strictly 
> associated with a path defined by its map") The system-wide, absolute 
> semantics of pathnames in the automount world don't fit well into the 
> process-local, relative mount semantics of the kernel.

Yes, but a bigger issue is that the autofs semantics of multiple name
spaces aren't defined which means all I can do for now is make
statements like the one above.

No, asking folks concerned with namespaces didn't result in useful
feedback. Perhaps I'm asking the question in the wrong way, I don't know
yet.

> 
> I still don't know, where these "root" or "old-root" messages come from, 
> but again the error occured after these strange messages appeared
> 
> > 2014-02-28T12:33:08.461073+01:00 kasslerbraten kernel: [13093.129511] 
> > pid 7670: d_set_mounted: set mounted on dentry=ffff88007ca58a50 root
> > 2014-02-28T12:33:08.461074+01:00 kasslerbraten kernel: [13093.129569] 
> > pid 7670: put_mountpoint: mp=ffff8801271f9338
> > 2014-02-28T12:33:08.461075+01:00 kasslerbraten kernel: [13093.129574] 
> > pid 7670: d_set_mounted: dentry=ffff8800c890ce10 tmp
> > 2014-02-28T12:33:08.461076+01:00 kasslerbraten kernel: [13093.129575] 
> > pid 7670: d_set_mounted: set mounted on dentry=ffff8800c890ce10 tmp
> > 2014-02-28T12:33:08.461077+01:00 kasslerbraten kernel: [13093.129578] 
> > pid 7670: put_mountpoint: mp=ffff8801271f9338
> > 2014-02-28T12:33:08.461078+01:00 kasslerbraten kernel: [13093.129599] 
> > pid 7670: d_set_mounted: dentry=ffff88007ca407d0 old-root-D0k5jB
> > 2014-02-28T12:33:08.461079+01:00 kasslerbraten kernel: [13093.129601] 
> > pid 7670: d_set_mounted: set mounted on dentry=ffff88007ca407d0 
> > old-root-D0k5jB
> > 2014-02-28T12:33:08.461080+01:00 kasslerbraten kernel: [13093.129602] 
> > pid 7670: put_mountpoint: mp=ffff8800c9e5e750
> > 2014-02-28T12:33:08.461081+01:00 kasslerbraten kernel: [13093.129603] 
> > pid 7670: put_mountpoint: cleared mounted on dentry=ffff88007ca58a50 root
> > 2014-02-28T12:33:08.461082+01:00 kasslerbraten kernel: [13093.129604] 
> > pid 7670: put_mountpoint: mp=ffff8800c9e5e610
> > 2014-02-28T12:33:08.461082+01:00 kasslerbraten kernel: [13093.129662] 
> > pid 7670: put_mountpoint: mp=0000014800450045
> > 2014-02-28T12:33:08.461083+01:00 kasslerbraten kernel: [13093.129663] 
> > pid 7670: put_mountpoint: mp=0000000000000006
> 
> (as explained in another mail , the addresses of "mp=" are wrong, so 
> don't worry about these)
> 
> This looks like chroot or somesuch. But I have no idea. I don't find 
> \"root or \"old- in any sources. There is not "root" in any map.

Can't see anything myself but I've lost track of what kernel version
we're using here, what is it again?

> 
> Hmmm. Isn't the daemon doing lazy umounts? Could it be this?

You would need to have a fairly old version of autofs for it to be doing
lazy umounts and you'd probably be seeing different problems as a
result. In particular, processes unable to successfully call getcwd() or
scripts unable to get pwd from /proc/<pid>/cwd.

> I've compiled the daemon with --enable-ignore-busy

Umm .. now your making me think.

IIRC I added that so the daemon would not refuse to exit when it
encountered mounts that were in use. The idea being to reconstruct the
user space data structures at startup essentially re-connecting to the
mounts left mounted. Sure, that has it's own set of difficulties but
they are much less offensive than the problems seen by using lazy
umount.

In short it isn't related to lazy umounts.

Although I think there's a case were they could be used if you don't use
the miscellaneous device for ioctl control. But you need to explicitly
remove the device file (or make it inaccessible) to make that happen.
There isn't anything like that in any systemd units I'm aware of so
autofs will use the device file by default.

> Anything forcing the daemon to restart?
> systemd doing stupid things to the daemon or the filesystem?
> 
> > [Service]
> > Type=forking
> > ExecStartPre=/sbin/make-automaps
> > ExecStart=/usr/sbin/automount -v
> > PIDFile=/run/autofs-running
> > ExecReload=/bin/kill -HUP $MAINPID

This isn't the systemd unit that's included in the package tar.
I have no idea what /sbin/make-automaps is or does.

Other than the unknown make-automaps it looks like it should be OK.

> 
>    Donald
> 


