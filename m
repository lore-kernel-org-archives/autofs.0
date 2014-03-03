From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Mon, 03 Mar 2014 10:40:45 +0800
Message-ID: <1393814445.2787.20.camel@perseus.fritz.box>
References: <1391145206.2486.25.camel@perseus.fritz.box>
		 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
		 <530484B7.6030305@molgen.mpg.de>
		 <1392896501.2508.16.camel@perseus.fritz.box>
		 <1392898704.2508.26.camel@perseus.fritz.box>
		 <530625D0.7020808@molgen.mpg.de>
		 <1392946952.2495.3.camel@perseus.fritz.box>
		 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
		 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
		 <1393726942.9725.5.camel@perseus.fritz.box>
	 <1393744241.9725.16.camel@perseus.fritz.box>
	 <5313467C.9080102@molgen.mpg.de> <53137D9C.5020405@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=/PRJDxn2oGm1ybST8164Ov+w4nM=; b=tRiJMu07+ExTSc3yGrwZt4VLDRVM
	ru75CXmcCsCA2fzY6gVOFCnDMWtf97WOhyxafHRDIs3j6J/yPWyPwzNbVEWfzFrZ
	+QPURxsWPsdLCOf5ucP9O8OH2jTu4Bp57URuRS38C5WblqcwmH+HfyfnDlRZp3HJ
	RcO3REPneV//JeU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=/PRJDxn2oGm1ybST8164Ov
	+w4nM=; b=reOg7eoghhA8M+2pMh7osAu1/FhsL+jWA1Q4OmogcNo+FkQAJQNlPl
	eioRETcOee/CRSy+Tecx0/Y6FVkr7IVkSYkK8+4tR3/N5x/MTOlXRByqFJ2rDQ79
	ZW1uwd8tQ+iUCy/Kl4gVGzob5lH62hZbphAUt/nzhR/mD+NOz/4QQ=
In-Reply-To: <53137D9C.5020405@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <aviro@redhat.com>, autofs <autofs@vger.kernel.org>

On Sun, 2014-03-02 at 19:51 +0100, Donald Buczek wrote:
> Addendum:
> 
> The error can be reproduced with this script (and /project/mariux32 
> being an automount point of course) :
> ---------------
> #! /bin/sh
> 
> ls -ld /project/mariux32/.
> unshare -m -- bash -c "sleep 6;ls -ld /project/mariux32/.;echo exit..." &
> kill -USR1  `cat /var/run/autofs-running`
> sleep 3
> ls -ld /project/mariux32/.
> wait
> ---------------
> 
> Output:
> 
> > root:dose:/home/buczek/autofs/# ./test.sh
> > drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
> > ls: cannot access /project/mariux32/.: Too many levels of symbolic links
> > drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
> > exit...

Thanks, this is useful too.

> 
> And yes, the fileserver logs "authenticated unmount request" , but the 
> (later!) ls succeeds anyway.
> 
> Regards
>    Donald
> 
> 


