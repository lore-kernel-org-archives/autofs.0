From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 12:48:37 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40042F75.9040304@sun.com>
References: <F3123864FB69D411946000D0B77FBBDF0D5E13EF@haendel.bbn.hp.com>
 <40042774.7070003@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31425238736437389=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <40042774.7070003@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "MARX,ALEXANDER (HP-Germany,ex1)" <alexander.marx@hp.com>, autofs@linux.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============31425238736437389==
Content-type: multipart/signed;
 boundary=------------enig45D20319BB9CCCAA187A8140;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45D20319BB9CCCAA187A8140
Content-Type: multipart/mixed;
 boundary="------------060703050209020200010505"

This is a multi-part message in MIME format.
--------------060703050209020200010505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

> MARX,ALEXANDER (HP-Germany,ex1) wrote:
>
>>
>> In some scenarios (e.g. HA), the nfs server could switch from local to
>> remote, therefore having local binds is not a desirable scenario, there
>> should always be nfs mounts.
>>
>
> How would you expect this to work?  The local bind only happens when 
> local and destination address are the same, therefore keeping anything 
> from going across the network no matter how you slice it.
>
This is policy made by the daemon that IMHO may be trying to be too 
smart about what the user wants. I've attached a quick patch, compiled 
not tested that shows how you can add a no_local_binds option to entries 
(written against 4.0.0pre10 because that's what I have on my laptop atm).

Doing local binds may not be the right thing to do in the first place.  
It makes assumptions that the local nfs server is serving the same 
namespace/filesystems as the current application and it will break NFS 
v4 replication and migration when it's ready.

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------060703050209020200010505
Content-Type: text/plain;
 name="nolocalbinds.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nolocalbinds.patch"

diff -ru orig/modules/mount_nfs.c autofs-4.0.0pre10/modules/mount_nfs.c
--- orig/modules/mount_nfs.c	2004-01-13 09:29:27.000000000 -0800
+++ autofs-4.0.0pre10/modules/mount_nfs.c	2004-01-13 09:30:06.000000000 -0800
@@ -73,6 +73,7 @@
   struct sockaddr_in saddr, laddr;
   int sock, local, err;
   int nosymlink = 0;
+  int nolocalbinds = 0;
   size_t len;
 
   syslog(LOG_DEBUG, MODPREFIX " root=%s name=%s what=%s, fstype=%s, options=%s",
@@ -113,6 +114,8 @@
 #endif
       if (strncmp("nosymlink", cp, comma-cp-1) == 0)
 	nosymlink = 1;
+      if (strncmp("no_local_binds", cp, comma-cp-1) == 0)
+	nolocalbinds = 1;
       else {
 	memcpy(nfsp, cp, comma-cp+1);
 	nfsp += comma-cp+1;
@@ -205,7 +208,7 @@
   }
   sprintf(fullpath, "%s/%s", root, name);
   
-  if ( local ) {
+  if ( local && !nolocalbinds ) {
     /* Local host -- do a "bind" */
   
     syslog(LOG_DEBUG, MODPREFIX "%s is local, doing bind", name);

--------------060703050209020200010505--

--------------enig45D20319BB9CCCAA187A8140
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFABC94dQs4kOxk3/MRAgUzAJ4+AZZnIXFXufzGmIBm9IQKJhu96gCff3Yw
hIDYQfmn++QhYickKlJrNos=
=nLqQ
-----END PGP SIGNATURE-----

--------------enig45D20319BB9CCCAA187A8140--


--===============31425238736437389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============31425238736437389==--

