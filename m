From: Ian Kent <raven@themaw.net>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
 servers
Date: Wed, 09 Feb 2011 11:50:24 +0800
Message-ID: <1297223424.2771.7.camel@perseus>
References: <4D18885D.6010601@s3group.cz> <1293503090.5923.2.camel@perseus>
	<4D21A19D.3050303@s3group.cz> <1294297764.3010.8.camel@perseus>
	<4D2581F0.8020607@s3group.cz> <1294322864.2852.3.camel@perseus>
	<4D27115A.9010805@s3group.cz>  <4D496CF9.5040001@s3group.cz>
	<1297137397.10090.4.camel@perseus>  <4D5109EF.7040800@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=XjAFkqXUkgscKp6OkZZOHELAZJs=;
	b=U996Cshpl7le4z2MXM3wAczvvEzWgY5RR27wimRWPdHBDnOBw6b9liYKHOfjOiUmsZf1DvnKyk1pbPSPC5prYwBwfWdYd6QeHxktGdRv207aQ59ZPDnzPxvSDPolw2cUI5TrY8G/5jdSKYIQryLXfUDRIP5IUoaDVF0hasIE1Hc=
In-Reply-To: <4D5109EF.7040800@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

On Tue, 2011-02-08 at 10:16 +0100, Ondrej Valousek wrote:
> 
> > Yes, and replied on the 11/01, did you miss it?
> > 
> Ok I must have missed it - now I see you have taken a different
> approach - you are constructing a single looong string with all ldap
> uris and then you parse them again.
> I must say I do not like it too much as:
> a) it is wasted effort (merging together and then splitting again)
> b) potentially can ldap uri contain spaces I think

Don't think so, in this case anyway.

The uris used here aren't full uris, they can only have the proto, host
name and port. AFAIK, host names can't have spaces in them yet.

> 
> But if you like it more, I am fine with it, too.

Yeah, your points above are well taken but had already been done and
committed to the repo so to change would be more work with the potential
for mistakes.

Ian
