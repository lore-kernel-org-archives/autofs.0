From: "J. R. Okajima" <hooanon05@yahoo.co.jp>
Subject: Re: [autofs] [PATCH 04/38] autofs4: Save autofs trigger's vfsmount in super block info
Date: Wed, 23 Jun 2010 11:07:13 +0900
Message-ID: <9219.1277258833@jrobl>
References: <1276627208-17242-1-git-send-email-vaurora@redhat.com> <1276627208-17242-5-git-send-email-vaurora@redhat.com> <1276661043.2339.35.camel@localhost> <1277091579.3827.9.camel@localhost> <E1OQghj-0001Bt-RU@pomaz-ex.szeredi.hu> <1277181999.2829.2.camel@localhost> <26799.1277185756@jrobl> <1277256214.2848.17.camel@localhost>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1277256214.2848.17.camel@localhost>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@zeniv.linux.org.uk, vaurora@redhat.com, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, linux-fsdevel@vger.kernel.org, jblunck@suse.de


Ian Kent:
> I may be missing something about this, but why is it safe to use
> iterate_mounts(), since it doesn't take the vfsmount_lock when
> traversing the list of mounts?

The sample code was not correct.
We need to acquire vfsmount_lock or down_read(namespace_sem).

Or it may be better to extract the body of iterate_mounts() and create a
new function __iterate_mounts() such like that.

__iterate_mounts()
{
	/* equiv to the current iterate_mounts */
}

iterate_mount()
{
	down_read(namespace_sem);
	or spin_lock(&vfsmount_lock);

	__iterate_mount();

	spin_unlock(&vfsmount_lock);
	or up_read(namespace_sem);
}


J. R. Okajima
