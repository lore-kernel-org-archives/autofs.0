From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: auto.master in ldap + simple bind
Date: Wed, 21 Jan 2009 10:36:57 +0100
Message-ID: <4976ECB9.6090207@s3group.cz>
References: <49709FA6.1040203@s3group.cz>	<1232122347.3166.102.camel@zeus.themaw.net>	<1232168581.3072.0.camel@zeus.themaw.net>	<4608.82.208.2.231.1232305306.squirrel@webmail.s3group.com>
	<1232332943.3136.28.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232332943.3136.28.camel@zeus.themaw.net>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

There is something rotten in the lookup_ldap.c but I can not point my
finger on it.
Things go bad in the lookup_init() function:
  5   4.389459 192.168.60.171 -> 192.168.60.172 LDAP bindRequest(1)
"<ROOT>" sasl
  6   4.390383 192.168.60.172 -> 192.168.60.171 LDAP bindResponse(1)
saslBindInProgress
  7   4.390396 192.168.60.171 -> 192.168.60.172 TCP 39957 > ldap [ACK]
Seq=27 Ack=218 Win=6912 Len=0 TSV=17330479 TSER=592592279
  8   4.390846 192.168.60.171 -> 192.168.60.172 LDAP bindRequest(2)
"<ROOT>" sasl
  9   4.392733 192.168.60.172 -> 192.168.60.171 LDAP bindResponse(2) success
 10   4.393095 192.168.60.171 -> 192.168.60.172 LDAP bindRequest(3)
"<ROOT>" sasl
 11   4.394062 192.168.60.172 -> 192.168.60.171 LDAP bindResponse(3)
invalidCredentials (00090313: LdapErr: DSID-0C0904D1, comment:
AcceptSecurityContext error, data 0, v1771)
 12   4.394188 192.168.60.171 -> 192.168.60.172 LDAP unbindRequest(4)

Packet 8,9 - we connect to the server to verify the authentication
mechanism, but then we should drop the connection - line 1286 - call to
ldap_unbind_connection(). But this never happens according to the
tcpdump. Instead, another bind follows and fails. The question is now:
1. Why is there no unbindRequest packet? In general, I see 3 bind
requests but only one unbindrequest....
2. Why the second bindRequest fails and the first one succeeds?

I do not want to be too picky, but Windows Server 2008 is the first
server OS from MS to support RFC2307 LDAP schema so I believe we should
be able to connect to it. I have opened a case #1887566 with RedHat
regarding this....
Ondrej
