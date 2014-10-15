From: rsmits-l <rsmits-l@tudelft.nl>
Subject: Problem with autofs and ldap
Date: Wed, 15 Oct 2014 14:31:14 +0200
Message-ID: <543E6912.8050109@tudelft.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@vger.kernel.org

Hello,

I have a very weird issue that maybe someone sounds familiar. I have 
placed our automount entry's in our Active Directory / LDAP. Problem is 
that is it not stable. After a restart of autofs I sometimes only see 
half of our map entry's. Sometimes 75 %.

When I do a autofs reload maybe 90 % of the time I see all entry's. I am 
having this issue on Redhat 6 and Suse 11. Strange thing is that the 
autofs logging (debug) shows always all the entry's but are not 
reflected in the filesystem structure.

This is my config :

/etc/sysconfig/autofs
----
LDAP_URI="ldap://srvxxx.domain.net/"
SEARCH_BASE="ou=LinuxAutoMount,ou=Resources,dc=domain,dc=net"
LDAP_TIMEOUT="100"
LDAP_NETWORK_TIMEOUT="100"
MAP_HASH_TABLE_SIZE=2048

/etc/autofs_ldap_auth.conf
----
<autofs_ldap_sasl_conf
      usetls="no"
      tlsrequired="no"
      authrequired="yes"
      authtype="GSSAPI"
      clientprinc="nfs/client01.domain.net@DOMAIN.NET"
/>

/etc/nsswitch.conf
----
automount:    files ldap

Greetings, Richard Smits
-- 
R. (Richard) Smits
Systeembeheerder

TU Delft / Shared Service centre ICT
Landbergstraat 15, 2628CE Delft
Kamer: C-2-520
Postbus 354, 2600AJ Delft
T +31 (0)15 27 87312
F +31 (0)15 27 83787
E r.smits@tudelft.nl
I www.ssc-ict.tudelft.nl/pdc
aanwezig: maandag t/m donderdag
