From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: WARNING: at fs/dcache.c:1359 d_set_d_op [was: mmotm 2011-01-06-15-41
 uploaded]
Date: Thu, 13 Jan 2011 10:57:24 +0100
Message-ID: <4D2ECC84.8050406@gmail.com>
References: <201101070014.p070Egpo023959@imap1.linux-foundation.org> <4D2ECB56.4070802@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=muv+rCRJSycHElDsYiqcCZ5S/YS2Kwg/+XGiy2bep9M=;
        b=CCIQa645RSv2KsX9wnGVg1pgxGoyw8ral7FgWKb8EIIdXq5hj/cXYPIYoWua22+bpi
         CQZenz3efeBICwMlsu2Mmu1VlFDbcsX19agZ8VSsLj8tu94AJGv4VJoxkPzoh5iP1XVW
         9a+eqNjvPUJDJ5fzuPsk9AiL/1b4euS4TBkHo=
In-Reply-To: <4D2ECB56.4070802@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-fsdevel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@linux.kernel.org, npiggin@kernel.dk

On 01/13/2011 10:52 AM, Jiri Slaby wrote:
> On 01/07/2011 12:41 AM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2011-01-06-15-41 has been uploaded to
> 
> Hi, after some uptime and several suspend/resume cycles, I got:
> WARNING: at fs/dcache.c:1359 d_set_d_op+0x82/0xb0()
> Hardware name: To Be Filled By O.E.M.
> Modules linked in: dvb_usb_af9015 tda18271 af9013 dvb_usb dvb_core
> Pid: 3474, comm: automount Tainted: G        W   2.6.37-mm1_64+ #1344
> Call Trace:
>  [<ffffffff8106bd2a>] ? warn_slowpath_common+0x7a/0xb0
>  [<ffffffff8106bd75>] ? warn_slowpath_null+0x15/0x20
>  [<ffffffff81125a32>] ? d_set_d_op+0x82/0xb0
>  [<ffffffff8120d829>] ? autofs4_dir_mkdir+0x169/0x180
>  [<ffffffff8111caa8>] ? vfs_mkdir+0x78/0xa0
>  [<ffffffff811209e6>] ? sys_mkdirat+0xf6/0x110
>  [<ffffffff81120a13>] ? sys_mkdir+0x13/0x20
>  [<ffffffff81030dbb>] ? system_call_fastpath+0x16/0x1b

Note that even the second WARN was trigerred too:
WARNING: at fs/dcache.c:1365 d_set_d_op+0x9e/0xb0()
Hardware name: To Be Filled By O.E.M.
flags=00004000
Modules linked in: dvb_usb_af9015 tda18271 af9013 dvb_usb dvb_core
Pid: 3474, comm: automount Tainted: G        W   2.6.37-mm1_64+ #1344
Call Trace:
 [<ffffffff8106bd2a>] ? warn_slowpath_common+0x7a/0xb0
 [<ffffffff8106be01>] ? warn_slowpath_fmt+0x41/0x50
 [<ffffffff81125a4e>] ? d_set_d_op+0x9e/0xb0
 [<ffffffff8120d829>] ? autofs4_dir_mkdir+0x169/0x180
 [<ffffffff8111caa8>] ? vfs_mkdir+0x78/0xa0
 [<ffffffff811209e6>] ? sys_mkdirat+0xf6/0x110
 [<ffffffff81120a13>] ? sys_mkdir+0x13/0x20
 [<ffffffff81030dbb>] ? system_call_fastpath+0x16/0x1b

My d_set_d_op looks like:
        WARN_ON(dentry->d_op);
        if (WARN(dentry->d_flags & (DCACHE_OP_HASH      |
                                DCACHE_OP_COMPARE       |
                                DCACHE_OP_REVALIDATE    |
                                DCACHE_OP_REVALIDATE_RCU|
                                DCACHE_OP_DELETE),
                                "flags=%.8x", dentry->d_flags)) {
                dentry->d_flags &= ~(DCACHE_OP_HASH | DCACHE_OP_COMPARE |
                        DCACHE_OP_REVALIDATE | DCACHE_OP_REVALIDATE_RCU |
                        DCACHE_OP_DELETE);
        }

So DCACHE_OP_REVALIDATE remained set.

> I changed those BUG_ONs to WARN_ONs intentionally because I had problems
> with that previously -- I had to:
> dentry->d_flags &= ~(DCACHE_OP_HASH | DCACHE_OP_COMPARE |
>       DCACHE_OP_REVALIDATE | DCACHE_OP_REVALIDATE_RCU |
>       DCACHE_OP_DELETE);
> 
> in d_set_d_op to not oops when calling NULLish op->d_delete later.
> 
> 
> The "Tainted: G        W" is caused by:
> https://lkml.org/lkml/2011/1/10/63

regards,
-- 
js
