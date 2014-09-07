From: Ian Kent <raven@themaw.net>
Subject: Re: Mount point permission
Date: Sun, 07 Sep 2014 10:26:39 +0800
Message-ID: <1410056799.3464.6.camel@perseus.themaw.net>
References: <1409770624.8847.7.camel@deiu.bydeiu.net>
	 <1409793375.2558.7.camel@perseus.themaw.net>
	 <1410030857.2072.9.camel@deiu.bydeiu.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=ROk2SagQXv79wa+pyjNGzU+qLiQ=; b=bqeCYKnq0+d5jGT0uhZ7Q6yRttrC
	ypQ8IwK3cAFQQwKr3Zr50aERK69Y/Wo4kPLvLuP+YHCSpcPZeftFWwJq6rXozOpb
	/5K0czY7jB4JG/0I1osYWu3eexgC+t2FkUAEbWytY5VBOVJZSTAOvFLFMxoR8NEs
	vAq/YImhH0txAR4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=ROk2SagQXv79wa+pyjNGzU
	+qLiQ=; b=arNUxV18KvqgbSlPYlK/GtTUJhmfDJ4OBEk1G4u5+NxejJEm8S6lRo
	oPtaSUaJhubPxLZodi32VACLTwqfxbjH3r4i9kM9v82yNIVGXw7Wjq+AV5qmLx3R
	aY84ZpJRcbhivPE8fgXIYdllWFyB+D6mb2YV33Kx5dj60GSMcmVOA=
In-Reply-To: <1410030857.2072.9.camel@deiu.bydeiu.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrei Amuraritei <sirdeiu@bydeiu.net>
Cc: autofs@vger.kernel.org

On Sat, 2014-09-06 at 22:14 +0300, Andrei Amuraritei wrote:
> On Thu, 2014-09-04 at 09:16 +0800, Ian Kent wrote:
> > On Wed, 2014-09-03 at 21:57 +0300, Amuraritei Andrei wrote:
> > > Hello, 
> > > 
> > > I'm using autofs 5.0.7 on Fedora 20 and have a question regarding the
> > > mount point permissions.
> > > 
> > > Specifically if autofs creates a direct or indirect mount point, for
> > > example /share (which holds the storage nfs exported folder), I can't
> > > seem to create another folder in /share.
> > > 
> > > So mkdir /share/storage/dir1 works. But mkdir /share/dir1 doesn't. I
> > > guess it's by design(?) but couldn't find anything specific about this.
> > > 
> > > Permissions are root:root 0755 for /share from filesystem. But when
> > > trying mkdir /share/dir (while it's mounted by autofs),  and as root, I
> > > get permission denied.
> > 
> > If there is a mount on top of /share, NFS for example, then permissions
> > are managed by NFS. If you can't create a directory in this case then
> > investigate possible NFS permissions problems.
> > 
> > > 
> > > Is this because of autofs needing to unmount /share when not used (with
> > > timeout) or is it just some bug ?
> > 
> > Processes other than the one managing the automount point are not
> > supposed to be able to create directories within an autofs file system.
> > It's far to easy to break the kernel detection of directories that are
> > mount points by creating directories within an autofs file system.
> > Perhaps mountpoints could be detected differently but that isn't as
> > simple to do as it sounds.
> > 
> > Ian
> > 
> 
> Hi Ian and thanks for your time, sorry my reply is so late.
> 
> Now regarding the issue I get is that if I mount /share with autofs as:
> 
> /etc/auto.master
> 
> /share /etc/auto.share
> 
> /etc/auto.share
> 
> * -fstype=nfs4,rw,sec=krb5 nfs-server:/share/&
> 
> It gets mounted, same permissions as on nfs-server:
> 
> /share (0755)
> 
> But if I mount it with a direct map of:
> 
> /share -fstype=nfs4,rw,sec=krb5 nfs-server:/share in /etc/auto.direct 
> 
> and 
> /etc/auto.master 
> 
> /- /etc/auto.direct
> 
> Then it works as expected.
> 
> I've also tried /share -fstype=bind /mnt/share, same results.
> 
> This is with a freeipa server with kerberos / nfs and client,  on Fedora
> 20.
> 
> Any ideas on what to look at?

But they are two quite different mounts.
They don't even mount the same locations.

The indirect mount will mount an autofs file system on /share and
attempt to mount individual NFS mounts at /share/<lookup name>.

But the direct mount will mount a direct trigger at /share and attempt
to mount nfs-server:/share on /share when it's accessed. Any mounts
within /share would need to be triggered by cross device mounting by the
kernel NFS client not autofs, assuming they have been exported with the
options to allow this.

You've not really described what the actual problem is, I'm not sure
what you're asking.

Ian


