From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS / SASL support
Date: Wed, 07 Nov 2007 17:22:26 +0900
Message-ID: <1194423746.13416.24.camel@raven.themaw.net>
References: <E5F741E838FC2043A0B843E48181813806AB752A@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E5F741E838FC2043A0B843E48181813806AB752A@MLNYC730MB.amrs.win.ml.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Newman, Edward (GTI)" <edward_newman@ml.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-11-06 at 09:30 -0500, Newman, Edward (GTI) wrote:
> Ian
> 
> FYI - The supplied patch appears to break ldap maps with --ghost at the
> end. Seems to be considered part of the search DN.
> 
> Regarding config, the issue appears to be that SASL code calls OpenLDAP
> ldap_get_option and only returns "host" value (which is an optional
> setting). This is used to get LDAP host name (which may be different
> depending on your other URI code). Sort of thing I was thinking about
> would be:

Yes, I can see your point about the round robin DNS issue.
I don't have any ideas on how to resolve that at the moment.

> 
> - pick up server URI(s) from /etc/ldap.conf or via override in
> /etc/sysconfig/autofs

I think it's bad policy to rely on configuration files that belong to
other applications. There's just too much that can go wrong. If we rely
on anything that is external then we must do it via package library
routines and in this case that means it's OpenLDAPs responsibility to
interpret and act on the information in its configuration.

> - If explicit series of hosts supplied then attempt each in turn
> (believe your code already does this but doesn't pass host name through
> to SASL code)

What good is the hostname in the light of the round robin DNS issue?
At the moment it will always be the same as the one obtained with the
LDAP call, which is what the SASL code in autofs does to get it now
anyway.

> - If only one supplied then might want to add option to check DNS to see
> whether this returns multiple IP's - either through SRV records or via
> multiple A records

But, just because a single host is given doesn't mean that it will be
the only one that resolves to multiple IP addresses.

Doing DNS lookups in this part of the code is a bad idea. There's
already too much overhead doing LDAP lookups.

It might be a better idea if we maintained a persistent connection to
the LDAP server and did the lookup at initial connection and reconnect
after failure, but keeping connections open is a bad idea in my opinion
as well.

> - Code might also look at checking "supportedSASLMechanisms" for host
> that it connects to as well as getting server name (dnsHostname). I was
> originally testing with a load-balance name and SASL failed due to wrong
> host principle for Kerberos ("Server not found in database").

I don't understand where the SASL Mechanisms comes into the IP address
problem. I think this check is better done at SASL connect time, as it
is now.

Ian
