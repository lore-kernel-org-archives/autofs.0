From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 01/10] autofs4 - use macros for active list handling
Date: Tue, 6 Oct 2009 13:49:18 -0700
Message-ID: <20091006134918.4d5dcbaf.akpm@linux-foundation.org>
References: <20091001010054.7675.77673.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20091001010054.7675.77673.stgit@zeus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, sage@newdream.net, viro@ZenIV.linux.org.uk, adilger@sun.com, hch@infradead.org, yehuda@newdream.net

On Thu, 01 Oct 2009 09:00:55 +0800
Ian Kent <raven@themaw.net> wrote:

> Define some simple macro functions for adding and deleting entries
> on the active (and unhashed) dentry list.

A "macro" is that thing which we create with #define.

> +static void autofs4_add_active(struct dentry *dentry)
> +{
> +	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
> +	struct autofs_info *ino = autofs4_dentry_ino(dentry);
> +	if (ino) {
> +		spin_lock(&sbi->lookup_lock);
> +		if (!ino->active_count) {
> +			if (list_empty(&ino->active))
> +				list_add(&ino->active, &sbi->active_list);
> +		}
> +		ino->active_count++;
> +		spin_unlock(&sbi->lookup_lock);
> +	}
> +	return;
> +}
> +
> +static void autofs4_del_active(struct dentry *dentry)
> +{
> +	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
> +	struct autofs_info *ino = autofs4_dentry_ino(dentry);
> +	if (ino) {
> +		spin_lock(&sbi->lookup_lock);
> +		ino->active_count--;
> +		if (!ino->active_count) {
> +			if (!list_empty(&ino->active))
> +				list_del_init(&ino->active);
> +		}
> +		spin_unlock(&sbi->lookup_lock);
> +	}
> +	return;
> +}

These aren't macros!  I changed the titles and changelogs of patches 1,
2 and 3 to use the term "helper functions".

