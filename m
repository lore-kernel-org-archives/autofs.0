From: "Newman, Edward \(GTI\)" <edward_newman@ml.com>
Subject: Re: AutoFS / SASL support
Date: Wed, 7 Nov 2007 08:52:36 -0500
Message-ID: <E5F741E838FC2043A0B843E48181813806AB75BB@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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
To: "Douglas E. Engert" <deengert@anl.gov>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Agreed. Ian and I were discussing (possibly off list) that adding DNS to
automount might add additional latency that he wanted to avoid.

Edward


-----Original Message-----
From: Douglas E. Engert [mailto:deengert@anl.gov] 
Sent: 07 November 2007 08:50
To: Newman, Edward (GTI)
Cc: Ian Kent; autofs@linux.kernel.org
Subject: Re: [autofs] AutoFS / SASL support




Newman, Edward (GTI) wrote:
> The situation I am trying to support is the following:
> 
> - With Active Directory all servers are made available through a
common
> DNS name (i.e. domain.com)
> - The problem with this is that the DNS name alone returns many IPs
and
> these can be remote across a network (round-robin of IP may return a
> remote LDAP server). So we use network location aware DNS name so that
> nearby servers are returned to those applications are not SRV or AD
site
> aware. Aufos fits this category. So assume DNS name is
"ad.domain.com".
> - The issue for SASL is that there is no service principal name in
> Kerberos for ad.domain.com.
> - Thus we need some way to translate the DNS name to a service
principle
> - ldapost.domain.com. This can be done either through forward/reverse
> DNS lookup. A second alternative is the use of dnsHostname in the
> rootdse of the server. Have no particular preference so if DNS is bad
> idea then maybe a quick lookup to rootdse to get name will be required
> for SASL/Kerberos.
> 

Sounds like DNS SRV records fro LDAP. See RFC2782

  http://www.ietf.org/rfc/rfc2782.txt

Your AD should have these already defined, assuming the domain is
ad.domain.com:

  nslookup
  set type=ANY
  _ldap._tcp.ad.domain.com

And it uses it for Kerberos too:
_kerberos._tcp.ad.domain.com

Not sure if OpenLDAP supports this, Google'ing for openldap srv shows
some
interest in it a few years ago.

> I would like to avoid is having to maintain specific lists of
hostnames
> in URI list as maintenance, upgrades, etc would require redeploying a
> new configuration to all servers (in my environment several thousand
> servers).
> 
> Adding a mechanism to support LDAP connection pooling seems a good
idea
> as it looks like autofs creates a lot of queries - issue for a large
> data centre restarting after a powerdown.
> 
> Let me know how I can help here.
> 
> Edward
> --------------------------------------------------------
> 
> This message w/attachments (message) may be privileged, confidential
or proprietary, and if you are not an intended recipient, please notify
the sender, do not use or share it and delete it. Unless specifically
indicated, this message is not an offer to sell or a solicitation of any
investment products or other financial product or service, an official
confirmation of any transaction, or an official statement of Merrill
Lynch. Subject to applicable law, Merrill Lynch may monitor, review and
retain e-communications (EC) traveling through its networks/systems. The
laws of the country of each sender/recipient may impact the handling of
EC, and EC may be archived, supervised and produced in countries other
than the country in which you are located. This message cannot be
guaranteed to be secure or error-free. This message is subject to terms
available at the following link:
http://www.ml.com/e-communications_terms/. By messaging with Merrill
Lynch you consent to the foregoing.

> --------------------------------------------------------
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
> 

-- 

  Douglas E. Engert  <DEEngert@anl.gov>
  Argonne National Laboratory
  9700 South Cass Avenue
  Argonne, Illinois  60439
  (630) 252-5444
