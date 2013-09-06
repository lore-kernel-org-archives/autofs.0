From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 00/25] Current autofs patch queue
Date: Fri, 06 Sep 2013 16:11:33 +0800
Message-ID: <1378455093.2311.12.camel@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
	 <522469BD.1030709@ts.fujitsu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=NctlK0wgT8/WyCyFCXcwA5364Dk=; b=lZzNyny4fQ8RIQlfjgG2JqenyRJI
	FhaqXpf4k2vvOxWACTVMH5sYEnCzUXMWtyXTwzyafJ8mcwmeFMCefVuoEsyss9Z4
	tWQ302YXtgneQKJwdd2sWo1AzJGaO7NYiFbo62/Hy6+KkoJMgxA26GFljRd14H6p
	NXDI0KtCbm5wTBg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=NctlK0wgT8/WyCyFCXcwA5
	364Dk=; b=sTwdVWJJ2m9dYjPvO03C/2XBNwTFHt5p3UzMQnMcpgodWfNh48AkdS
	5twdW2+lgU8Zzeeb8QP+OjoPDhJAIZkYhjXc4BNtHZRqusNfi5pVK0XUceEKSUdq
	EFs9/IvHXcq2LUBRqS34YVvmEpA7pn7pTS/mhGvz8sSkwgMH6Mo/8=
In-Reply-To: <522469BD.1030709@ts.fujitsu.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Wilck <martin.wilck@ts.fujitsu.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

On Mon, 2013-09-02 at 12:34 +0200, Martin Wilck wrote:
> On 08/19/2013 03:11 AM, Ian Kent wrote:
> > There are patches from several contributors I plan on committing
> > so I thought posting them to the list for final review would be
> > sensible.
> 
> I am wondering about my auto.smb patch (see
> http://www.spinics.net/lists/autofs/msg00402.html). Back then, you said
> 
> > 
> > All I'm really saying is that, the program map returns a string that is
> > then used as the map entry, so when it is parsed the variables $UID,
> > $GID, etc. will be present in the macro lookup table as ${UID} (and $UID
> > etc. works) ... so maybe these same variables should be provided in the
> > environment of the program.
> > 
> > It isn't entirely clear if that is needed since those macro values may
> > be returned in the map entry text with things like echo "/some/string
> > \ ... ${UID} ..." etc. for later translation.
> > 
> > Really, a revised patch depends on this question being answered first. 
> 
> Nobody has spoken up on this list saying that additional environment
> variables would need to be set. I am wondering what else needs to be
> done in order to merge this (IMO very useful) functionality.

I like the idea of the setuid() but it's probably more convenient for me
to set the standard macro variables (that are set when the entry is
parsed) in the environment before running the program map. Also setuid()
changes what some may expect to be the case so that's probably not a
good idea.

One of the current patches in the queue sets existing macro variables in
the environment, in order to pass parameters to a program map, so all
that would need to be done is a call to a function that adds the
standard variables to the macro table for that to happen.

I posted a question about the second patch and will wait for the answer
to that.


> 
> Martin
> 


