From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/18] Introduce automount support in the VFS [ver #4]
Date: Fri, 14 Jan 2011 11:20:33 +0000
Message-ID: <2212.1295004033@redhat.com>
References: <20110114070502.GC19804@ZenIV.linux.org.uk> <20110113215359.19406.37232.stgit@warthog.procyon.org.uk> <20110114070224.GB19804@ZenIV.linux.org.uk>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110114070502.GC19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> > As the result, we stop abusing do_add_mount() in there.  Moreover, with
> > pending mnt_devname nfs rework we will be able to get rid of passing
> > vfsmount to ->d_automount(), AFAICT, which would be nice...
> 
> BTW, what do you need vfsmount for in case of the only ->d_manage() instance
> you've got?

I'm not sure it's strictly necessary.  However, is it or will it be possible
for autofs to have per-namespace daemons?  I suspect I can probably downgrade
the path pointer to a dentry pointer.  It can always be upgraded later if we
find a need for it...

David
