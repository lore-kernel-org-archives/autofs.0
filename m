From: "Cyril B." <cbay@excellency.fr>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 10:42:32 +0200
Message-ID: <55F68878.40803@excellency.fr>
References: <55F58085.4090509@excellency.fr> <1442197882.3030.33.camel@themaw.net>
Reply-To: cbay@excellency.fr
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:Reply-To:From:Date:Message-ID; bh=tp0ynsXXKU9Us1cHnWxjP8eFkwF6pyWxTnabYm3bbRY=;
	b=PldgGAAyQYP26WLE/adamY7lLj8mCRT3j+jXaIPELYl2oNg4R2qWxrk/ni7mLgw4buSUyT1KqCvnZImyHAkPmuTrGlgfKZ+4/Z8STz8YYER6Zgl9Owo2su9lxcHklSODEjVJzJ3efwnbYshTpj+P6mDTp42iEOcCZXbjs0AQBu/VK3rmhciP3RoyEehvXhnBONoG3tBjVWNuZ/RFw1tJI4MPje3Zu1B89XVqSiU26e9YM30EPu/GCTt2abLrxJAtCtSWDKWD+m6tUXsoOezvW0Aiaa7WPlIf+8yBUts6oQDxl9g6ptoEuWPaWjK2LOjj4lhxdflZYecoyCDinA+6RA==;
In-Reply-To: <1442197882.3030.33.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

Ian Kent wrote:
> On Sun, 2015-09-13 at 15:56 +0200, Cyril B. wrote:
>> It looks like the mount point of the maps have fixed permissions, 755. I
>> need to have different permissions: in my use case, I want /home (which
>> is handled by autofs) to be set to 751.
>
> Why is this needed?

Why do I want to set /home to 751? When it was set to 755, I frequently 
had users believing there was a serious vulnerability because they could 
list /home. Stupid, I know, but setting the permissions to 751 was a 
trivial solution for this.

>> The initial permissions of /home are overwritten when autofs is started,
>> so changing those doesn't help.
>
> They aren't overwritten.
> The permissions are those of the autofs mount that is mounted
> over /home.

I'm not sure I'm following you. Here's my auto.master:

/home program:/etc/auto.home

Before launching autofs, permissions are set to 751:

# ls -ald /home
drwxr-x--x 2 root root 4096 Aug  7 11:09 /home

Once I've launched autofs, permissions are reset to 755:

# ls -ald /home
drwxr-xr-x 2 root root 0 Sep 14 10:32 /home

And when I quit autofs, my permissions are back to 751:

# ls -ald /home
drwxr-x--x 2 root root 4096 Aug  7 11:09 /home

What I want is to always have /home permissions set to 751.

Note that I'm not talking about mount points below /home (e.g. 
/home/foobar), those do have the correct permissions.

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
