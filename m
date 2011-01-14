From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/18] Introduce automount support in the VFS [ver #4]
Date: Fri, 14 Jan 2011 11:54:48 +0000
Message-ID: <2591.1295006088@redhat.com>
References: <2443.1295005428@redhat.com> <20110114070224.GB19804@ZenIV.linux.org.uk> <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <2443.1295005428@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 
Cc: dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> It would be simpler, perhaps, to allow d_automount() to return the list also:
> 
>    struct vfsmount *(*d_automount)(struct path *mountpoint,
> 				   struct list_head **expiry_list_to_use);
> 
> This pointer can then be passed directly to do_add_mount() and we don't have
> to worry about having an extra reference or cleaning up the list on error.

However, that isn't good enough as the filesystem may also need to start up
the time-based expirer, which in the case of AFS, NFS and CIFS doesn't repeat
if the list is empty - so if the mounting process gets preempted...

David
