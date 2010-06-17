From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH 04/38] autofs4: Save autofs trigger's vfsmount
 in super block info
Date: Thu, 17 Jun 2010 10:04:41 +0800
Message-ID: <1276740281.2236.26.camel@localhost>
References: <1276627208-17242-1-git-send-email-vaurora@redhat.com>
	 <1276627208-17242-5-git-send-email-vaurora@redhat.com>
	 <1276661043.2339.35.camel@localhost>  <20100616231421.GD13908@shell>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=pQoAzEqJRor4AqCEkVnAnPExQKA=; b=WwYFitSbxi6ESSFcvxSekwYAuciOuEO4zDQM5NwyeOW2DVxGquW3Njixr0KQ8ynN5fOmPBaYqB6dXGWhCxhUu/crQZc0ovMhI8hr2w8ykAcJRlKopLumEMzxIUxAnah8FTlYS+zcftJuzzY+j6Nm3ngXZrtfd2ZMQq8i6/IB6kY=
In-Reply-To: <20100616231421.GD13908@shell>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Valerie Aurora <vaurora@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, autofs@linux.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>

On Wed, 2010-06-16 at 19:14 -0400, Valerie Aurora wrote:
> On Wed, Jun 16, 2010 at 12:04:03PM +0800, Ian Kent wrote:
> > On Tue, 2010-06-15 at 11:39 -0700, Valerie Aurora wrote:
> > > From: Jan Blunck <jblunck@suse.de>
> > > 
> > > XXX - This is broken and included just to make union mounts work.  See
> > > discussion at:
> > > 
> > > http://kerneltrap.org/mailarchive/linux-fsdevel/2010/1/15/6708053/thread
> > 
> > Instead of saving the vfsmount we could save a pointer to the dentry of
> > the mount point in the autofs super block info struct. I think that's
> > the bit I don't have so it would be sufficient for a lookup_mnt() for
> > the needed vfsmount in ->follow_mount().
> > 
> > Objections?
> > Suggestions?
> 
> I'm not sure... it seems like it would have the same problem that Al
> described with pinning the vfsmount forever.  But I don't know autofs
> at all.

That's why I asked.
But I don't see how the dentry can go away since it's covered by the
mount for the life of the mount.

> 
> Could you run through a quick example of the case that triggers this
> problem in the first place?  The problem is when you have a symlink
> that triggers an automount, and you are trying to get from the target
> of the symlink to the vfsmount of the file system containing the
> symlink in the first place?  Or do I have that wrong?

Ha!

Yes, you would think we were talking about a symlink but this dentry is
a directory, a trigger for a mount that uses ->follow_mount() to do the
mount, similar to the way the NFS client mounts nohide mounts when they
crossed.

In the autofs case we have:

<path in fs>/dir
      <autofs fs (with type direct or offset) mounted on>/dir

When ->follow_link() is called the nameidata has the vfsmount of the
once removed mount because it hasn't yet been updated in (say)
link_path_walk(), but the dentry passed to ->follow_link() is the global
root of the autofs fs so we have no way of discovering the vfsmount or
the dentry upon which the autofs trigger mount is mounted. Which of
course prevents us from mounting and following the trigger.

The example is rather poor, sorry, hope it is sufficient.

