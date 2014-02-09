From: Ian Kent <raven@themaw.net>
Subject: Re: Using Multiple SEARCH_BASE entries
Date: Sun, 09 Feb 2014 10:39:52 +0800
Message-ID: <1391913592.2531.8.camel@perseus.fritz.box>
References: <20140207141130.GA18340@geggus.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=37wj9dt4BXS8tuHrYNd+pEg0jMU=; b=qrG186lUrXr5Pc5l3nrssQKcfTL7
	gXd6jUGcSH6nzYUI3/4dhkXmSV4OLPhrFqBMNGyek50JXJ5bQyic/IsZ8Wu5eRwp
	d1E3vFRPqCGz7cri4VItMzMfqW3RpQOAs+FhWFu+mc8mLZrvMBWRbLYWtsnKB0su
	FM/XeyW0oz0TCW8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=37wj9dt4BXS8tuHrYNd+pE
	g0jMU=; b=AK8ZlGEDa0koggLnEBHsoMIXpCOekG03iHjQv9wCl/y7nov2/jZpN0
	EElBcKBAHPSWhwZJxVoGexuYPFo8fI/M24+WQJjhDvwd5KfdxxsoV+cnnKnxhN0C
	jB8N52gW5DKGTCcmVxcdLDWzDiUeRWg4/v2lPlEGn28t3Wxst+FoM=
In-Reply-To: <20140207141130.GA18340@geggus.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sven Geggus <lists@fuchsschwanzdomain.de>
Cc: autofs@vger.kernel.org

On Fri, 2014-02-07 at 15:11 +0100, Sven Geggus wrote:
> Changing SEARCH_BASE to the following does not help either:
> SEARCH_BASE="OU=myplace,OU=mydivision,dc=mycompany,DC=com"
> 
> ...
> get_query_dn: lookup(ldap): found search base under OU=myplace,OU=mydivision,dc=mycompany,DC=com"
> get_query_dn: lookup(ldap): found query dn CN=auto.master,OU=autofs,OU=department2,OU=myplace,OU=mydivision,dc=mycompany,DC=com"
> ...
> 
> No idea why it ends up using department2 in the second case.

Yeah, don't know, maybe the list is being traversed backward.
That would be easy to change but, if there are multiple possible matches
in the subtrees changing that won't help.

> 
> Any Idea?
> 
> Regards
> 
> Sven
> 
> P.S.: My autofs version is 5.0.7-3 from Debian 7.0
> 

No idea what that means.
The Debian maintainer needs to step up to clarify what's included in
that package.

Ian


