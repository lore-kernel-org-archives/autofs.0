From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 00/18] Introduce automount support in the VFS [ver #4]
Date: Fri, 14 Jan 2011 07:05:02 +0000
Message-ID: <20110114070502.GC19804@ZenIV.linux.org.uk>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
 <20110114070224.GB19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110114070224.GB19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Fri, Jan 14, 2011 at 07:02:24AM +0000, Al Viro wrote:

> As the result, we stop abusing do_add_mount() in there.  Moreover, with
> pending mnt_devname nfs rework we will be able to get rid of passing
> vfsmount to ->d_automount(), AFAICT, which would be nice...

BTW, what do you need vfsmount for in case of the only ->d_manage() instance
you've got?
