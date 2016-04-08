From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs and mount namespaces
Date: Fri, 08 Apr 2016 09:21:07 +0800
Message-ID: <1460078467.3135.50.camel@themaw.net>
References: <20160407181911.GA9018@vader>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=25xmuENP115vJLnttgYuZ0t9VCI=; b=tqwo7D
	Mgn+R210UmlcdFp+rGIUGXW0klDFjsBNtRIDsiav3rISddWRmanBkDfoZNFG+lFH
	zefGmFZQ+PazQ0J8K1lRZ+fJHLIEweuicEEX4EtXWNFQ3+ueXt8NPoHYQVX1Z/y6
	g11wntEBISvrFChZOmRxvPkUM7p15A3tkFu1c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=25xmuENP115vJLn
	ttgYuZ0t9VCI=; b=KrSA7bmFZa3dQmvm5CZT15CIfd8FqZ3FWQ5pZK5kmeqx3fk
	pBJB2+8bOi7jtXQqg3r6soPNJNUyfBdHv3wYwjdQQn8QbE/ZZd0HKKvveEL5+X4p
	GOAvB/22vptRW0YexzXzY8I0beLXpKg5A6LqC+gnEf1mwgn+UwAZ05F27zUw=
In-Reply-To: <20160407181911.GA9018@vader>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Omar Sandoval <osandov@osandov.com>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com

On Thu, 2016-04-07 at 11:19 -0700, Omar Sandoval wrote:
> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> index 0146d911f468..b4e901d2aa6b 100644
> --- a/fs/autofs4/waitq.c
> +++ b/fs/autofs4/waitq.c
> @@ -332,8 +332,6 @@ static int validate_request(struct
> autofs_wait_queue **wait,
>  					dentry = new;
>  			}
>  		}
> -		if (have_submounts(dentry))
> -			valid = 0;

LOL, that's going to break rootless multi-mounts.

Consider the case where you have:

<key>	/one   a_server:/path \
        /two   any_other:/any_other_path \
        ....

The ability to check that the non-mountpoint dentry is in fact the root
of a mounted tree of mounts is gone, ;)

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
