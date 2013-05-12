From: Doug Nazar <nazard@nazar.ca>
Subject: get_proximity() crashes on interfaces with no addresses
Date: Sun, 12 May 2013 11:48:44 -0400
Message-ID: <518FB9DC.3000304@nazar.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030803060201080307000009"
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org

This is a multi-part message in MIME format.
--------------030803060201080307000009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Since commit aa6f7793 [autofs-5.0.7 - fix ipv6 proximity calculation] 
uses getifaddrs however it crashes on interfaces with no addresses. Fix 
the NULL check to ignore interfaces with no addresses.

Should it also check for the IFF_UP flag?

Doug


--------------030803060201080307000009
Content-Type: text/plain; charset=windows-1252;
 name="autofs-5.0.7-fix-interface-address-null-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="autofs-5.0.7-fix-interface-address-null-check.patch"

diff -ur autofs-5.0.7.orig/modules/replicated.c autofs-5.0.7/modules/replicated.c
--- autofs-5.0.7.orig/modules/replicated.c	2013-05-10 04:48:32.000000000 -0400
+++ autofs-5.0.7/modules/replicated.c	2013-05-10 04:50:07.000000000 -0400
@@ -166,7 +166,7 @@
 	this = ifa;
 	while (this) {
 		if (this->ifa_flags & IFF_POINTOPOINT ||
-		    this->ifa_addr->sa_data == NULL) {
+		    this->ifa_addr == NULL) {
 			this = this->ifa_next;
 			continue;
 		}
@@ -203,7 +203,7 @@
 	this = ifa;
 	while (this) {
 		if (this->ifa_flags & IFF_POINTOPOINT ||
-		    this->ifa_addr->sa_data == NULL) {
+		    this->ifa_addr == NULL) {
 			this = this->ifa_next;
 			continue;
 		}

--------------030803060201080307000009--
