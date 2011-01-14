From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 19/18] Unexport do_add_mount() and add in
 follow_automount(), not ->d_automount()
Date: Fri, 14 Jan 2011 17:43:40 +0000
Message-ID: <20110114174340.GG19804@ZenIV.linux.org.uk>
References: <20110114154652.GD19804@ZenIV.linux.org.uk>
 <20110114070224.GB19804@ZenIV.linux.org.uk>
 <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
 <2443.1295005428@redhat.com>
 <6672.1295025969@redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6672.1295025969@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Fri, Jan 14, 2011 at 05:26:09PM +0000, David Howells wrote:
> 
> Unexport do_add_mount() and make ->d_automount() return the vfsmount to be
> added rather than calling do_add_mount() itself.  follow_automount() will then
> do the addition.
> 
> This slightly complicates things as ->d_automount() normally wants to add the
> new vfsmount to an expiration list and start an expiration timer.  The problem
> with that is that the vfsmount will be deleted if it has a refcount of 1 and
> the timer will not repeat if the expiration list is empty.
> 
> To this end, we require the vfsmount to be returned from d_automount() with a
> refcount of (at least) 2.  One of these refs will be dropped unconditionally.
> In addition, follow_automount() must get a 3rd ref around the call to
> do_add_mount() lest it eat a ref and return an error, leaving the mount we
> have open to being expired as we would otherwise have only 1 ref on it.

Yechh...  I'd rather take mntput_long() (yuck) out into callers (all two
of them) and lose the extra mntget/mntput in follow_automount().

> This patch also fixes the call to do_add_mount() for AFS and CIFS to propagate
> the mount flags from the parent vfsmount.

CIFS actually used to be OK; that breakage was introduced earlier in the
series.  AFS was broken wrt flags.  I'll fix the CIFS patch and adjust
that one accordingly.

