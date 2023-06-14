From: Christian Brauner <brauner@kernel.org>
Subject: Re: (subset) [PATCH v2 3/8] autofs: set ctime as well when mtime changes on a dir
Date: Wed, 14 Jun 2023 10:30:13 +0200
Message-ID: <20230614-marmeladen-blechnapf-873c26e176cb@brauner>
References: <20230612104524.17058-1-jlayton@kernel.org> <20230612104524.17058-4-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686731436;
        bh=5sOkTNkkHBdbRw2JX2dJi2tKIH7ENjxXYhVFqEgiEpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRZqPUqU0BwUN9jHEoglWuy0xEgoYyag/Ebn+rb0Vkv1pU4YIEbzbp79ipCyUrtxh
         uu5SSmyKUoI1KIaFNYpCGmYHIXb2asmRHSE1NzBkLRpCt3Lk6SOguRjQnw2e7R7/RE
         3jA20kzbdthCOfDkyHAr2RIu4FsSLyLI6XH8DA2HcU29jUMoC2mD9jrm9rg2mkUfCC
         fiHIUATN1wcmkhYcliwSeMfAeYVI8hK2mr8m3NIMM3pMKtWaDqvzxe5VRX3IwZIRDp
         k6p3K+ytT5NuIM6/QXPL9ncD1YxYtMcfr5ZIYEUleDDbnRtoLwM75vc9NwENqU3Y1d
         e+ig0BIIgMwMg==
In-Reply-To: <20230612104524.17058-4-jlayton@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=brauner@kernel.org; h=from:subject:message-id; bh=5sOkTNkkHBdbRw2JX2dJi2tKIH7ENjxXYhVFqEgiEpg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0VvWrXuWb1qASt//kd4FHqU18By+ppS/RFud89ejpqjjT Z+/1O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby5Bgjw7qZ1+/qxD5ZFinJah7vuf 6TQM5RjfV3nHf+b3iWcMttHxfDb9bHk9/X5L+18DmgM//eoU3cO9eIMDluPBbqbjtNMHa/Fg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Brad Warrum <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Kent <raven@themaw.net>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Ser

On Mon, 12 Jun 2023 06:45:19 -0400, Jeff Layton wrote:
> When adding entries to a directory, POSIX generally requires that the
> ctime also be updated alongside the mtime.
> 
> 

Can't find a tree for this patch, so picking this patch up unless told otherwise.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[3/8] autofs: set ctime as well when mtime changes on a dir
      https://git.kernel.org/vfs/vfs/c/9b37b3342a98
