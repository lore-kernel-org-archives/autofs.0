From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 4/6] autofs - use struct for mount params
Date: Wed, 14 Nov 2018 13:56:01 +0800
Message-ID: <1c34ff9bf8852686371403d8f4efdfdcd5019042.camel@themaw.net>
References: <154207297923.11064.15608451642929332541.stgit@pluto-themaw-net>
         <201811140948.eYw7FEbR%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        MEN4GmTBcN/AZNWoncXWTHY092zc2Nu49Y5cg8mXNDc=; b=AAF8SG+9jcxknUSG
        ZVg6KkDhpCpmPmB9z4hOrILmzpWY7In8xL61UyvCiwH0hig50gPzlq4NojaAU2Dw
        EBlgHRqxWi4DE1IDEl45Y02OjOZ2A0dod2u2WGRTiATuAU9UJSS2eCiPATB2xjYF
        x+vWa49AEM7SfieOqJHwKptLVWqAg4B8R7lPLNqIN3WJ9ymrDjqR3Qr9maW1TMRF
        9UB8Lgk3uUc/Ucp7S8HQAHgse7QfDIZ0h9GbJo/cQAq3T6hay5aUTVQ6j3PTIOXD
        OIDCwWmc1xeI+QfVOwe8DZQKQsTkcXUjQeTWG8lstHO9pEnRbdkT2cfuLNxuGgRQ
        65dcmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=MEN4GmTBcN/AZNWoncXWTHY092zc2Nu49Y5cg8mXN
        Dc=; b=vPcW7dpDVeMbhQOeHvTAU2go+ml89UUzSY0mWmXtPQFlZBvfMmrQ7cLzM
        ppbwZRsXPfyM8I5OG/TRxKgdmCfo139xEbFYGMnWR8bhHXeXn87XrFL4Kenn15dI
        VS9RIMiuldsGbKXBZKY33fwnMWyTbXTz9QnvjHg+95LLzXdGVBQbzwDaJA1Q3D/9
        rmISuu4KQYDFKZfQnpmZ2PA9r02ZQ/3rT5+enniVG/T4IWQ9gW/s8bKxoUmv60Pa
        2/yzKt+5HYvbvMOabz85m2mycIlw//oPahOG5N8daM+lvOpRzL/kBvbuCD4L4etU
        InZySbfwYDMtOod81XBgJ2zwYfFHw==
In-Reply-To: <201811140948.eYw7FEbR%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kbuild-all@01.org, Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Wed, 2018-11-14 at 09:54 +0800, kbuild test robot wrote:
> Hi Ian,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.20-rc2]
> [cannot apply to next-20181113]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system]
> 
> url:    
> https://github.com/0day-ci/linux/commits/Ian-Kent/autofs-improve-ioctl-sbi-checks/20181114-021150
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    fs/autofs/inode.c: In function 'autofs_fill_super':
> > > fs/autofs/inode.c:361:28: error: invalid type argument of '->' (have
> > > 'struct autofs_fs_params')
> 
>      root_inode->i_uid = params->uid;
>                                ^~
>    fs/autofs/inode.c:362:28: error: invalid type argument of '->' (have
> 'struct autofs_fs_params')
>      root_inode->i_gid = params->gid;
>                                ^~

Oh, I fixed that, I must have messed up somewhere, I'll check what I have
again.

Andrew, due to the patch order dependencies I think it would be best for
me to re-post the series so please ignore this series.

I'll put a v2 in the title of the re-posted series so they can be identified
(is that the right thing to do?).

> 
> vim +361 fs/autofs/inode.c
> 
>    313	
>    314	int autofs_fill_super(struct super_block *s, void *data, int
> silent)
>    315	{
>    316		struct inode *root_inode;
>    317		struct dentry *root;
>    318		struct autofs_fs_params params;
>    319		struct autofs_sb_info *sbi;
>    320		struct autofs_info *ino;
>    321		int ret = -EINVAL;
>    322	
>    323		sbi = autofs_alloc_sbi(s);
>    324		if (!sbi)
>    325			return -ENOMEM;
>    326	
>    327		pr_debug("starting up, sbi = %p\n", sbi);
>    328	
>    329		s->s_fs_info = sbi;
>    330		s->s_blocksize = 1024;
>    331		s->s_blocksize_bits = 10;
>    332		s->s_magic = AUTOFS_SUPER_MAGIC;
>    333		s->s_op = &autofs_sops;
>    334		s->s_d_op = &autofs_dentry_operations;
>    335		s->s_time_gran = 1;
>    336	
>    337		/*
>    338		 * Get the root inode and dentry, but defer checking for
> errors.
>    339		 */
>    340		ino = autofs_new_ino(sbi);
>    341		if (!ino) {
>    342			ret = -ENOMEM;
>    343			goto fail_free;
>    344		}
>    345		root_inode = autofs_get_inode(s, S_IFDIR | 0755);
>    346		if (!root_inode) {
>    347			ret = -ENOMEM;
>    348			goto fail_ino;
>    349		}
>    350		root = d_make_root(root_inode);
>    351		if (!root)
>    352			goto fail_iput;
>    353	
>    354		root->d_fsdata = ino;
>    355	
>    356		memset(&params, 0, sizeof(struct autofs_fs_params));
>    357		if (autofs_parse_options(data, &params)) {
>    358			pr_err("called with bogus options\n");
>    359			goto fail_dput;
>    360		}
>  > 361		root_inode->i_uid = params->uid;
>    362		root_inode->i_gid = params->gid;
>    363	
>    364		ret = autofs_apply_sbi_options(sbi, &params);
>    365		if (ret)
>    366			goto fail_dput;
>    367	
>    368		if (autofs_type_trigger(sbi->type))
>    369			__managed_dentry_set_managed(root);
>    370	
>    371		root_inode->i_fop = &autofs_root_operations;
>    372		root_inode->i_op = &autofs_dir_inode_operations;
>    373	
>    374		/*
>    375		 * Success! Install the root dentry now to indicate
> completion.
>    376		 */
>    377		s->s_root = root;
>    378		return 0;
>    379	
>    380		/*
>    381		 * Failure ... clean up.
>    382		 */
>    383	fail_dput:
>    384		dput(root);
>    385		goto fail_free;
>    386	fail_iput:
>    387		iput(root_inode);
>    388	fail_ino:
>    389		autofs_free_ino(ino);
>    390	fail_free:
>    391		kfree(sbi);
>    392		s->s_fs_info = NULL;
>    393		return ret;
>    394	}
>    395	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

