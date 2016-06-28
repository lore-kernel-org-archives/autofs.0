From: "Cyril B." <cbay@excellency.fr>
Subject: Re: Regular deadlocks
Date: Tue, 28 Jun 2016 09:48:19 +0200
Message-ID: <2792b835-962a-e1a5-6113-032eb63e03d1@excellency.fr>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
 <1466906389.739.25.camel@themaw.net>
 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
 <1466987208.3191.6.camel@themaw.net>
 <17c66f92-bda8-1eb9-621c-47e39406acc2@excellency.fr>
 <1467073622.3767.17.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=alwaysdata.net; s=ad;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=C0kZofrWRT9FKPJGEHIsvKWezSFn/bzbJkDVWoV1mxI=;
	b=cMb3jMOJ2XetUCJLeUzpV06ZAKaV+QD1eklNQBCEHm/E4FI8j/xE62hLnwQti4GrCNTh0gyaCBhqWCyLRmkZ8zX8IeQONxZjK0hsYoIvnBHViDYjONVYKmo6XlazoTwnQcNeTXhto4B1+t9FAVQl7GNMbaILogPfqmBqnbVdXJc=;
In-Reply-To: <1467073622.3767.17.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

On 06/28/2016 02:27 AM, Ian Kent wrote:
> Can you describe again how this fits together?

Sure. Please let me know if I'm not clear. Here's my /etc/auto.master:

/nfs program:/etc/auto.nfs nobind
/home program:/etc/auto.home --mode=751

/etc/auto.nfs does some sanity checks, then does:
echo -fstype=nfs4,noatime,nosuid,_netdev,soft,intr,timeo=1000 $1:/

/etc/auto.home looks up in an internal database on what NFS server the 
account is, then does:
echo -fstype=bind :/nfs/httpX/$1

So /nfs and /home are entirely handled by autofs. There's no NFS or user 
mount handled by something else.

On the NFS servers, /home is a standard filesystem (XFS), here's the 
/etc/exports:

/home  1.2.3.4  (rw,async,insecure,no_subtree_check,no_root_squash,fsid=0)

On my server that deadlocks the most, all users are on the same NFS 
server (named http12).

> At this point a full debug log would probably answer most of my questions.

I've just enabled debug logs, I'll send them to you as soon as I have a 
new deadlock.

Thanks again.

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
