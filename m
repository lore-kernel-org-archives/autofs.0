From: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH v2 0/8] fs: add some missing ctime updates
Date: Wed, 30 Aug 2023 01:08:39 +0100
Message-ID: <20230830000839.GB461907@ZenIV>
References: <20230612104524.17058-1-jlayton@kernel.org>
Mime-Version: 1.0
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KPbzJvpAfmJnxRfz6vyXdTOuKHu0zGU5IcaLiuqidr0=; b=R5nzjv+Zq3LT9nshlafMmOel/V
        V9V15FrSV4M//ybfLydJkCutspaga94ytJEx9riJh1zL9kWGgjuuGRS3RGNQd6UTwUkizww5yCRXa
        65QMSK2fJSU4GVUhcmzwiC0Hq1HKwf7DGR4vmOTpwGMfQqlHke7T1R8K/2jSpp3mx40NSO3T4g2W/
        plks+ScqIJIQRzH6Fj1pBu+DVUhZ7fIoVLT08blX/7g4fVPc+bxoQXE8ePVX4WwsUQ6HaxLzBDWrJ
        7SC0zFm+4u87xlQbvEUtvlqkCX+4IE1iKrcHU8n3T8dKHajJ0gVzh2wyU+407y+rz29fwaL3T7RiK
        4HRq0m2Q==;
Content-Disposition: inline
In-Reply-To: <20230612104524.17058-1-jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: Al Viro <viro-rfM+Q5joDG/XmaaqVzeoHQ@public.gmane.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Layton <jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Christian Brauner <brauner-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Brad Warrum <bwarrum-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Ritu Agarwal <rituagar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ian Kent <raven-PKsaG3nR2I+sTnJN9+BGXg@public.gmane.org>, "Tigran A. Aivazian" <aivazian.tigran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Namjae Jeon <linkinjeon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sungjong Seo <sj1557.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Steve French <sfrench-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Paulo Alcantara <pc-mxznQ8SDR6Dby3iVrkZq2A@public.gmane.org>, Ronnie Sahlberg <lsahlber-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Shyam Prasad N <sprasad-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Tom Talpey <tom-CLs1Zie5N5HQT0dZR+AlfA@public.gmane.org>, John Johansen <john.johansen-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Paul Moore <paul-r2n+y4ga6xFZroRs9YW3xA@public.gmane.org>, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, "Serge E. Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>, R

On Mon, Jun 12, 2023 at 06:45:16AM -0400, Jeff Layton wrote:
> Jeff Layton (8):
>   ibmvmc: update ctime in conjunction with mtime on write
>   usb: update the ctime as well when updating mtime after an ioctl
>   autofs: set ctime as well when mtime changes on a dir
>   bfs: update ctime in addition to mtime when adding entries
>   efivarfs: update ctime when mtime changes on a write
>   exfat: ensure that ctime is updated whenever the mtime is
>   apparmor: update ctime whenever the mtime changes on an inode
>   cifs: update the ctime on a partial page write
> 
>  drivers/misc/ibmvmc.c             |  2 +-
>  drivers/usb/core/devio.c          | 16 ++++++++--------
>  fs/autofs/root.c                  |  6 +++---
>  fs/bfs/dir.c                      |  2 +-
>  fs/efivarfs/file.c                |  2 +-
>  fs/exfat/namei.c                  |  8 ++++----
>  fs/smb/client/file.c              |  2 +-
>  security/apparmor/apparmorfs.c    |  7 +++++--
>  security/apparmor/policy_unpack.c | 11 +++++++----
>  9 files changed, 31 insertions(+), 25 deletions(-)

As a possible followup (again, apologies for being MIA for months):
touch_cmtime(inode)...
