From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 04/10] Documentation: filesystems: directory-locking: drop doubled word
Date: Fri,  3 Jul 2020 14:43:19 -0700
Message-ID: <20200703214325.31036-5-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-unionfs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4dSawoUbToBjQYPQeKu/vzB/+jr94zPa4ftwUT26O9o=; b=FQY8eH7NIX5N2+6YzPa/p7i8cz
        MF2x/KxqTmwJuCuOd4UfLyGT5QFtwIU9fc5HnT2wmrLfh6JYKbBWA1s1aPI3FXnxw+qF7idP8vPAU
        4uKGmx1Ewgs3akvMX3yIH0DE1Xqiayl+wYo/oIVQwtosnwnVX7zCNwsANO/IkAzVroVTZhfstH5rD
        FngNaGGHCn2X7P6rW+3uFQww3Rf6W45T3IXxMBnhV0K4PkIWL9+P7yeR2DGW9S2PWclqIX+M6Z51g
        4L9aR7Ssy0XGRCqVszKCww80n5XEtshMOxIQh54yhrTswTiKZ/cfTTQm4I5uvdoucelySkuzV1LI0
        3Xwoa/hQ==;
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
Sender: linux-unionfs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/directory-locking.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/filesystems/directory-locking.rst
+++ linux-next-20200701/Documentation/filesystems/directory-locking.rst
@@ -28,7 +28,7 @@ RENAME_EXCHANGE in flags argument) lock
 if the target already exists, lock it.  If the source is a non-directory,
 lock it.  If we need to lock both, lock them in inode pointer order.
 Then call the method.  All locks are exclusive.
-NB: we might get away with locking the the source (and target in exchange
+NB: we might get away with locking the source (and target in exchange
 case) shared.
 
 5) link creation.  Locking rules:
@@ -56,7 +56,7 @@ rules:
 	* call the method.
 
 All ->i_rwsem are taken exclusive.  Again, we might get away with locking
-the the source (and target in exchange case) shared.
+the source (and target in exchange case) shared.
 
 The rules above obviously guarantee that all directories that are going to be
 read, modified or removed by method will be locked by caller.
