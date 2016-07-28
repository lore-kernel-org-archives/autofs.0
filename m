From: "Cyril B." <cbay@excellency.fr>
Subject: Re: Regular deadlocks
Date: Thu, 28 Jul 2016 09:36:01 +0200
Message-ID: <e9e8fbbc-4722-ffd6-b139-7c1f1107748b@excellency.fr>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
 <1466906389.739.25.camel@themaw.net>
 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
 <1466987208.3191.6.camel@themaw.net>
 <17c66f92-bda8-1eb9-621c-47e39406acc2@excellency.fr>
 <1467073622.3767.17.camel@themaw.net>
 <2792b835-962a-e1a5-6113-032eb63e03d1@excellency.fr>
 <1467358122.3908.56.camel@themaw.net>
 <4df27a99-1834-c8be-74d6-f7bdb17df724@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=alwaysdata.net; s=ad; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P2vp4BGG6TFhUEl3YIbL2hGIuYCwP3ABKg/ZjakOPk8=; b=sFxwwAsKm6os+Sv+4SbJGt1TQg
	Sc3MkGtv8w1rMbRnz+m8TXteQ40VhUPbI0jk1SGzTTSAn1kcttbKlBA59v7JZK1Ik4mZ0rIvYNq13
	gjPVuxb2dp/MSz64/UaBoDilpsiOV6w+yaEfh56hNIsTUvWyhNtcWqrnQfs9sqYAlP8w=;
In-Reply-To: <4df27a99-1834-c8be-74d6-f7bdb17df724@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

On 07/01/2016 09:48 AM, Cyril B. wrote:
>> Is there a reason you need to use the nfsv4 root namespace rather than
>> using the
>> /home export directly?
>
> You mean get rid of the bind mounts and have /home/foo be a NFSv4 mount
> to (e.g.) http12:/foo?
>
> If so, I assumed that it would mean having a lot of independant mounts
> over NFS (and as many TCP connections between the NFS client and
> server), and doing a single NFS mount with local bind mounts would be
> better.
>
> However, my assumption may very well be wrong. Would the kernel share
> the same underlying NFS mount (and TCP connection) for all those mount
> points to the same NFS server?


Well, I've been doing that for the past month and everything works 
rather flawlessly. In particular, deadlocks are gone, so I'll keep that 
setup.

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
