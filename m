From: "Borislav Stoichkov" <atfs@meanstream.org>
Subject: autofs-ldap-auto-master with ldap filter support
Date: Fri, 30 Sep 2005 08:30:42 -0700 (PDT)
Message-ID: <38648.198.204.141.208.1128094242.squirrel@email.meanstream.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello

In the process of trying to achieve an automounter configuration that
would lookup maps both in local and then ldap maps in that order I ended
up using executable maps. I wanted to use autofs-ldap-auto-master to dump
maps and look for keys but with big maps this took way too long every time
it was done. The solution I implemented was to modify
autofs-ldap-auto-master to add an additional parameter -f for a filter
that can be applied when the map is looked up on the ldap server. The
default filter is to display the whole map which was the behavior prior to
the modification. Here's the patch in case somebody finds this useful.

--- samples/autofs-ldap-auto-master.c.orig      2003-12-10
09:54:33.000000000 -0500
+++ samples/autofs-ldap-auto-master.c   2005-09-27 14:49:20.752043698
-0400 @@ -26,6 +26,7 @@
 #define ENTRYOC "nisObject"
 #define ENTRYKEY "cn"
 #define VALUE "nisMapEntry"
+#define FILTER "*"

 static int
 dump_map(LDAP *ld,
@@ -34,7 +35,8 @@
         const char *entry_class,
         const char *map_key_attribute,
         const char *entry_key_attribute,
-        const char *value_attribute)
+        const char *value_attribute,
+         const char *filter_string)
 {
        LDAPControl *server = NULL, *client = NULL;
        LDAPMessage *messages = NULL, *entry = NULL;
@@ -78,7 +80,8 @@
        }

        /* Set the filter to only find entries in the map we're looking
at. */
-       snprintf(filter, sizeof(filter), "(objectclass=%s)", entry_class);
+       snprintf(filter, sizeof(filter), "(&(%s=%s)(objectclass=%s))", +  
              entry_key_attribute, filter_string, entry_class);

        /* Free memory used by our first query. */
        free(attrs[0]);
@@ -163,11 +166,12 @@
        const char *map_key = MAPKEY, *entry_key = ENTRYKEY, *value =
VALUE; const char *map_oc = MAPOC, *entry_oc = ENTRYOC;
        const char *map = MAP;
+        const char *filter = FILTER;

        setlocale(LC_ALL, "");

        /* Scan through the argument list. */
-       while((c = getopt(argc, argv, "m:e:n:k:v:")) != -1) {
+       while((c = getopt(argc, argv, "m:e:n:k:v:f:")) != -1) {
                switch(c) {
                        case 'm':
                                /* This is the object class we expect maps to
@@ -198,6 +202,11 @@
                                 * VALUE attribute. */
                                value = optarg;
                                break;
+                        case 'f':
+                                /* This is the filter for the ENTRY_KEY +
                                * attribute. The default is FILTER = "*".
*/
+                                filter = optarg;
+                                break;
                        default:
                                fprintf(stderr, "syntax: %s\n"
                                        "\t[-m %s] (map object class)\n"
@@ -205,11 +214,12 @@
                                        "\t[-n %s] (attribute used as map
key)\n"
                                        "\t[-k %s] (attribute used as
entry key)\n"
                                        "\t[-v %s] (attribute used as
value)\n"
-                                       "\t[%s] (map name)\n",
+                                       "\t[%s] (map name)\n"
+                                       "\t[-f %s] (cn filter)\n",
                                        strchr(argv[0], '/') ?
                                        strrchr(argv[0], '/') + 1 :
argv[0], map_oc, entry_oc,
map_key, entry_key,
-                                       value, map);
+                                       value, map, filter);
                                return 0;
                                break;
                }
@@ -245,7 +255,8 @@
        }

        /* Try to dump the map given the preferred or user-supplied
schema. */
-       if(!dump_map(ld, map, map_oc, entry_oc, map_key, entry_key,
value)) { +       if(!dump_map(ld, map, map_oc, entry_oc, map_key,
entry_key, value, +                     filter)) {
                if(strcmp(map_oc, "automountMap") ||
                   strcmp(entry_oc, "automount") ||
                   strcmp(map_key, "ou") ||
@@ -257,7 +268,8 @@
                                 "automount",
                                 "ou",
                                 "cn",
-                                "automountInformation");
+                                "automountInformation",
+                                 filter);
                }
        }

Borislav
