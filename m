From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 05/10] Documentation: filesystems: fsverity: drop doubled word
Date: Fri,  3 Jul 2020 14:43:20 -0700
Message-ID: <20200703214325.31036-6-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QYt3pLrvEkgdE5J9HL0HcJrm5k49qsMnkbwk8AJ+Pa4=; b=DYk4ml3k/OpYg3wEdP54cuw5kr
        9boTO/p72S7yr71IB6JW1UzHP60tl2Rjpizt8RMtwF/N+xBTrN/W43HOaKN7e/KUAlKoWB18QOBGd
        4HJZTZ7ziQNpfeu2fN/PcKVghE+Y45mLZGCntE7MFVoTk+9DXhBS+VqbOUNF2dLgx5EvJOKa9EAvR
        BFLuKH6X7/OrHc2z2e3CwCxWdlHV5roAefwDtQMbQbcN+J/KMVXX/j6y8ljQqa3QBTtaOeSrdQHx7
        9/JSu6jVUxiH8uZayeLZMvfnbKE5ET4/3GgZrnomJyH2UWYzO6pCIOvmp+Tj9pc8cVvEX3arI9ZRg
        btS/XlIg==;
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
Cc: linux-fscrypt@vger.kernel.org
---
 Documentation/filesystems/fsverity.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/filesystems/fsverity.rst
+++ linux-next-20200701/Documentation/filesystems/fsverity.rst
@@ -659,7 +659,7 @@ weren't already directly answered in oth
       retrofit existing filesystems with new consistency mechanisms.
       Data journalling is available on ext4, but is very slow.
 
-    - Rebuilding the the Merkle tree after every write, which would be
+    - Rebuilding the Merkle tree after every write, which would be
       extremely inefficient.  Alternatively, a different authenticated
       dictionary structure such as an "authenticated skiplist" could
       be used.  However, this would be far more complex.
