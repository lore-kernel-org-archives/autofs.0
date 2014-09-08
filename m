From: Ian Kent <raven@themaw.net>
Subject: Re: Mount point permission
Date: Mon, 08 Sep 2014 09:02:49 +0800
Message-ID: <1410138169.2567.13.camel@perseus.themaw.net>
References: <1409770624.8847.7.camel@deiu.bydeiu.net>
	 <1409793375.2558.7.camel@perseus.themaw.net>
	 <1410030857.2072.9.camel@deiu.bydeiu.net>
	 <1410056799.3464.6.camel@perseus.themaw.net>
	 <707311a4acd98d5f6adc0c7eb3aa2ba6@imap.bydeiu.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=uQ6BF0FRD/cXC5FyDM3V26PluH0=; b=wWXNWIurZd3AoZ+OBXo32GdOcs13
	Ch39kq7uKkXt/CP4m3fA/1i6BG0ucMSfwzaUu9D9Juv3v2JQ8wuJgtN0eyPwqYhN
	S/Uox81Akf1dpREd/Sxy9cVS/hlXBYYgTORCi3v+tUR0ThilfTTDL9i7LvD5hiAG
	qpQOmvY3BNVqMjI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=uQ6BF0FRD/cXC5FyDM3V26
	PluH0=; b=WAKkbl0U+OguFqahSkS13d9mbJHuAXmq5OZQVTcjcUJa6hH6NT7KxY
	1uDjAD6/h8uLzXGnH/Hq80/1jFf6CRzz4F5/1hE4H1/YuGc7U2kdpl1u6RW7QBUY
	aAClSbqZyyyiN0/8rDFhawZe2OQMMgmAv7dZi3psF1rDo1BKX87lA=
In-Reply-To: <707311a4acd98d5f6adc0c7eb3aa2ba6@imap.bydeiu.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrei Amuraritei <sirdeiu@bydeiu.net>
Cc: autofs@vger.kernel.org

On Sun, 2014-09-07 at 09:28 +0300, Andrei Amuraritei wrote:
> On 2014-09-07 05:26, Ian Kent wrote:
> > On Sat, 2014-09-06 at 22:14 +0300, Andrei Amuraritei wrote:
> > On Thu, 2014-09-04 at 09:16 +0800, Ian Kent wrote:
> > > On Wed, 2014-09-03 at 21:57 +0300, Amuraritei Andrei wrote:
> > > > Hello,
> > > >
> > > > I'm using autofs 5.0.7 on Fedora 20 and have a question regarding the
> > > > mount point permissions.
> > > >
> > > > Specifically if autofs creates a direct or indirect mount point, for
> > > > example /share (which holds the storage nfs exported folder), I can't
> > > > seem to create another folder in /share.
> > > >
> > > > So mkdir /share/storage/dir1 works. But mkdir /share/dir1 doesn't. I
> > > > guess it's by design(?) but couldn't find anything specific about this.
> > > >
> > > > Permissions are root:root 0755 for /share from filesystem. But when
> > > > trying mkdir /share/dir (while it's mounted by autofs),  and as root, I
> > > > get permission denied.
> > >
> > > If there is a mount on top of /share, NFS for example, then permissions
> > > are managed by NFS. If you can't create a directory in this case then
> > > investigate possible NFS permissions problems.
> > >
> > > >
> > > > Is this because of autofs needing to unmount /share when not used (with
> > > > timeout) or is it just some bug ?
> > >
> > > Processes other than the one managing the automount point are not
> > > supposed to be able to create directories within an autofs file system.
> > > It's far to easy to break the kernel detection of directories that are
> > > mount points by creating directories within an autofs file system.
> > > Perhaps mountpoints could be detected differently but that isn't as
> > > simple to do as it sounds.
> > >
> > > Ian
> > >
> > 
> > Hi Ian and thanks for your time, sorry my reply is so late.
> > 
> > Now regarding the issue I get is that if I mount /share with autofs as:
> > 
> > /etc/auto.master
> > 
> > /share /etc/auto.share
> > 
> > /etc/auto.share
> > 
> > * -fstype=nfs4,rw,sec=krb5 nfs-server:/share/&
> > 
> > It gets mounted, same permissions as on nfs-server:
> > 
> > /share (0755)
> > 
> > But if I mount it with a direct map of:
> > 
> > /share -fstype=nfs4,rw,sec=krb5 nfs-server:/share in /etc/auto.direct
> > 
> > and
> > /etc/auto.master
> > 
> > /- /etc/auto.direct
> > 
> > Then it works as expected.
> > 
> > I've also tried /share -fstype=bind /mnt/share, same results.
> > 
> > This is with a freeipa server with kerberos / nfs and client,  on 
> > Fedora
> > 20.
> > 
> > Any ideas on what to look at?
> > 
> > But they are two quite different mounts.
> > They don't even mount the same locations.
> > 
> > The indirect mount will mount an autofs file system on /share and
> > attempt to mount individual NFS mounts at /share/<lookup name>.
> > 
> > But the direct mount will mount a direct trigger at /share and attempt
> > to mount nfs-server:/share on /share when it's accessed. Any mounts
> > within /share would need to be triggered by cross device mounting by 
> > the
> > kernel NFS client not autofs, assuming they have been exported with the
> > options to allow this.
> > 
> > You've not really described what the actual problem is, I'm not sure
> > what you're asking.
> > 
> > Ian
> 
> Hi, problem is I can not write into the mount point.
> For example I export /home on Nfs server with no_root_squash and 
> no_all_squash and mount it indirect on the nfs client as:
> /home /etc.auto.home in master
> and
> * -fstype=nfs nfs-server:/home/& in home map.
> 
> The result is that I can not write as root into /home to create home 
> folder auto or manually, keep getting permission denied.

Either I still don't understand the problem or I've already answered the
question.

"The indirect mount will mount an autofs file system on /share and
attempt to mount individual NFS mounts at /share/<lookup name>."

The mount /home is not the exported NFS mount, it's an autofs mount and
creating directories in it is not allowed by processes other than the
process that is managing the automount directory, usually automount(8).

That restriction is required as it would be far to easy to break
automount triggering if directory creation was allowed.

As I think you pointed out a direct mount of /home will allow creation
of directories within /home because it mounts the NFS export at /home.

If you want to use an indirect mount so that not all the directories
"show up" in /home then you need to run your user provisioning script on
the machine where the home directories exist and create them within the
exported directory itself.

Ian

