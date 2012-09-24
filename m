From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 0/2] struct pid-ify autofs4
Date: Mon, 24 Sep 2012 15:34:32 +0200
Message-ID: <87d31bczo7.fsf@tucsk.pomaz.szeredi.hu>
References: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
	<87haqrwfbj.fsf@tucsk.pomaz.szeredi.hu>
	<1348447130.2318.1.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=546DYB7zPKa5twtP1zgSIAiNJ12TQX7JMxNAn6CuuYA=;
        b=lsrVnpIJXx/zxiQoqnqj1jNxtvr0ZZfh7YcalQ29hO0+J1yEVJK0fry9WZUWaR4JwD
         foCpHWVYbvAzLO8QizTu7DKwpNmR0FTyF5KMxCEF0ggppiJvO2Wc09ZF4tCXCABPJhBg
         wettOeUBR7pOkwwSWBEH64raJBCqHXTZ0yIJI=
In-Reply-To: <1348447130.2318.1.camel@perseus.themaw.net> (Ian Kent's message
	of "Mon, 24 Sep 2012 08:38:50 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, ebiederm@xmission.com

Ian Kent <raven@themaw.net> writes:

> On Fri, 2012-09-21 at 17:44 +0200, Miklos Szeredi wrote:
>> Miklos Szeredi <miklos@szeredi.hu> writes:
>> 
>> > These two patches change autofs4 to store struct pid pointers instead of pid_t
>> > values.
>> >
>> > Fixed various issues with the previous post.  Not tested, handle with
>> > care!
>> 
>> Customer gave positive test results.
>
> For what exactly, there's no problem description in these patches?

From what I understand (and I'm not an expert by any means) is that
autofs doesn't work if containers are used.  The first patch fixes this.

Both the patches replace pid_t with a refcounted struct pid object,
which has better lifetime properties: you don't know whether a pid_t is
valid, because pid numbers are reused, while pid objects remain valid
until there are no more references to them.

Thanks,
Miklos
