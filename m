From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 02/10] Documentation: filesystems: caching/operations: drop doubled word
Date: Fri,  3 Jul 2020 14:43:17 -0700
Message-ID: <20200703214325.31036-3-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-unionfs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hofn6sBAbTd2HcWy0kbqF2KoGz2MeYQfT0WYKeLl/94=; b=vRPA0RBJSRNx+4xaR47L24tptq
        BHkA0Mtx/7VoSGsa2aKDwsNNkntcBodFVXfxh5dJJvRlQE+jRFL2ORa3+bIcmDh+E6uwyxVOWm3y9
        ooWTTRczp4CV8td/BUYUXa7mM42iTMzMqy+kEVaquBG6AvDKZ+Ue7rZwJX4WwXnqUVjlT432L2rpX
        iK51avkugZjnvNH3Kb8HguBYcJxI89tP93mCk8UxTYHgQpTqYNk4DAX53SrAAHU/314cKFrPT4R8V
        /KZxnYzBfEJn6cHi1djB5wJgCvUfiLjVOrsjspLfw3SEKPc335KgqwST6NuRlCNwuarPkZ6TEuAmf
        m1L97n4A==;
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
Sender: linux-unionfs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org

Drop the doubled word "be".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
---
 Documentation/filesystems/caching/operations.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/filesystems/caching/operations.rst
+++ linux-next-20200701/Documentation/filesystems/caching/operations.rst
@@ -27,7 +27,7 @@ data storage and retrieval routines.  It
 fscache_operation structs, though these are usually embedded into some other
 structure.
 
-This facility is available to and expected to be be used by the cache backends,
+This facility is available to and expected to be used by the cache backends,
 and FS-Cache will create operations and pass them off to the appropriate cache
 backend for completion.
 
