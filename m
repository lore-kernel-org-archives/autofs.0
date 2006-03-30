From: "Anthony M. Martinez" <twopir@nmt.edu>
Subject: Re: [PATCH] starttls for autofs-ldap-auto-master.c (actually
	attaching it this time.)
Date: Thu, 30 Mar 2006 10:00:55 -0700
Message-ID: <20060330170054.GF12245@nmt.edu>
References: <20060323175511.GE12245@nmt.edu>
	<17448.8748.465963.850118@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R3G7APHDIzY6R/pk"
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <17448.8748.465963.850118@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2006 at 12:34:36PM -0500, Jeff Moyer wrote:
> ==> Regarding [autofs] [PATCH] starttls for autofs-ldap-auto-master.c (actually attaching it this time.); "Anthony M. Martinez" <twopir@nmt.edu> adds:
> 
> twopir> Since our LDAP server is configured to require confidentiality, I made
> twopir> the program default to using it.
> 
> That's great for your environment, but breaks most everyone else.  How
> about making this configurable and not changing the default?  For Debian,
> I'm guessing the configuration would be stored in /etc/default/autofs.  For
> Red Hat systems, it would use /etc/sysconfig/autofs.

Okay. I modified the patch such that passing the -s option to
autofs-ldap-auto-master will cause it to require confidentiality,
otherwise it behaves normally.

I'll look at the distro-specific stuff later.

Pi

> 
> -Jeff
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

-- 
I have always wished that my computer would be as easy to use as my telephone.
My wish has come true. I no longer know how to use my telephone.
-- Bjarne Stroustrup 

--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="starttls_4.1.4.patch"

--- autofs-4.1.4_beta2/samples/autofs-ldap-auto-master.c	2006-03-23 10:21:54.764752622 -0700
+++ autofs-4.1.4_beta2-starttls/samples/autofs-ldap-auto-master.c	2006-03-23 10:28:06.371758942 -0700
@@ -160,6 +160,7 @@
 	LDAP *ld = NULL;
 	int result;
 	int c;
+	int starttls = 0; /* By default, do not start TLS */
 	const char *map_key = MAPKEY, *entry_key = ENTRYKEY, *value = VALUE;
 	const char *map_oc = MAPOC, *entry_oc = ENTRYOC;
 	const char *map = MAP;
@@ -167,7 +168,7 @@
 	setlocale(LC_ALL, "");
 
 	/* Scan through the argument list. */
-	while((c = getopt(argc, argv, "m:e:n:k:v:")) != -1) {
+	while((c = getopt(argc, argv, "m:e:n:k:v:s")) != -1) {
 		switch(c) {
 			case 'm':
 				/* This is the object class we expect maps to
@@ -198,6 +199,10 @@
 				 * VALUE attribute. */
 				value = optarg;
 				break;
+			case 's':
+				/* Enable starttls on the LDAP link */
+				starttls = 1;
+				break;
 			default:
 				fprintf(stderr, "syntax: %s\n"
 					"\t[-m %s] (map object class)\n"
@@ -205,6 +210,7 @@
 					"\t[-n %s] (attribute used as map key)\n"
 					"\t[-k %s] (attribute used as entry key)\n"
 					"\t[-v %s] (attribute used as value)\n"
+					"\t[-s] (enable starttls)\n"
 					"\t[%s] (map name)\n",
 					strchr(argv[0], '/') ?
 					strrchr(argv[0], '/') + 1 : argv[0],
@@ -235,6 +241,12 @@
 		ld = ldap_init(NULL, LDAP_PORT);
 	}
 
+	if(starttls && (ldap_start_tls_s(ld, NULL, NULL) != LDAP_SUCCESS)) {
+		/* Ooops. We failed to start TLS. Bomb out. */
+		ldap_perror(ld, "Couldn't start TLS");
+		return 3;
+	}
+
 	/* Connect to the server anonymously. */
 	result = ldap_simple_bind_s(ld, NULL, NULL);
 	if(result != LDAP_SUCCESS) {

--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--R3G7APHDIzY6R/pk--

