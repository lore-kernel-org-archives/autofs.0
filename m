From: "Cyril B." <cbay@excellency.fr>
Subject: Re: Regular deadlocks
Date: Sun, 26 Jun 2016 13:13:08 +0200
Message-ID: <68cd5600-2b1b-7c6b-fbcf-8d9b9d817a65@excellency.fr>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
 <1466906389.739.25.camel@themaw.net>
 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
 <1466937009.739.34.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=alwaysdata.net; s=ad;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=UwIwyA0yAlPDSioHsMhojBK2GqyxzgPuUMfpB1pZiak=;
	b=onIp0nIurJ9r/nbBG2niXdTPXfq96g64Z47+LVCGeRJa/6W6GK5yKeNIl53rDgY3rfvNtUdXg2ou+fq7nW/qzdA/egCwKz2VIoRP6SxPZW8jGvnMyWX02bUysYFmuPXyPP/5q/HHamVzBCfyyFxoyBRE1FfoZo3n6m2wQkeXnd8=;
In-Reply-To: <1466937009.739.34.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

On 06/26/2016 12:30 PM, Ian Kent wrote:
> I would need to check since the locking scope changes due to changes for other
> problems, that's with 5.1.1 and 5.1.2 right?

Yes, both version exhibit the same behaviour for me, with no apparent 
difference (same deadlock frequency, for instance).

> Btw, there was a bug in 5.1.1 were a program map lookup could hang under load
> due to out of order locking.
>
> The stack traces here didn't show what I'd expect to see with that but it can be
> a problem with 5.1.1.

That's actually the bug you fixed after my bug report in 2015, so my 
5.1.1 already included that patch. And since it's included in 5.1.2, all 
my tests were with that patch.

>> Hello,
>>
>> I have occasional deadlocks using autofs 4.1.2 (but it happened on 4.1.1
>> as well) on my servers, typically about once every 2 or 3 days.
>>
>
> Ummm ... is that meant to be 5.1.1 and 5.1.2, typo perhaps?

Whoops, yes :)

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
