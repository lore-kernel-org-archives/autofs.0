From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 19/18] Unexport do_add_mount() and add in
 follow_automount(), not ->d_automount()
Date: Sun, 16 Jan 2011 00:24:59 +0000
Message-ID: <20110116002459.GP19804@ZenIV.linux.org.uk>
References: <20110114070224.GB19804@ZenIV.linux.org.uk>
 <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
 <2443.1295005428@redhat.com>
 <6672.1295025969@redhat.com>
 <20110114174340.GG19804@ZenIV.linux.org.uk>
 <20110114175648.GH19804@ZenIV.linux.org.uk>
 <20110114180625.GI19804@ZenIV.linux.org.uk>
 <AANLkTimMVF7HSOqJGWphY2fbaXDbegppe+Vug8e5V1HN@mail.gmail.com>
 <20110115133029.GN19804@ZenIV.linux.org.uk>
 <AANLkTinG5yUjKns5nAzgtW526kKOBHT-eG1YyKR83wh5@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinG5yUjKns5nAzgtW526kKOBHT-eG1YyKR83wh5@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Jan 16, 2011 at 05:33:24AM +1100, Nick Piggin wrote:

> Definitely agree.
> 
> I'm on the road at the moment so would much appreciate if you can
> cut the patch, but I could suggest something along the lines of:

Easier than that, actually.  All it takes is (in #for-next, yet to
be reordered in front of queue)
        if (IS_ERR(dentry))
                goto fail;
+       if (nd->flags & LOOKUP_RCU)
+               goto done2;
        goto done;
in the end of need_revalidate and
                if (dentry->d_flags & DCACHE_OP_REVALIDATE)
                        goto need_revalidate;
+done2:
in LOOKUP_RCU side of if ()...

need_lookup does *not* suffer the same problem; you can't get there without
dropping LOOKUP_RCU - the first thing it does is grabbing a mutex, for fsck
sake...  And yes, you do drop RCU on all paths leading there.  I certainly
don't like the ugliness of that code, but rewriting that to something less...
unpleasant is a separate story.

Again, see #for-next; I'll reorder it shortly.
