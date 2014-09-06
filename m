From: Andrei Amuraritei <sirdeiu@bydeiu.net>
Subject: Re: Mount point permission
Date: Sat, 06 Sep 2014 22:14:17 +0300
Message-ID: <1410030857.2072.9.camel@deiu.bydeiu.net>
References: <1409770624.8847.7.camel@deiu.bydeiu.net>
	 <1409793375.2558.7.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1409793375.2558.7.camel@perseus.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

On Thu, 2014-09-04 at 09:16 +0800, Ian Kent wrote:
> On Wed, 2014-09-03 at 21:57 +0300, Amuraritei Andrei wrote:
> > Hello, 
> > 
> > I'm using autofs 5.0.7 on Fedora 20 and have a question regarding the
> > mount point permissions.
> > 
> > Specifically if autofs creates a direct or indirect mount point, for
> > example /share (which holds the storage nfs exported folder), I can't
> > seem to create another folder in /share.
> > 
> > So mkdir /share/storage/dir1 works. But mkdir /share/dir1 doesn't. I
> > guess it's by design(?) but couldn't find anything specific about this.
> > 
> > Permissions are root:root 0755 for /share from filesystem. But when
> > trying mkdir /share/dir (while it's mounted by autofs),  and as root, I
> > get permission denied.
> 
> If there is a mount on top of /share, NFS for example, then permissions
> are managed by NFS. If you can't create a directory in this case then
> investigate possible NFS permissions problems.
> 
> > 
> > Is this because of autofs needing to unmount /share when not used (with
> > timeout) or is it just some bug ?
> 
> Processes other than the one managing the automount point are not
> supposed to be able to create directories within an autofs file system.
> It's far to easy to break the kernel detection of directories that are
> mount points by creating directories within an autofs file system.
> Perhaps mountpoints could be detected differently but that isn't as
> simple to do as it sounds.
> 
> Ian
> 

Hi Ian and thanks for your time, sorry my reply is so late.

Now regarding the issue I get is that if I mount /share with autofs as:

/etc/auto.master

/share /etc/auto.share

/etc/auto.share

* -fstype=nfs4,rw,sec=krb5 nfs-server:/share/&

It gets mounted, same permissions as on nfs-server:

/share (0755)

But if I mount it with a direct map of:

/share -fstype=nfs4,rw,sec=krb5 nfs-server:/share in /etc/auto.direct 

and 
/etc/auto.master 

/- /etc/auto.direct

Then it works as expected.

I've also tried /share -fstype=bind /mnt/share, same results.

This is with a freeipa server with kerberos / nfs and client,  on Fedora
20.

Any ideas on what to look at?

Thanks.


Andrei Amuraritei

