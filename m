From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs and ldap
Date: Fri, 17 Oct 2014 16:51:40 +0800
Message-ID: <5440D89C.6040001@themaw.net>
References: <543E6912.8050109@tudelft.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:date:from:mime-version:to:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	 s=mesmtp; bh=jWM+vB1egEMizIh4UtEyF9/gmV4=; b=bONE5SIncYCs+TYnXZ
	6nd6W4Iao0xjTY/M3JVvG3NgzZoO9qQrEtPF5ZDj5ThSoQWsS6Abo63SDvLLkd0Z
	LlvEr0j22qojvelzA2uYz/Ng2SMtoKNuDc4UgXraij7OQ+ZP+/Gg8Ot8sMZiTsR6
	aWRn1bX6u3VuVRr+9VhkxZ4DU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=jWM+vB1egEMizIh4UtEyF9
	/gmV4=; b=r68NXmWH+1ry4o8+zyOST8Vtconii5f2IrSabud1SquGu2Q5h8vrhq
	IYWnGMFuI0s6dYVwLFaskBO0kQQoQ6U3qyvBkOHhpP7T1b4T6Shq40Tn+LQypUmO
	wLz9ZMurNsAA+LPeDNK9bAsweLCreaSfbPXMOfrP8f0svYvFIuf+o=
In-Reply-To: <543E6912.8050109@tudelft.nl>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: rsmits-l <rsmits-l@tudelft.nl>, autofs@vger.kernel.org

On 15/10/14 20:31, rsmits-l wrote:
> Hello,
>
> I have a very weird issue that maybe someone sounds familiar. I have
> placed our automount entry's in our Active Directory / LDAP. Problem is
> that is it not stable. After a restart of autofs I sometimes only see
> half of our map entry's. Sometimes 75 %.

That's odd if the map is actually being read, yes.
At one time autofs didn't do paged ldap reads so AD would only send one 
page which meant not all the entries would be read for larger maps.

>
> When I do a autofs reload maybe 90 % of the time I see all entry's. I am
> having this issue on Redhat 6 and Suse 11. Strange thing is that the
> autofs logging (debug) shows always all the entry's but are not
> reflected in the filesystem structure.

I can't remember now what gets logged for the ldap map reads so how have 
you established the read gets all the entries (and what rel6 version of 
autofs are you using)?

>
> This is my config :
>
> /etc/sysconfig/autofs
> ----
> LDAP_URI="ldap://srvxxx.domain.net/"
> SEARCH_BASE="ou=LinuxAutoMount,ou=Resources,dc=domain,dc=net"
> LDAP_TIMEOUT="100"
> LDAP_NETWORK_TIMEOUT="100"
> MAP_HASH_TABLE_SIZE=2048

OK, so BROWSE_MODE isn't set so it = yes by default and you expect the 
mount point directories within what are probably indirect mounts to be 
created or removed, as the case may be, correct?

But they aren't all being created (or removed)?

>
> /etc/autofs_ldap_auth.conf
> ----
> <autofs_ldap_sasl_conf
>       usetls="no"
>       tlsrequired="no"
>       authrequired="yes"
>       authtype="GSSAPI"
>       clientprinc="nfs/client01.domain.net@DOMAIN.NET"
> />

Don't think this makes any difference since if auth was failing I don't 
think you would get any entries.

>
> /etc/nsswitch.conf
> ----
> automount:    files ldap

This might make a difference, depending on what file maps exist, but we 
would need a debug log and map examples to reproduce the problem.

What about logging a bug against rhel-6 and working on it there.

Ian
