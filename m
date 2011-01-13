From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: WARNING: at fs/dcache.c:1359 d_set_d_op [was: mmotm 2011-01-06-15-41
 uploaded]
Date: Thu, 13 Jan 2011 16:40:07 +0100
Message-ID: <4D2F1CD7.5090100@gmail.com>
References: <201101070014.p070Egpo023959@imap1.linux-foundation.org>            <4D2ECB56.4070802@gmail.com> <12521.1294932824@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=+nbtCnaT0Af451XqxMNUbtJTgNQYLFefDpOu8+POR+Y=;
        b=BUtzvorbJ/S9VrfuHHptpUqCDk9MlCumkNY9Qh+cizzdtJch/m+yUpqxYIypAgQMKH
         RsXL9ucap2H8Ku23YbX+1sNcs2OidYel6fjSyybz4JPPSPX7VEOLDx6tYuiEg/6te4XN
         NOUN2aK+m9jKlz4w8lTD35wCiveRTMyfaL6Po=
In-Reply-To: <12521.1294932824@localhost>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-fsdevel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@linux.kernel.org, npiggin@kernel.dk, Al Viro <viro@zeniv.linux.org.uk>

On 01/13/2011 04:33 PM, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 13 Jan 2011 10:52:22 +0100, Jiri Slaby said:
>> On 01/07/2011 12:41 AM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2011-01-06-15-41 has been uploaded to
>>
>> Hi, after some uptime and several suspend/resume cycles, I got:
>> WARNING: at fs/dcache.c:1359 d_set_d_op+0x82/0xb0()
>> Hardware name: To Be Filled By O.E.M.
>> Modules linked in: dvb_usb_af9015 tda18271 af9013 dvb_usb dvb_core
>> Pid: 3474, comm: automount Tainted: G        W   2.6.37-mm1_64+ #1344
>> Call Trace:
>>  [<ffffffff8106bd2a>] ? warn_slowpath_common+0x7a/0xb0
>>  [<ffffffff8106bd75>] ? warn_slowpath_null+0x15/0x20
>>  [<ffffffff81125a32>] ? d_set_d_op+0x82/0xb0
>>  [<ffffffff8120d829>] ? autofs4_dir_mkdir+0x169/0x180
> 
> Wow. So it wasn't just configfs that trips over this one.  I'm now hoping that
> Al audited all the pseudo file systems for this...

Well, CCing Al.

I don't see any recent change in fs/autofs4 in:
http://git.kernel.org/?p=linux/kernel/git/viro/vfs-2.6.git;a=history;f=fs/autofs4;hb=refs/heads/for-next

So maybe not all?

regards,
-- 
js
