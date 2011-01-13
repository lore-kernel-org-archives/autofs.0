From: Nick Piggin <npiggin@gmail.com>
Subject: Re: WARNING: at fs/dcache.c:1359 d_set_d_op [was: mmotm
 2011-01-06-15-41 uploaded]
Date: Thu, 13 Jan 2011 21:54:11 +1100
Message-ID: <AANLkTin=CgtKcoC4fmsp_Fos35gPPsT-9+OvQvnov6MS@mail.gmail.com>
References: <201101070014.p070Egpo023959@imap1.linux-foundation.org>
	<4D2ECB56.4070802@gmail.com>
	<4D2ECC84.8050406@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JcZNmwlDVNN/JwRDjZ+z9dkH6EvqVPi6p+PK4KGePV8=;
        b=h9UoKnRZIFP1vxhUkmxBd3oHz6GEWJe0kTU00c86MpvCJxNDGuXjvZtNx7ArL/NdPU
         VOMPpJQiqqyBbDr/XVp+na67v4BBEvXEqzt5Xi21KwqMHVOnPAZ6xLXkTozZzKO60akt
         qpX9vtA8y8oM8ZGeXMMePpjadW0P1vUKWeoIE=
In-Reply-To: <4D2ECC84.8050406@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-fsdevel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@linux.kernel.org, npiggin@kernel.dk

2011/1/13 Jiri Slaby <jirislaby@gmail.com>:
> On 01/13/2011 10:52 AM, Jiri Slaby wrote:
>> On 01/07/2011 12:41 AM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2011-01-06-15-41 has been uploaded to
>>
>> Hi, after some uptime and several suspend/resume cycles, I got:
>> WARNING: at fs/dcache.c:1359 d_set_d_op+0x82/0xb0()
>> Hardware name: To Be Filled By O.E.M.
>> Modules linked in: dvb_usb_af9015 tda18271 af9013 dvb_usb dvb_core
>> Pid: 3474, comm: automount Tainted: G =A0 =A0 =A0 =A0W =A0 2.6.37-mm=
1_64+ #1344
>> Call Trace:
>> =A0[<ffffffff8106bd2a>] ? warn_slowpath_common+0x7a/0xb0
>> =A0[<ffffffff8106bd75>] ? warn_slowpath_null+0x15/0x20
>> =A0[<ffffffff81125a32>] ? d_set_d_op+0x82/0xb0
>> =A0[<ffffffff8120d829>] ? autofs4_dir_mkdir+0x169/0x180
>> =A0[<ffffffff8111caa8>] ? vfs_mkdir+0x78/0xa0
>> =A0[<ffffffff811209e6>] ? sys_mkdirat+0xf6/0x110
>> =A0[<ffffffff81120a13>] ? sys_mkdir+0x13/0x20
>> =A0[<ffffffff81030dbb>] ? system_call_fastpath+0x16/0x1b
>
> Note that even the second WARN was trigerred too:
> WARNING: at fs/dcache.c:1365 d_set_d_op+0x9e/0xb0()
> Hardware name: To Be Filled By O.E.M.
> flags=3D00004000
> Modules linked in: dvb_usb_af9015 tda18271 af9013 dvb_usb dvb_core
> Pid: 3474, comm: automount Tainted: G =A0 =A0 =A0 =A0W =A0 2.6.37-mm1=
_64+ #1344
> Call Trace:
> =A0[<ffffffff8106bd2a>] ? warn_slowpath_common+0x7a/0xb0
> =A0[<ffffffff8106be01>] ? warn_slowpath_fmt+0x41/0x50
> =A0[<ffffffff81125a4e>] ? d_set_d_op+0x9e/0xb0
> =A0[<ffffffff8120d829>] ? autofs4_dir_mkdir+0x169/0x180
> =A0[<ffffffff8111caa8>] ? vfs_mkdir+0x78/0xa0
> =A0[<ffffffff811209e6>] ? sys_mkdirat+0xf6/0x110
> =A0[<ffffffff81120a13>] ? sys_mkdir+0x13/0x20
> =A0[<ffffffff81030dbb>] ? system_call_fastpath+0x16/0x1b
>
> My d_set_d_op looks like:
> =A0 =A0 =A0 =A0WARN_ON(dentry->d_op);
> =A0 =A0 =A0 =A0if (WARN(dentry->d_flags & (DCACHE_OP_HASH =A0 =A0 =A0=
|
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DCACHE=
_OP_COMPARE =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DCACHE=
_OP_REVALIDATE =A0 =A0|
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DCACHE=
_OP_REVALIDATE_RCU|
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DCACHE=
_OP_DELETE),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"flags=
=3D%.8x", dentry->d_flags)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dentry->d_flags &=3D ~(DCACHE_OP_HASH =
| DCACHE_OP_COMPARE |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DCACHE_OP_REVALIDATE |=
 DCACHE_OP_REVALIDATE_RCU |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DCACHE_OP_DELETE);
> =A0 =A0 =A0 =A0}
>
> So DCACHE_OP_REVALIDATE remained set.
>
>> I changed those BUG_ONs to WARN_ONs intentionally because I had prob=
lems
>> with that previously -- I had to:
>> dentry->d_flags &=3D ~(DCACHE_OP_HASH | DCACHE_OP_COMPARE |
>> =A0 =A0 =A0 DCACHE_OP_REVALIDATE | DCACHE_OP_REVALIDATE_RCU |
>> =A0 =A0 =A0 DCACHE_OP_DELETE);
>>
>> in d_set_d_op to not oops when calling NULLish op->d_delete later.

Thanks for reporting. I was a little over-optimistic in my assumption
that filesysystems
would be doing sane things with dentry->d_op.

Al has audited these guys and has a pull request pending.

In the meantime, avoiding the bug and flipping the bits off will work f=
ine.

Thanks,
Nick
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
