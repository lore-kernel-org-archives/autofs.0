From: Oscar Salvador <osalvador@suse.com>
Subject: Re: [PATCH 0/2] Map update problem patches
Date: Mon, 21 Aug 2017 09:05:47 +0200
Message-ID: <4866c5e4-89bb-8754-4051-05caede07543@suse.com>
References: <150329377379.7451.10096062127149809722.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150329377379.7451.10096062127149809722.stgit@pluto.themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>



On 08/21/2017 07:37 AM, Ian Kent wrote:
> Here is what I believe to be a better solution to the recent direct map
> update problem that was reported.
> 
> Unfortunately, the NSS map instance handling is overly complicated and
> I don't see a way to improve it. Becuase of this resolving problems in
> this area often introduces side effects.
> 
> So please look at these patches carefully.
> 

I tested the patches and they  seem to fix the issue I reported.

Thanks for the effort ;)

Oscar Salvador
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
