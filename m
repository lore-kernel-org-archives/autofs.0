From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 past 2.6.38: how to make it work?
Date: Wed, 17 Aug 2011 16:28:27 +0800
Message-ID: <1313569707.4418.32.camel@perseus.themaw.net>
References: <4E4975AB.4050201@msgid.tls.msk.ru>
 <4E497B43.4010600@msgid.tls.msk.ru>
 <1313550460.4418.5.camel@perseus.themaw.net>
 <4E4B5F4A.5060705@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
 messagingengine.com; h=subject:from:to:cc:in-reply-to:references
 :content-type:date:message-id:mime-version
 :content-transfer-encoding; s=smtpout; bh=zhi4e7DKUPd8qI5Or+EhQY
 miMp8=; b=rgJ7NsfgDDoPJNfFft5TA1SyI8hqGz76WZy7MUe/FsTTPc+iaurMER
 eDiifFUjmUPIgac9zJCyzDzgH+1eQBiEwk8/BkKx/73+gQTYRg6DtXb+8o9jAkKs
 oOlrQ7yQx9k7bE7VgSQyGRh9n/AANXoMjo25CfYlTMfqth44S0W4w=
In-Reply-To: <4E4B5F4A.5060705@msgid.tls.msk.ru>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
 <mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
 <mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: autofs@linux.kernel.org

On Wed, 2011-08-17 at 10:27 +0400, Michael Tokarev wrote:
> In 3.0, only two relevant commits are missing as far
> as I can see: this negative autofs dentries fix, and
> LOOKUP_CONTINUE change.  The rest - again, ifaics -
> are merely cosmetics.  I'm not sure about this
> LOOKUP_CONTINUE change, how relevant it is, but
> the two combined does not look bad for -stable.
> I think... :)

Not sure what the LOOKUP_CONTINUE change is, what does it look like or
do you have a git commit number?

There is actually one more change that needs to go in, although you
might not see the problem. It is a fix for a lockdep problem.

Ian
