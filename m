From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 17:52:20 +0800
Message-ID: <1442224340.3030.70.camel@themaw.net>
References: <55F58085.4090509@excellency.fr>
	 <1442197882.3030.33.camel@themaw.net> <55F68878.40803@excellency.fr>
	 <55F69162.5080601@embl-heidelberg.de> <55F69382.2060605@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=cwHsnXvt6vFj3tixGEbnRZXQgDc=; b=hWQQog
	IzNDabeoZLZsuD3/p9b0S/UvnEx4QmYRiNDNq2sCJMHS88jSWAx+9xPUYjXhETgQ
	SBGWfSe+ni1D62cMmleTVBWp6+LxZnrGEO2RLbInexmM1Hvt0ICMDf+irjW3nHoW
	mq8WMODEJF0MCnLWd73dgU+dl3WVLlTDyYrYw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=cwHsnXvt6vFj3ti
	xGEbnRZXQgDc=; b=gvcbZCfdVDMc7oEmdlIZupCOy/V/AMmAtVdOGQb+n2MVvdF
	4Nrxc+B7FVwnkrLtX7Z9RKAdH2AoeQK7coGqdoSud0XnwHIgI/NG5fAp5idjaTvC
	vKRnKIdEbD/WJFQMDRc7sFsG7QmZEidMuPzq62GHJQF7WqcDQdyELcpxfhCU=
In-Reply-To: <55F69382.2060605@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: cbay@excellency.fr
Cc: Frank Thommen <frank.thommen@embl-heidelberg.de>, "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Mon, 2015-09-14 at 11:29 +0200, Cyril B. wrote:
> Frank Thommen wrote:
> > They are not "re"set.  These are the permissions of the filesystem that
> > you are mounting over /home (e.g. myfileserver:/export/homes).  Change
> > the permissions of /export/homes on myfileserver.
> 
> In my case, I haven't mounted anything at all yet. My map is an 
> executable, and since I haven't triggered an automatic mount (by 
> accessing /home/foo), the executable has not even been called once. 
> /home is empty.

And if you create a file inside /home before starting automount(8) it
will (not so) mysteriously disappear when automount is started.

Why don't you check what mounts you have after automount is started.

That may well answer your question and don't forget to check
if /etc/mtab is a symlink to a mount table in the proc file system.

If it isn't then the autofs file system mounts won't be present
in /etc/mtab but they will be seen in the mount table within the proc
pseudo file system at /proc/mounts.

Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
