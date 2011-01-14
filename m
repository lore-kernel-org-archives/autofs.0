From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] WARNING: at fs/dcache.c:1359 d_set_d_op [was: mmotm
 2011-01-06-15-41 uploaded]
Date: Fri, 14 Jan 2011 16:20:43 +0800
Message-ID: <1294993243.2794.4.camel@perseus>
References: <201101070014.p070Egpo023959@imap1.linux-foundation.org>
	 <4D2ECB56.4070802@gmail.com> <12521.1294932824@localhost>
	 <4D2F1CD7.5090100@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=l7FneBwnDJglAwk85Fj4f4qiRsk=; b=pu/U6d6oX0mpzFYbQEhsm0dNY9jxk13zUWRnHOPEsT9ZHIo1o81FHd21NN9zO3vFZo4QnI4DBoKa/hKzxz/HavaQtPVWmy5Q0X8THbCs81ilduvZ7i6oxAk3S8WNQtXL9omSs1U8JYp5mm1y5ulreynZsPj4tOE4k/6caRRc2DE=
In-Reply-To: <4D2F1CD7.5090100@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, autofs@linux.kernel.org, mm-commits@vger.kernel.org, npiggin@kernel.dk, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org

On Thu, 2011-01-13 at 16:40 +0100, Jiri Slaby wrote:
> On 01/13/2011 04:33 PM, Valdis.Kletnieks@vt.edu wrote:
> > On Thu, 13 Jan 2011 10:52:22 +0100, Jiri Slaby said:
> >> On 01/07/2011 12:41 AM, akpm@linux-foundation.org wrote:
> >>> The mm-of-the-moment snapshot 2011-01-06-15-41 has been uploaded to
> >>
> >> Hi, after some uptime and several suspend/resume cycles, I got:
> >> WARNING: at fs/dcache.c:1359 d_set_d_op+0x82/0xb0()
> >> Hardware name: To Be Filled By O.E.M.
> >> Modules linked in: dvb_usb_af9015 tda18271 af9013 dvb_usb dvb_core
> >> Pid: 3474, comm: automount Tainted: G        W   2.6.37-mm1_64+ #1344
> >> Call Trace:
> >>  [<ffffffff8106bd2a>] ? warn_slowpath_common+0x7a/0xb0
> >>  [<ffffffff8106bd75>] ? warn_slowpath_null+0x15/0x20
> >>  [<ffffffff81125a32>] ? d_set_d_op+0x82/0xb0
> >>  [<ffffffff8120d829>] ? autofs4_dir_mkdir+0x169/0x180
> > 
> > Wow. So it wasn't just configfs that trips over this one.  I'm now hoping that
> > Al audited all the pseudo file systems for this...
> 
> Well, CCing Al.
> 
> I don't see any recent change in fs/autofs4 in:
> http://git.kernel.org/?p=linux/kernel/git/viro/vfs-2.6.git;a=history;f=fs/autofs4;hb=refs/heads/for-next
> 
> So maybe not all?

Did you see:
https://lkml.org/lkml/2011/1/12/394

Haven't had any feedback on this yet, odd or maybe no news is good news?

Ian

