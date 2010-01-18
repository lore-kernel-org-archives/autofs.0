From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
 block info
Date: Mon, 18 Jan 2010 14:35:53 -0500
Message-ID: <1263843353.4127.33.camel@localhost>
References: <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net>
	 <4806.1263567323@redhat.com> <9927.1263575308@redhat.com>
	 <20100115172633.GM19799@ZenIV.linux.org.uk>
	 <20100116101714.GN19799@ZenIV.linux.org.uk>
	 <20100117175723.GP19799@ZenIV.linux.org.uk> <4B53E1B5.2080202@themaw.net>
	 <20100118055929.GS19799@ZenIV.linux.org.uk> <4B542692.2070307@themaw.net>
	 <20100118102732.GU19799@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20100118102732.GU19799@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>, Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, David Howells <dhowells@redhat.com>

On Mon, 2010-01-18 at 10:27 +0000, Al Viro wrote: 
> Back to another question: which syscalls should and which syscalls should not 
> trigger automount on the last component?  Note that it's something we'd better
> be consistent about between autofs4 and cifs/afs/nfs...

In addition to the ones that trigger automounts now:

One syscall that we've had a lot of complaints about is 'stat()'. Since
it doesn't follow symlinks, it will fail to trigger the automount, and
will return bogus values for st_dev. This again confuses some versions
of the 'du' utility that check the value of st_dev before and after
entering the subdir.
(see https://bugzilla.redhat.com/show_bug.cgi?id=431166 )

In the cifs/afs/nfs case, statfs() should really trigger automounts too.
Not sure if we want that for the autofs case.

Finally, it makes little sense for cifs/afs/nfs to allow open() on the
underlying directory, even if O_NOFOLLOW is set. Again, autofs might be
an exception due to its reliance on ioctls as a method of communication
with the kernel.

Cheers
  Trond
