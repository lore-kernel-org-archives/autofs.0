From: Jun Futagawa <jfut@featia.net>
Subject: [patch] retrieve LDAP error message string
Date: Mon, 20 Sep 2004 17:03:29 +0900
Sender: autofs-bounces@linux.kernel.org
Message-ID: <414E8ED1.6040505@featia.net>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi,

When I updated to v4 from v3, I encountered the following error message.

automount[26411]: lookup(ldap): query failed for (&(objectclass=automount))
automount[26411]: failed to load map, exiting

Since the details of the error were not found, I applied the following patch.

--- autofs-4.1.3/modules/lookup_ldap.c.orig	2004-04-03 16:14:33.000000000 +0900
+++ autofs-4.1.3/modules/lookup_ldap.c	2004-09-20 13:36:53.193400776 +0900
@@ -222,7 +222,7 @@
 			   query, attrs, 0, &result);
 
 	if ((rv != LDAP_SUCCESS) || (result == NULL)) {
-		crit(MODPREFIX "query failed for %s", query);
+		crit(MODPREFIX "query failed for %s: %s", query, ldap_err2string(rv));
 		return 0;
 	}
 

The patched error message in the case of using OpenLDAP is as follows.

automount[29790]: lookup(ldap): query failed for (&(objectclass=automount)): Size limit exceeded
automount[29790]: failed to load map, exiting

It was because the search query to LDAP was changed by v3 and v4.
# query for user1 map
v4: (&(objectclass=automount))
v3: (&(objectclass=automount)(cn=user1))

I solved this problem by specifying the sizelimit directive to the
configuration file of OpenLDAP server for your reference.
http://www.openldap.org/doc/admin22/slapdconfig.html

# /etc/openldap/slapd.conf
sizelimit 5000
(The default is 500. But, I have many entries more than it.)

I want this patch to be merged so that the cause of an error can be
identified.

-- 
Jun Futagawa
SMBLDAP-TOOLS Addons http://smbldap-addons.sourceforge.net/
The smbldap-autofs-tools provides a anagement function of automount and 
automountMap entries defined by autofs.schema.
