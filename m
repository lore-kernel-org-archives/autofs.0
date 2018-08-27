From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] autofs - fix autofs_sbi() does not check super block type
Date: Mon, 27 Aug 2018 02:03:58 +0100
Message-ID: <20180827010358.GZ6515@ZenIV.linux.org.uk>
References: <153475422934.17131.7563724552005298277.stgit@pluto.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <153475422934.17131.7563724552005298277.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Aug 20, 2018 at 04:37:09PM +0800, Ian Kent wrote:
> The autofs_sbi() inline function does not check the super block
> magic number to verify it has been given an autofs super block.

IMO it's the wrong way to fix it.  The one and only caller where that
check might trigger is

                if (!fp) {
                        if (cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
                                goto cont;
                        err = -EBADF;
                        goto out;
                }

                sbi = autofs_dev_ioctl_sbi(fp);
                if (!sbi || sbi->magic != AUTOFS_SBI_MAGIC) {
                        err = -EINVAL;
                        fput(fp);
                        goto out;
                }
with
static struct autofs_sb_info *autofs_dev_ioctl_sbi(struct file *f)
{
        struct autofs_sb_info *sbi = NULL;
        struct inode *inode;

        if (f) { 
                inode = file_inode(f);
                sbi = autofs_sbi(inode->i_sb);
        }
        return sbi;
}

First of all, what is that `if (f)' doing in there?  We have just checked
that in the only caller.

Next, dereferencing the result of autofs_sbi() does need to be preceded
by making sure that superblock is autofs one, all right... and what are
we doing in that first dereferencing, again?

IOW, turn that into

	if (!fp) {
		....
		goto out;
	}
	sb = file_inode(fp)->i_sb;
	if (sb->s_type != &autofs_fs_type)
		bugger off
	sbi = autofs_sbi(sb);
	....

and be done with that.  Other callers of autofs_sbi() really shouldn't
happen to other filesystem's superblocks...
