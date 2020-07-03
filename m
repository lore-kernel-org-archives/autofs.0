From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 08/10] Documentation: filesystems: path-lookup: drop doubled word
Date: Fri,  3 Jul 2020 14:43:23 -0700
Message-ID: <20200703214325.31036-9-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iC52qoRmLcwFciCkqPwzA3sza3CsSIpvy4KRurXO10U=; b=EvFYgB3HkAOfgpEW7n7DPinnpX
        GB+9PIK2jY6Yw9kFEB0QxKEI/gUDO+bLzbVPabFSUUrZQ/gx5dkP0MjBLxM9U8s1qc9xsXcor7/GK
        f2MsQZ8QMUI7+A1REYGNfbtH/cRbnZB9TSh80Y8kFSjIMPQQam2sbBt0p9kB4h6MuOeWDg8wkccxH
        hoGLlNQNlOiJ94RizOjbZZEXglwOTyUMEYAl5Q1uHGMReVFoDS0azqtvwwDfLZQOR2F7QkBsJC6g1
        bLNFIdD8TkDKf2unNALJzzVJyRYJLLOlObcy/XKj8yYJVULZrBQUFRRkBHlrv2vaBOIn6Uganrj0M
        dSlXFhgA==;
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org

Drop the doubled word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/path-lookup.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/filesystems/path-lookup.rst
+++ linux-next-20200701/Documentation/filesystems/path-lookup.rst
@@ -1365,7 +1365,7 @@ as well as blocking ".." if it would jum
 resolution of "..". Magic-links are also blocked.
 
 ``LOOKUP_IN_ROOT`` resolves all path components as though the starting point
-were the filesystem root. ``nd_jump_root()`` brings the resolution back to to
+were the filesystem root. ``nd_jump_root()`` brings the resolution back to
 the starting point, and ".." at the starting point will act as a no-op. As with
 ``LOOKUP_BENEATH``, ``rename_lock`` and ``mount_lock`` are used to detect
 attacks against ".." resolution. Magic-links are also blocked.
