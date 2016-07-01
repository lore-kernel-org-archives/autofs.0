From: Ian Kent <raven@themaw.net>
Subject: Re: Regular deadlocks
Date: Fri, 01 Jul 2016 15:28:42 +0800
Message-ID: <1467358122.3908.56.camel@themaw.net>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
	 <1466906389.739.25.camel@themaw.net>
	 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
	 <1466987208.3191.6.camel@themaw.net>
	 <17c66f92-bda8-1eb9-621c-47e39406acc2@excellency.fr>
	 <1467073622.3767.17.camel@themaw.net>
	 <2792b835-962a-e1a5-6113-032eb63e03d1@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=8Fic+/IuGvMskJ0jO4nkIZKXUAU=; b=Gn0HA2
	/M+LyfbHtJTl64No5bkog6hUoccKXfB5zqor1A7+jsItkNXUH1kT9tTlJ5hBqDz2
	HGuL/f/N6rK2JrNd2A/uFjiiUYPyczNq4GkQb2PU9xLruVEVppKkyHVlDPdb5kvv
	nwvOFb6ZPHXPWveD1H+rQt8jjHNc9pxRlirh4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=8Fic+/IuGvMskJ0
	jO4nkIZKXUAU=; b=H/sgdRVG8En3L+/jKgtS3dhCqxRoJXXJIeWPZ6hMSjIlitk
	n2pmrP8oyGKhmpQqpYNziv/K/61VoSPmmMXi3nplJfRI9DK62YJ0oBKiRf/FMUu2
	d7M7Ol3QQdVk4rybXs6kuzDhBWeYFBp29UDnCoFxjH7AcklXGI11TO4pRxck=
In-Reply-To: <2792b835-962a-e1a5-6113-032eb63e03d1@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>, autofs@vger.kernel.org

On Tue, 2016-06-28 at 09:48 +0200, Cyril B. wrote:
> On 06/28/2016 02:27 AM, Ian Kent wrote:
> > Can you describe again how this fits together?
> 
> Sure. Please let me know if I'm not clear. Here's my /etc/auto.master:

Thanks for this, after reading this I see I should have been able to work it out
from your original post.

Usually I don't like to question why people set things up the way they do, in
fact I find it annoying when someone asks a question and people respond with
"don't do it that way, do it this way" because, usually, if that was an option
the poster wouldn't have asked the question.

But in this case I think it's worth mentioning because due to the mount
independence required by kernel mount namespaces the problem we are seeing with
/nfs/http12 might not be easily solvable or solvable at all. 

> 
> /nfs program:/etc/auto.nfs nobind
> /home program:/etc/auto.home --mode=751
> 
> /etc/auto.nfs does some sanity checks, then does:
> echo -fstype=nfs4,noatime,nosuid,_netdev,soft,intr,timeo=1000 $1:/

Is there a reason you need to use the nfsv4 root namespace rather than using the
/home export directly?

That was a problem, particularly for autofs, and needed to be done long ago but
that has long since changed.

You should be able to use nfsv4 mounts directly without this intermediate mount.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
