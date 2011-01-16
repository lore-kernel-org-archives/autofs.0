From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link() [ver #4]
Date: Sun, 16 Jan 2011 01:17:50 +0000
Message-ID: <20110116011750.GQ19804@ZenIV.linux.org.uk>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
 <20110113215405.19406.73651.stgit@warthog.procyon.org.uk>
 <20110116000947.GO19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110116000947.GO19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Sun, Jan 16, 2011 at 12:09:47AM +0000, Al Viro wrote:

> AFS issue is completely separate story; that one is mine and it's old.
> Just that now it became more visible; earlier it only messed the expiry
> logics (by screwing ->mnt_ghosts accounting).  I've a half-finished fix
> for that, but it needs more beating (and will be stable@ fodder, BTW).
> Later...

OK, umount_tree bug (the source of AFS leak) got presumably fixed in
#untested.  Have fun...
