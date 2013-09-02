From: Martin Wilck <martin.wilck@ts.fujitsu.com>
Subject: Re: [PATCH 00/25] Current autofs patch queue
Date: Mon, 02 Sep 2013 12:34:37 +0200
Message-ID: <522469BD.1030709@ts.fujitsu.com>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ts.fujitsu.com; i=@ts.fujitsu.com; q=dns/txt;
  s=s1536b; t=1378118072; x=1409654072;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=1lVUx0KTcO+lGxQDFAFn9WMlO8AXv96CG5XqG+YuzO8=;
  b=XgIWEK3wB3wxOzCJPjma5aqmXcJCFSar7j6cC7R/ZpWF0daT632/oNx7
   OJiz6x495dJywIV+CJcQ1g82+CukRLwsrN5tbGHzyEHav+SIji3NfWZMX
   AO9/7rfJnc/r0pgoUkgPumcVLKJ/XXjfHNy2Zxc8+QrTRkofddJx3qctM
   2H65qYhhGRqjZRMvxh9lUHFrfGJh913oIOuSg+tSB9tUgkRiay2q1l4B6
   WmyqBPTkiDI5LnPXW7WPY7Z0eCiOK;
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

On 08/19/2013 03:11 AM, Ian Kent wrote:
> There are patches from several contributors I plan on committing
> so I thought posting them to the list for final review would be
> sensible.

I am wondering about my auto.smb patch (see
http://www.spinics.net/lists/autofs/msg00402.html). Back then, you said

> 
> All I'm really saying is that, the program map returns a string that is
> then used as the map entry, so when it is parsed the variables $UID,
> $GID, etc. will be present in the macro lookup table as ${UID} (and $UID
> etc. works) ... so maybe these same variables should be provided in the
> environment of the program.
> 
> It isn't entirely clear if that is needed since those macro values may
> be returned in the map entry text with things like echo "/some/string
> \ ... ${UID} ..." etc. for later translation.
> 
> Really, a revised patch depends on this question being answered first. 

Nobody has spoken up on this list saying that additional environment
variables would need to be set. I am wondering what else needs to be
done in order to merge this (IMO very useful) functionality.

Martin

-- 
Dr. Martin Wilck
PRIMERGY System Software Engineer
x86 Server Engineering

FUJITSU
Fujitsu Technology Solutions GmbH
Heinz-Nixdorf-Ring 1
33106 Paderborn, Germany
Phone:			++49 5251 525 2796
Fax:			++49 5251 525 2820
Email:			martin.wilck@ts.fujitsu.com
Internet:		http://ts.fujitsu.com
Company Details:	http://ts.fujitsu.com/imprint
