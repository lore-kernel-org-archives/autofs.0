From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/9] Series short description
Date: Wed, 24 Jul 2013 16:37:58 +0800
Message-ID: <1374655078.2358.26.camel@perseus.fritz.box>
References: <20130724081610.722.84685.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=iBLywCg3hkY1AMjuW3048VZGDrI=; b=D4dNI4caRsXAzxKoZ1kncrfNqc6U
	WPeLLT2RlNX5yI4Oj4zIo8obEYYLwQH/mvG41bHXuiPqN77ERQizKQoSuTu2Afnh
	271lNOhayMyBGujyINA2WvEOUETQHWIKFDU72rDpL2v15JY+brkiBsM+K54x6UxE
	Ey3KvsIa6uSgUk0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=iBLywCg3hkY1AMjuW3048V
	ZGDrI=; b=EEN24HllJjLO5dhb/lJ7JapFY2Rgrbzwsbo4GBrs8TeJWjz+MqwqG3
	k5F8B/0LQBA58Xi83m88CxusGQPeiv2qkOsrvJ1xsV78T0EBv5+WJI4pOjLYhtm5
	Rebbah1fVbSvUJayyBcK/wz09BEu8ov3JjqLyhqSqNrdFtpVCeJeU=
In-Reply-To: <20130724081610.722.84685.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Wed, 2013-07-24 at 16:17 +0800, Ian Kent wrote:

False start, ignore it.

> The following series implements...
> 
> ---
> 
> Dustin Polke (1):
>       autofs-5.0.7 - fix compilation of lookup_ldap.c without sasl
> 
> Ian Kent (1):
>       autofs-5.0.7 - use LIBS for link libraries
> 
> Lan Yixun (dlan) (7):
>       autofs-5.0.7 - fix typo forced-shutdown should be force-shutdown
>       autofs-5.0.7 - fix hesiod check error and use correct $(LIBS) setting
>       autofs-5.0.7 - fix dead LDAP symbolic link when LDAP support is disabled
>       autofs-5.0.7 add missing libtirpc lib to mount_nfs.so when TIRPC enabled
>       autofs-5.0.7 - use compiler determined by configure instead of hard-coded ones
>       autofs-5.0.7 - remove hard-coded STRIP variable
>       autofs-5.0.7 - unbundle NOTSTRIP from DEBUG so they wont depend on each other
> 
> 
>  CHANGELOG             |    4 ++++
>  Makefile.conf.in      |    3 +++
>  Makefile.rules        |   30 +++++++++++++++---------------
>  aclocal.m4            |   12 ++++++------
>  configure             |   20 ++++++++++----------
>  configure.in          |    2 +-
>  daemon/Makefile       |    2 +-
>  include/lookup_ldap.h |    4 ++--
>  lib/Makefile          |    4 ++++
>  modules/Makefile      |   20 ++++++++++++--------
>  modules/lookup_ldap.c |   14 ++++++++++++--
>  11 files changed, 70 insertions(+), 45 deletions(-)
> 


