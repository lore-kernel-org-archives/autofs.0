From: Chris Feist <cfeist@redhat.com>
Subject: [patch] Fix for ldap_search when multiple cn's are in one LDAP
	entry.
Date: Fri, 10 Dec 2004 13:11:39 -0600
Message-ID: <41B9F4EB.2050202@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040506090305090101090702"
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
To: raven@themaw.net, autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------040506090305090101090702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a bug in the ldap search which will only use the first 
mount point found in an LDAP entry.

For example if an ldap entry looks like this:

dn: cn=%T%I_apps, nisMapName=auto_home, ou=foo.bar
nismapname: auto_home
objectClass: top
objectClass: nisobject
nismapentry: foo.bar.ti.com:/vol/vol6/TI_apps
cn: %T%I_apps
cn: TI_apps

Then the auto_home map will only be used in /%T%I_apps

If you try to cd into TI_apps you'll just get an error.  The patch 
forces ldap_search to iterate through all of the different cn's in an 
entry so you can cd into either %T%I_apps or TI_apps and the proper 
directory will still be automounted.

Thanks,
Chris

--------------040506090305090101090702
Content-Type: text/x-patch;
 name="autofs-4.1.3-ldap-multiple-map.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-4.1.3-ldap-multiple-map.patch"

--- autofs-4.1.3/modules/lookup_ldap.c.orig	2004-04-03 01:14:33.000000000 -0600
+++ autofs-4.1.3/modules/lookup_ldap.c	2004-12-10 13:06:21.470895667 -0600
@@ -154,7 +154,7 @@
 			struct lookup_context *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
-	int rv, i, l, count;
+	int rv, i, j, l, count, keycount;
 	time_t age = time(NULL);
 	char *query;
 	LDAPMessage *result, *e;
@@ -250,10 +250,14 @@
 		}
 
 		count = ldap_count_values(values);
+		keycount = ldap_count_values(keyValue);
 		for (i = 0; i < count; i++) {
-			if (**keyValue == '/' && strlen(*keyValue) == 1)
-				**keyValue = '*';
-			cache_update(*keyValue, values[i], age);
+		  	for (j = 0; j < keycount; j++) {
+				if (*(keyValue[j]) == '/' &&
+				    strlen(keyValue[j]) == 1)
+			  		*(keyValue[j]) = '*';
+				cache_update(keyValue[j], values[i], age);
+			}
 		}
 		ldap_value_free(values);
 

--------------040506090305090101090702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------040506090305090101090702--

