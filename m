From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than abusing follow_link() [ver #4]
Date: Sun, 16 Jan 2011 18:12:42 +0000
Message-ID: <22089.1295201562@redhat.com>
References: <20110116011750.GQ19804@ZenIV.linux.org.uk> <20110113215359.19406.37232.stgit@warthog.procyon.org.uk> <20110113215405.19406.73651.stgit@warthog.procyon.org.uk> <20110116000947.GO19804@ZenIV.linux.org.uk>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110116011750.GQ19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> OK, umount_tree bug (the source of AFS leak) got presumably fixed in
> #untested.  Have fun...

Works for me.

Acked-by: David Howells <dhowells@redhat.com>
