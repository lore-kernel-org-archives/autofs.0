From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/9] usb: update the ctime as well when updating mtime
 after an ioctl
Date: Fri, 9 Jun 2023 15:10:24 +0200
Message-ID: <2023060903-headache-very-c029@gregkh>
References: <20230609125023.399942-1-jlayton@kernel.org>
 <20230609125023.399942-3-jlayton@kernel.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686316227;
        bh=UDgymT2rhCU6DESF/YCiKaWmfZRHvZQoUcAfEB8ZmWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGZH+ZOjneapjQSK1IqmZBDuE4mFnyhlsRpqtjmsPzrNsJ4zy4akL4P0yciY2B45W
         5dUQzaTZDowoyRRkGVZBciT1Tf/1Vmlevn5D0LUceNtbonLCs5Xx++ggHHUerxifsG
         xjcNDDMMZzk3H58c+hjy6yFDwcg70muWawDFZ1nE=
Content-Disposition: inline
In-Reply-To: <20230609125023.399942-3-jlayton@kernel.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Brad Warrum <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Ian Kent <raven@themaw.net>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jm>

On Fri, Jun 09, 2023 at 08:50:16AM -0400, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Sorry, but I can't take commits without any changelog text at all (nor
would you want me to...)

thanks,

greg k-h
