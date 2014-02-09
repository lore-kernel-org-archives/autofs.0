From: Ian Kent <raven@themaw.net>
Subject: Re: Using Multiple SEARCH_BASE entries
Date: Sun, 09 Feb 2014 10:27:37 +0800
Message-ID: <1391912857.2531.3.camel@perseus.fritz.box>
References: <20140207141130.GA18340@geggus.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=upOonYw4F1PTNM47Nb/cqcxoC3w=; b=DABW2UYtpJEsB7KORhO4y2TUKnNQ
	6nWBsoSslROnHpn8/jiqVq2aeIRArH+CJLcV7ve2DVnhpYFAw6M2EcD/P7KvJ68Q
	OtKUk2Cfy4i1uF3xVFdw7VDCU6T3eU8PThyAeNMXBHSfBRTKmzjTQWCK2A52cpnT
	JsodvMVhbIvu5ZM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=upOonYw4F1PTNM47Nb/cqc
	xoC3w=; b=BWtSGPyxXiCz4rMfhcgpZ9fsQ1Tgiv+0UiaXVd/yiReHh8N9veI6j0
	3Gjs43sx14cgtC3SF0buTXTv5To3+az7cQHwij3rK7se//7AJIWHaQykMzHJSnQy
	urhqdFnjgGE5B9p/erLBUT3JUqn2jYL/BDihbpxIzzQgUofI9VvP8=
In-Reply-To: <20140207141130.GA18340@geggus.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sven Geggus <lists@fuchsschwanzdomain.de>
Cc: autofs@vger.kernel.org

On Fri, 2014-02-07 at 15:11 +0100, Sven Geggus wrote:
> Hello,
> 
> while migrating my autofs entries to another directory server I also tried
> to split the entries by organisational units.
> 
> For this purpose I put the following in /etc/default/autofs:
> SEARCH_BASE="ou=autofs,OU=department1,OU=myplace,OU=mydivision,dc=mycompany,DC=com"
> SEARCH_BASE="ou=autofs,OU=department2,OU=myplace,OU=mydivision,dc=mycompany,DC=com"
> 
> Autofs schema is NIS style because this is the only one which active directory
> and Samba4 support without too much hassle.
> 
> However, the splitting does not seem to work.

I think you'll need to describe the structure of your LDAP entries, how
you expect them to be accessed, and how you expect they will be
differentiated one for the other.

If you have the same map name in a subtree that is going to be found.

> 
> It is always using the first entry only:
> 
> ...
> get_query_dn: lookup(ldap): found search base under ou=autofs,OU=department1,OU=myplace,OU=mydivision,dc=mycompany,DC=com
> get_query_dn: lookup(ldap): found query dn CN=auto.master,OU=autofs,OU=department1,OU=myplace,OU=mydivision,dc=mycompany,DC=com
> ...
> 
> Changing SEARCH_BASE to the following does not help either:
> SEARCH_BASE="OU=myplace,OU=mydivision,dc=mycompany,DC=com"
> 
> ...
> get_query_dn: lookup(ldap): found search base under OU=myplace,OU=mydivision,dc=mycompany,DC=com"
> get_query_dn: lookup(ldap): found query dn CN=auto.master,OU=autofs,OU=department2,OU=myplace,OU=mydivision,dc=mycompany,DC=com"
> ...
> 
> No idea why it ends up using department2 in the second case.

No idea, could be a problem with the lookup, can't tell without more
information.

> 
> Any Idea?
> 
> Regards
> 
> Sven
> 
> P.S.: My autofs version is 5.0.7-3 from Debian 7.0
> 


