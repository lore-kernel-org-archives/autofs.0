From: Brad Arrington <bradla@inbox.com>
Subject: parse_sun.c error
Date: Sun, 23 Jul 2006 07:27:25 -0800
Message-ID: <C4094AFA0A6.00000427bradla@inbox.com>
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
Cc: raven@themaw.net


I have noticed that the following code in parse_sun.c has a duplicate memory allocation.

The error is present in both autofs-4.1.4 and autofs-5.0.1-rc1.

4.1.4

parse_sun.c

    650         what = alloca(loclen + 1);
    651         memcpy(what, loc, loclen);
    652         what[loclen] = '\0';
    653
    654         if (!strcmp(fstype, "autofs") && strchr(loc, ':') == NULL) {
    655                 char mtype[7];
    656                 int mtype_len;
    657
    658                 if (loc[0] == '/') {
    659                         mtype_len = 5;
    660                         if (loc[1] == '/')
    661                                 strcpy(mtype, "ldap:");
    662                         else
    663                                 strcpy(mtype, "file:");
    664                 } else {
    665                         mtype_len = 3;
    666                         strcpy(mtype, "yp:");
    667                 }
    668
    669                 what = alloca(loclen + mtype_len + 1);
    670                 memcpy(what, mtype, mtype_len);
    671                 memcpy(what + mtype_len, loc, loclen);
    672                 what[loclen + mtype_len] = '\0';
    673         } else {
    674                 what = alloca(loclen + 1);
    675                 memcpy(what, loc, loclen);
    676                 what[loclen] = '\0';
    677         }


5.0.1-rc1

    647         what = alloca(loclen + 1);
    648         memcpy(what, loc, loclen);
    649         what[loclen] = '\0';
    650 /*
    651         if (!strcmp(fstype, "autofs") && strchr(loc, ':') == NULL) {
    652                 char mtype[7];
    653                 int mtype_len;
    654
    655                 if (loc[0] == '/') {
    656                         mtype_len = 5;
    657                         if (loc[1] == '/')
    658                                 strcpy(mtype, "ldap:");
    659                         else
    660                                 strcpy(mtype, "file:");
    661                 } else {
    662                         mtype_len = 3;
    663                         strcpy(mtype, "yp:");
    664                 }
    665
    666                 what = alloca(loclen + mtype_len + 1);
    667                 memcpy(what, mtype, mtype_len);
    668                 memcpy(what + mtype_len, loc, loclen);
    669                 what[loclen + mtype_len] = '\0';
    670         } else {
    671 */
    672                 what = alloca(loclen + 1);
    673                 memcpy(what, loc, loclen);
    674                 what[loclen] = '\0';
    675 /*      } */

diff -ur autofs-4.1.4a/modules/parse_sun.c autofs-4.1.4b/modules/parse_sun.c
--- autofs-4.1.4a/modules/parse_sun.c   2005-04-05 05:42:42.000000000 -0700
+++ autofs-4.1.4b/modules/parse_sun.c   2006-07-22 11:55:39.000000000 -0700
@@ -647,10 +647,6 @@
        mountpoint = alloca(namelen + 1);
        sprintf(mountpoint, "%.*s", namelen, name);
 
-       what = alloca(loclen + 1);
-       memcpy(what, loc, loclen);
-       what[loclen] = '\0';
-
        if (!strcmp(fstype, "autofs") && strchr(loc, ':') == NULL) {
                char mtype[7];
                int mtype_len;
_______________ cut __________________________

diff -ur autofs-5.0.1a/modules/parse_sun.c autofs-5.0.1b/modules/parse_sun.c
--- autofs-5.0.1a/modules/parse_sun.c   2006-07-13 01:11:39.000000000 -0700
+++ autofs-5.0.1b/modules/parse_sun.c   2006-07-22 13:37:40.000000000 -0700
@@ -669,9 +669,6 @@
                what[loclen + mtype_len] = '\0';
        } else {
 */
-               what = alloca(loclen + 1);
-               memcpy(what, loc, loclen);
-               what[loclen] = '\0';
 /*     } */
 
        debug(ap->logopt,
