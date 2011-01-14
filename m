From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.4 and 5.0.5 do not remove ghost entries
 upon SIGHUP
Date: Fri, 14 Jan 2011 10:56:05 +0800
Message-ID: <1294973765.2794.2.camel@perseus>
References: <20110111183424.7f0f7ad4@cs.bgu.ac.il>
	<1294905042.2757.42.camel@perseus> <1294910202.2757.46.camel@perseus>
	<20110113163643.12dcadff@cs.bgu.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=Q6cw/65IWH6MCqXvombcMGm3fm0=;
	b=mzgJ2XRR9aeZgdfPXvY+/tEk7otJpre78L6+rerw1zr34qfgmB58RuBzCXiZIFzT4q6cT8vBXQUZ6g7Tv8t3xSK4j0PHP0y7r3vvSfnfQevL7rJpTKj9nHrYeXe+AZIQPW6fVmXQZiPy0ZMkZpuo0yCCqMVAUXU4ft3ttyR4oDI=
In-Reply-To: <20110113163643.12dcadff@cs.bgu.ac.il>
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
To: Michael Orlov <orlovm@cs.bgu.ac.il>
Cc: autofs@linux.kernel.org

On Thu, 2011-01-13 at 16:36 +0200, Michael Orlov wrote:
> > So I've done that and this patch seems to resolve the problem but I
> > doubt it will apply to the source you are using without some other
> > dependent patches from kernel.org.
> 
> Gentoo applies the patches listed in
> http://kernel.org/pub/linux/daemons/autofs/v5/patch_order-5.0.5 - is
> that what you mean?

Yes, but there are a few others I have here.
The patches against this part of the code should all be available on
kernel.org so you should be OK.

> 
> > autofs-5.0.5 - fix prune cache valid check
> 
> Thanks! Will you be adding the patch to
> http://kernel.org/pub/linux/daemons/autofs/v5/ ?

Not until I get feedback as to whether it fixes the issue and a little
think time on my part.

Ian
