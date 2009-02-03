From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS Race Conditions?  Negative Cache?
Date: Tue, 03 Feb 2009 12:26:08 +0900
Message-ID: <1233631568.2951.23.camel@zeus.themaw.net>
References: <F76FAA9B4E7600AAC1FFA15B@ZOP-MACTEL.local>
	<1233113406.3005.21.camel@zeus.themaw.net>
	<E53DDD7AD6715F60A879D415@ZOP-MACTEL.local>
	<1233621955.2951.18.camel@zeus.themaw.net>
	<587B15FCE26A5069952E314B@ZOP-MACTEL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <587B15FCE26A5069952E314B@ZOP-MACTEL.local>
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
To: Michael Loftis <mloftis@wgops.com>
Cc: autofs@linux.kernel.org

On Mon, 2009-02-02 at 18:05 -0700, Michael Loftis wrote:
> 
> --On February 3, 2009 9:45:55 AM +0900 Ian Kent <raven@themaw.net> wrote:
> 
> >> I understand that.  I'm having trouble reproducing this one except under
> >> load, which is why I decided it's probably some sort of race condition.
> >> And it goes away when i set timeout=0.  I'm betting though that with
> >> 'current' autofs4 module it may not happen or with 'current' daemon and
> >> module. I tried to get autofs5 debian package from sid/lenny (debian
> >> unstable/testing) to compile but because it's using some symbols that
> >> don't  exist in ldap.h from openldap 2.1 it won't compile for Debian 4.0
> >> without a  little bit of massaging.
> >
> > What are the symbols?
> > Send over the compile breakage output or the Debian source package (I
> > can probably check it out on my Ubuntu test machine).
> 
> Using the autofs5 package from sid and after a few minor massages to get 
> the debhelper stuff into compliance with the older etch dh tools (5.0.3 
> base, but same errors are present in 5.0.4, same undef-ed symbol) 
> LDAP_CONTROL_PAGEDRESULTS seems to have appeared somewhere eitehr in 
> OpenLDAP 2.2 or in 2.1 after debians libldap2-dev  2.1.30-13.3 packages.

My bad since those functions are defined by autofs if they aren't
present I should be checking for the related symbol define.

Does this help?

autofs-5.0.4 - -check LDAP_CONTROL_PAGEDRESULTS defined

From: Ian Kent <raven@themaw.net>

If LDAP_CONTROL_PAGEDRESULTS is not defined in LDAP includes then
define it.
---

 modules/lookup_ldap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 6ba80eb..64b4168 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -39,6 +39,10 @@
 
 #define MODPREFIX "lookup(ldap): "
 
+#ifndef LDAP_CONTROL_PAGEDRESULTS
+#define LDAP_CONTROL_PAGEDRESULTS "1.2.840.113556.1.4.319" /* RFC 2696 */
+#endif
+
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
 
 static struct ldap_schema common_schema[] = {
