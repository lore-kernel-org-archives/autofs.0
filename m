From: "Cyril B." <cbay@excellency.fr>
Subject: Re: Regular deadlocks
Date: Sun, 26 Jun 2016 12:02:57 +0200
Message-ID: <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
 <1466906389.739.25.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=alwaysdata.net; s=ad;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=aT1T7s06R1SmzhPbnKqo619vFt45p7Xzi8Q0vGNB72s=;
	b=oMfGgOBbR4wX302/5NdnrTZGH4ZUybCVLDXDK0oLE/8a2W7cJ8tbm+sBjDXaZFTfcZ41B4w89HctvfOrCgd39co5Ewi3dhAr+We2SjbkAMu5LyPktaXXccVWG5/0XoOMBLwLZpUbsBh7LIc4W8oFRlL1Y//ddFFUMudYnPjnZBY=;
In-Reply-To: <1466906389.739.25.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

On 06/26/2016 03:59 AM, Ian Kent wrote:
> The autofs4_d_automount() entry here indicates this is the one that triggered
> the mount.
>
> If you are seeing a problem with mount, looking for the blocked process and
> killing it should clear the rest of these up.
>
> You would think that, even if mount.nfs(8) was losing network packets, it would
> timeout after about 3 minutes. I must admit I haven't waited long enough to find
> out if that's the case so far.
>
> If you find you are actually seeing this, setting the configuration option
> mount_wait to some sensible value sufficient for a mount to complete might help.


Thanks for the quick response. I don't remember seeing any lingering 
mount.nfs, but I must have overlooked.

However, I've also had those "deadlocks" happen with several different 
NFS servers at the same time (this was not the case with the traces I 
sent in my previous email). If one NFS server was unmountable, should 
automount be blocked when trying to mount others?

Anyway, I'll investigate some more next time the "deadlock" occurs and 
will also try setting mount_wait to a reasonable value. I'll let you 
know how it goes.

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
