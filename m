From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC:PATCH 2/4] autofs4 - add v5 follow_link mount trigger method
Date: Mon, 13 Feb 2006 00:53:36 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0602130052000.2319@eagle.themaw.net>
References: <200602121340.k1CDeHSn019282@eagle.themaw.net>
 <Pine.LNX.4.61.0602121542060.1213@yvahk01.tjqt.qr>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0602121542060.1213@yvahk01.tjqt.qr>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org


On Sun, 12 Feb 2006, Jan Engelhardt wrote:

> >
> >This patch adds a follow_link inode method for the root of
> >an autofs direct mount trigger. It also adds the corresponding
> >mount options and updates the show_mount method.
> >
> >+	if (sbi->type & AUTOFS_TYP_OFFSET)
> >+		seq_printf(m, ",offset");
> >+	else if (sbi->type & AUTOFS_TYP_DIRECT)
> >+		seq_printf(m, ",direct");
> >+	else
> >+		seq_printf(m, ",indirect");
> >+
> 
> Just a little nitpick: in English, it's usually "type" not "typ".

OK. But this was intentional.

In fact the same thought occured to me this evening when I was preparing 
the patches. I'll consider it for the final post.

Thanks
 
> 
> >+#define AUTOFS_TYP_INDIRECT     0x0001
> >+#define AUTOFS_TYP_DIRECT       0x0002
> >+#define AUTOFS_TYP_OFFSET       0x0004
> 
> >+	unsigned int type;
> 
> 
> Jan Engelhardt
> -- 
> 

