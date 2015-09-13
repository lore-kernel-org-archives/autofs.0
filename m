From: "Cyril B." <cbay@excellency.fr>
Subject: Re: automount subprocesses accumulate
Date: Sun, 13 Sep 2015 14:05:47 +0200
Message-ID: <55F5669B.7050409@excellency.fr>
References: <55F1971B.1050301@excellency.fr>   <1441949699.5198.6.camel@themaw.net> <55F2EFBD.2020104@excellency.fr>  <1442142599.2902.13.camel@themaw.net> <55F55C0E.3010806@excellency.fr> <1442145133.2902.26.camel@themaw.net>
Reply-To: cbay@excellency.fr
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:Reply-To:From:Date:Message-ID; bh=Lu4Jbsnd6c9VpLRylCpt7c0AwPpfRNRbG8PfXtyxp9g=;
	b=Zbn6q0ELmhEoyD1JCmDPFpMAM9aVQc5g7Q79i1PK0Zb76mBtSTrl+ixuWJRqT4X2K444lbEjRiWC6ypK0GPtAj7Tyqz7TDBbmsr/EJoB1A+3KSVYOwh4zts8dLXXOBLghZgU9fOHAHNPdkYWqUCs5AkcKCWHUXxNlJgT8RpDKfMTf8YGNjYILz1ZFhqoLTUTZji+wOPSztGVALo7S8VAmN10tfyhKmOmQIuPE5GeSHAs1dS+5WPJn5jSedcb49JnqMxXcqQxl6aDd9oWW/c48ZXljTLQ8YQT3rUgo2r+pyRj6f7UjIPq2pUL8hAgG3wa9kdyb1iVUvzlGoQaHG2d+g==;
In-Reply-To: <1442145133.2902.26.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Ian Kent wrote:
> OK, see if you can apply this patch.
> The CHANGELOG hunk won't apply, of course, so just ignore the reject or
> delete the hunk from the patch before applying it.
>
> Umm ... now I see I need to fix a couple of spelling mistakes as
> well,;)


It looks like it fixes the bug indeed! At least I'm unable to reproduce 
it on my test environment.

I'll deploy that version on my production server today, I'll let you 
know how it goes.

Thank you!

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
