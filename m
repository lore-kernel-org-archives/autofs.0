From: Ian Kent <raven@themaw.net>
Subject: Re: RHEL5 automount against LDAP Maps using basic
 authentication
Date: Sat, 03 Apr 2010 15:16:18 +0800
Message-ID: <1270278978.4021.14.camel@localhost>
References: <4A961A51CBE84C429C56E5734477BD1F2B7D1AB63F@EXCHAMRS03.na.blkint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=gqdKx/XsLMTX7GA0/o/usiV50EI=;
	b=fX0mwzJ63lOaYbZ2mA8PDxhTx2rAvky0KaR0CiCc6ONbCRwh3VJdy6K+r9IuW+I3Oi6hifkMRfG5KJVIB5g+kcA4wY2bo3Md7nGoj7ak7bgA2Ca8EX3bV3WsXrxMSunxoKODrqmnlllz0X757HLD+OPQutij1TPItEsJjHPsWIY=
In-Reply-To: <4A961A51CBE84C429C56E5734477BD1F2B7D1AB63F@EXCHAMRS03.na.blkint.com>
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
To: "Breitman, Jason" <Jason.Breitman@blackrock.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

On Fri, 2010-04-02 at 22:21 -0400, Breitman, Jason wrote:
> Has anyone successfully configured automount to use maps in LDAP when
> the LDAP Server requires basic authentication?
> 

Do you mean simple authenticated bind?

We have recently had a patch contributed for that but it is entirely
untested and so stuck waiting in the queue.

Why haven't you logged a bug with RedHat?

It won't get into RHEL if you don't and if you do you have every chance
of getting a test package with this patch ported to the version of
autofs you are using.

Ian
