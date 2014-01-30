From: Ian Kent <raven@themaw.net>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Thu, 30 Jan 2014 08:19:24 +0800
Message-ID: <1391041164.2620.10.camel@perseus.fritz.box>
References: <52E92627.9050801@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Z7NBlsQhoF7Pi8lCsvydfoEXJgg=; b=or69SV6Pd2LeJikcEr6eFz+7gie/
	MFixRda55G4xve9YKU5iA2dpoMEqlUh1fhQQnJYDLc+BeJ5ga3o2luMYWFViYaKL
	A9/gPu6Oyr+ycRQ1U4wrV1FmM0uFMWu63K4lc1fsSuFL06HTClY/iYarBSJuje+5
	2gZkHi7Uu534Zuw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Z7NBlsQhoF7Pi8lCsvydfo
	EXJgg=; b=mJsAf5o5eaJ4G02KbyB6mYo+yNL1/0gP2mrSKO2uSlPojSDFrXwkN3
	hAqhG8xHO/iONbPjhFBZel9xhA7H002PSjfUiJU3iCIF/Tg9eaKXO4S6xFGkV91M
	htxo6cA+vWxe7mq8JVaUGwKgztZleh/GLwkDR4J9YjhKUdbfEPC9U=
In-Reply-To: <52E92627.9050801@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Wed, 2014-01-29 at 17:02 +0100, Donald Buczek wrote:
> Hello,
> 
> we are trying to switch from amd to autofs. After successfully testing 
> and rolling it out to the first several machines, from time to time we 
> get directories stuck with "Too many levels of symbolic links" on a path 
> which should be automounted via an indirect map.
> 
> linux 3.8.13

What is linux 3.8.13?
Oh right, an old kernel.
You need to reproduce this with a current kernel, 3.13.0 for example.
OTOH I have had a couple of recent reports of this, not including
Leonardo's, so any information is useful.

> autofs 5.0.8
> 
> As an example, here is data from a system where the path /scratch/tmp is 
> stuck:
> 
> http://www.molgen.mpg.de/~buczek/autofs-demo/
> 
>    auto.master    # master map
>    auto.scratch    # indirect map for /scratch
>    autofs            # from /etc/defaults
>    typescript       # shows the problem and a bit of gdb dump of kernel 
> structures
>    typescript.l     # same with line numbers for reference
>    gdb-macros     # macros used in the gdb session
> 
>  From typescript.l , line 122ff it is clear, that /scratch/tmp is not 
> currently mounted. On the other hand, the gdb session finds the dentry 
> of /scratch/tmp which has d_flags 0x70080 (line 99,120). This is 
> DCACHE_MANAGE_TRANSIT+DCACHE_NEED_AUTOMOUNT+DCACHE_MOUNTED+DCACHE_RCUACCESS 
> with DCACHE_MOUNTED indicating that there should be something mounted 
> there(?). I think, this state is faulty and necessarily leads to ELOOP 
> during path walk. Probably the situation is known by the gurus here?

Well, at least I believe there's a bug to be found now.

From this output it does show a dentry that, according to the config,
shouldn't exist (but might still), is fully visible and claims it's
mounted (and definitely should be).

> 
> Is there any known bug which can lead to this situation? Any advice?

Any more information you gather would be good.
How frequently does this occur?
Any idea of the activity leading to this?
A full debug log and a time the mount was discovered inoperable might
help.

> 
> Thank you
> 
>    Donald
> 


