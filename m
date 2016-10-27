From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/8] vfs - change d_manage() to take a struct path
Date: Thu, 27 Oct 2016 10:47:50 +0800
Message-ID: <1477536470.2898.12.camel@themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
         <20161019124031.94a44fbdd0970989f05d1893@linux-foundation.org>
         <1477006776.3207.14.camel@themaw.net>
         <20161027021111.GI19539@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-me-sender:x-sasl-enc:message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=mesmtp; bh=Q92ICNTHHXvXP4HdrsQm2OF
        AWWs=; b=mXBkJ9bN+3pMOZ950W6tmyTEV9PE/WCXHJ+nJHuz9QXvxP9DBfZoeVZ
        Jh80uB5QUOjVpbCqxAPc5qpjTlxrQUxKKmxAOH7Q7H/yZ7/t/PqQCMhLjXdvUOmK
        +i+grv0+TR1jtvc++yRQ1QJbPKssUyQWPvAFLInwZsaDfvuHKz90=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-me-sender:x-sasl-enc:message-id:subject
        :from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=smtpout; bh=Q92ICNTHH
        XvXP4HdrsQm2OFAWWs=; b=E0vj4gJBGUEMQB33KjKfRhbxXlE55KTL37Maz2fZ2
        2hVUYJmaeSL4+0MTLNSSb+NamUGsicv5EzD1e6QnB8xPqpDSKXbmZ0vHO1s281st
        8Bx8FOEvwufH5IxeW0faDG9uJ7ZVphnWr3PQ0iFBSBnmeVJGZlNOmZjI3KTj5Kgw
        wE=
In-Reply-To: <20161027021111.GI19539@ZenIV.linux.org.uk>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Thu, 2016-10-27 at 03:11 +0100, Al Viro wrote:
> On Fri, Oct 21, 2016 at 07:39:36AM +0800, Ian Kent wrote:
> 
> > 
> > Maybe Al has been too busy to comment, he has been on the Cc from the start.
> That's... a very mild version of what's been going on.  Let's just say that
> the last few weeks had been really interesting.  Not that the shit has
> settled, but there was some slackening in the shitstorm last few days.
> Unlikely to last, I'm afraid, but...
>  
> > 
> > Hopefully this email will prompt a review, Al?
> Aside of the Eric's note re constifying struct path (strongly seconded),
> I'm not sure if expiration-related side of that is correct.  OTOH,
> since the expiration happens from userland...

Sure, I have a follow up series to do the constifying as recommended by Eric and
now yourself.

> 
> How much testing did it get?  I've several test setups involving
> autofs, but they are nowhere near exhaustive and I don't have good
> enough feel of the codebase to slap together something with decent
> coverage...

It got my standard testing.

For that I use a modified version of the autofs Connectathon system.

It's more about testing a wide variety of syntax and map setups and so exercises
a large number of different types of autofs mounts.

It's meant to check normal operation but not so much stress testing even though
it does perform quite a few mounts (around 250-300, not to mention the autofs
mounts themselves).

I have another standard test I call the submount-test and it was originally done
to stress test the most common problem I see, concurrent expire to mount.

I didn't see any problems I couldn't explain in these but I might need to re-
visit the submount-test to see if it is still doing what I want.

OTOH, the pattern of mount and umount I see when the submount-test is run does
look like it is doing what I want but it might not be getting all the way to the
top of the tree of mounts enough times over the course of the test.

So I'm happy with my testing, just not as happy as I could be.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
