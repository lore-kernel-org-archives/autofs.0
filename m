From: "Cyril B." <cbay@excellency.fr>
Subject: Re: automount subprocesses accumulate
Date: Sun, 13 Sep 2015 13:20:46 +0200
Message-ID: <55F55C0E.3010806@excellency.fr>
References: <55F1971B.1050301@excellency.fr>  <1441949699.5198.6.camel@themaw.net> <55F2EFBD.2020104@excellency.fr> <1442142599.2902.13.camel@themaw.net>
Reply-To: cbay@excellency.fr
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:Reply-To:From:Date:Message-ID; bh=OL/dP6Raevap7mLZe6NSLUiBlWYcsiFyD1DU4kRAinc=;
	b=nkBwnc2qiYFopxuG5L6lqCubGNSviZH8YMmT2ecW4cSg2SqUgvdRn/JlScOOHd84MhY+Kr+9H/781un1Gm1S40jc1Dril7QE95cRfng4kaATEK31RFKgEcfR2aNJ4Ef9nZ63/2GufKFmQywP74yD3Gl+32s+SLusAhdSImsAiIdF3JjkQQi751DMZplCdAH+xKs969/g8ue1DySFJeAVXH3eH4d7Hcto/AFiAxfAnXVYJuujNaBn8cd6WufYNFsOnWkMKQDQkHjCptGeg2cT3MQXJh5wC3kYAjYRhNcLE6Mihg1LmklKULeduHpigLSBZ6EX71ROZbL/G0FQRuRPhw==;
In-Reply-To: <1442142599.2902.13.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Ian Kent wrote:
> On Fri, 2015-09-11 at 17:14 +0200, Cyril B. wrote:
>> >  Hello Ian,
>> >
>> >  Thanks for the quick response. I was able to reliably reproduce the
>> >  deadlock on a test server with a test script that triggers many
>> >  simultaneous mounts. On this setup /home is replaced with /mnt.
>
> Yes, it's a puzzle.
>
> The default.c module looks like there's no possibility of a deadlock.
> It's fairly simple and there is no place where the mutex isn't released
> before return and there are no other calls are made that could take
> other locks that could introduce a deadlock.
>
> It occurred to me that the call to force_standard_program_map_env() is
> out probably out of order.
>
> It's made after the fork() that's used to exec the program map code.
>
> I think the child is seeing the state of the mutex at the time of the
> fork and if the mutex was locked at that time the child process will
> never see it unlocked since the forked process copy will not see that
> change.
>
> That's just a guess, so let me put together a patch for you to try.
> Are you in a position to be able to apply and build autofs to test?

Sure, I can test as much as I want. I guess I could probably even setup 
a test VM that reproduces the issue and give you root credentials if it 
helps.

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
