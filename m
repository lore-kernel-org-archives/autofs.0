From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Building autofs 5.0.3 on Debian Etch
Date: Thu, 05 Jun 2008 18:41:51 +0200
Message-ID: <1212684111.3160.12.camel@vesuv.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hi again!

I try to build the latest and greatest autofs5 (5.0.3, with all patches
from kernel.org applied) on a plain debian etch (4.0) system, but it
fails on LDAP:

lookup_ldap.c:88: error: 'LDAP_CONTROL_PAGEDRESULTS' undeclared (first use in this function)
lookup_ldap.c:88: error: (Each undeclared identifier is reported only once
lookup_ldap.c:88: error: for each function it appears in.)
lookup_ldap.c: In function 'ldap_parse_page_control':
lookup_ldap.c:103: error: 'LDAP_CONTROL_PAGEDRESULTS' undeclared (first use in this function)

Whereas autofs5 5.0.2 (with all patches from kernel.org applied) builds
and works just fine.

LDAP_CONTROL_PAGEDRESULTS seems to have been introduced somewhere in
between openldap 2.1.30-13.3, which debian etch uses, and 2.4.7, which
Ubuntu Hardy uses. On Hardy, autofs5 5.0.3 compiles just fine.

Is there any way to work around this? I did try to backport a newer
openldap as well, but that's a major PITA because it itself requires a
newer GnuTLS which itself requires newer libgcrypt and other stuff.

Thanks alot,
Lukas
