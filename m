From: "Cyril B." <cbay@excellency.fr>
Subject: Re: automount subprocesses accumulate
Date: Sun, 13 Sep 2015 18:53:29 +0200
Message-ID: <55F5AA09.4000602@excellency.fr>
References: <55F1971B.1050301@excellency.fr>   <1441949699.5198.6.camel@themaw.net> <55F2EFBD.2020104@excellency.fr>  <1442142599.2902.13.camel@themaw.net> <55F55C0E.3010806@excellency.fr> <1442145133.2902.26.camel@themaw.net> <55F5669B.7050409@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=G+6/jA0DI1VRkzTJ8ubiZ1HHoSesIvsTc+Ulgkfxj80=;
	b=mAuyWSoEhGQMa9fbcqsqSX3COt+KhYFRr+B+BDEf1JT/F3NjOnAV3vXHmWH6t3WxKEE3e9nscvJtD5NCWgvu8V3nH3649J3zng6wq8Fny4Cl+tNuJxCvECqQ2eb5MU5M8GCZxf9VocXED4qW5bOadGFlFZB46nhhnHY82yjnSTFmRAgrW/YVKcIDeI6nljplo4vW5rDzedDeLRenmxu4TFA6zT3wVzLOIs3YmWG9pCydkqYUCgJSsHpv41Qb/Y0LtrXR2GooAjrZcnWozXYB6etwC+71vTbPpEq2Pz8tzenuSqjk7ZqcibWwydHGOvlTo7CoPj8OlJ1EAKBQAbjAag==;
In-Reply-To: <55F5669B.7050409@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: cbay@excellency.fr
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

Cyril B. wrote:
> I'll deploy that version on my production server today, I'll let you
> know how it goes.

It's been running for several hours with no problem. Your patch 
definitely fixed the deadlock.

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
