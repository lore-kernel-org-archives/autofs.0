From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 05/10] Documentation: filesystems: fsverity: drop doubled
 word
Date: Tue, 7 Jul 2020 11:10:08 -0700
Message-ID: <20200707181008.GC839@sol.localdomain>
References: <20200703214325.31036-1-rdunlap@infradead.org>
 <20200703214325.31036-6-rdunlap@infradead.org>
Mime-Version: 1.0
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594145409;
        bh=rvnU/JSMgTQ4ezgAJ8wlMxfyHZRX9bjgixDnhUVnFuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0bR1Iq6mutvhR5+xI2ajkl+iuZwNxvp8VjIWUA7BC2h0bwliZ6P1/89CTaxsVOFI
         IiiWWUHDcqqvH1GLqSyBVD38E9ETG70IpKSWfdhuvgJm5SEMFF16ghslfpKiXeRX/l
         9TjgqN/cJDaq9wvjltU+DZmzK4ZiN8TuMNVpzE44=
Content-Disposition: inline
In-Reply-To: <20200703214325.31036-6-rdunlap@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org

On Fri, Jul 03, 2020 at 02:43:20PM -0700, Randy Dunlap wrote:
> Drop the doubled word "the".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Theodore Y. Ts'o <tytso@mit.edu>
> Cc: linux-fscrypt@vger.kernel.org
> ---
>  Documentation/filesystems/fsverity.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/filesystems/fsverity.rst
> +++ linux-next-20200701/Documentation/filesystems/fsverity.rst
> @@ -659,7 +659,7 @@ weren't already directly answered in oth
>        retrofit existing filesystems with new consistency mechanisms.
>        Data journalling is available on ext4, but is very slow.
>  
> -    - Rebuilding the the Merkle tree after every write, which would be
> +    - Rebuilding the Merkle tree after every write, which would be
>        extremely inefficient.  Alternatively, a different authenticated
>        dictionary structure such as an "authenticated skiplist" could
>        be used.  However, this would be far more complex.

Acked-by: Eric Biggers <ebiggers@google.com>
