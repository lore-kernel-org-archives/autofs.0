From: Andrei Amuraritei <sirdeiu@bydeiu.net>
Subject: Re: Mount point permission
Date: Sun, 07 Sep 2014 09:28:10 +0300
Message-ID: <707311a4acd98d5f6adc0c7eb3aa2ba6@imap.bydeiu.net>
References: <1409770624.8847.7.camel@deiu.bydeiu.net>
 <1409793375.2558.7.camel@perseus.themaw.net>
 <1410030857.2072.9.camel@deiu.bydeiu.net>
 <1410056799.3464.6.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1410056799.3464.6.camel@perseus.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

On 2014-09-07 05:26, Ian Kent wrote:
> On Sat, 2014-09-06 at 22:14 +0300, Andrei Amuraritei wrote:
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
> This is with a freeipa server with kerberos / nfs and client,  on 
> Fedora
> 20.
> 
> Any ideas on what to look at?
> 
> But they are two quite different mounts.
> They don't even mount the same locations.
> 
> The indirect mount will mount an autofs file system on /share and
> attempt to mount individual NFS mounts at /share/<lookup name>.
> 
> But the direct mount will mount a direct trigger at /share and attempt
> to mount nfs-server:/share on /share when it's accessed. Any mounts
> within /share would need to be triggered by cross device mounting by 
> the
> kernel NFS client not autofs, assuming they have been exported with the
> options to allow this.
> 
> You've not really described what the actual problem is, I'm not sure
> what you're asking.
> 
> Ian

Hi, problem is I can not write into the mount point.
For example I export /home on Nfs server with no_root_squash and 
no_all_squash and mount it indirect on the nfs client as:
/home /etc.auto.home in master
and
* -fstype=nfs nfs-server:/home/& in home map.

The result is that I can not write as root into /home to create home 
folder auto or manually, keep getting permission denied.
But mounted directly either with a direct map in auto.master or manually 
with mount, then it works, as root can write into the /home mount point. 
The point being that I'd like to share the home folder but not auto 
mount all the users folder. That's why I want to use the wildcard 
indirect mount map.


Andrei Amuraritei
