From: raven@themaw.net
Subject: Re: Autofs4 4.1.3-28 with NetApp filer
Date: Tue, 22 Feb 2005 00:37:12 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502220033460.20458@donald.themaw.net>
References: <482A3FA0050D21419C269D13989C611308539786@lavender-fe.eng.netapp.com>
	<Pine.LNX.4.58.0502211259250.9892@wombat.indigo.net.au>
	<16922.2764.932856.525189@segfault.boston.redhat.com>
Mime-Version: 1.0
In-Reply-To: <16922.2764.932856.525189@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, "Lever, Charles" <Charles.Lever@netapp.com>

On Mon, 21 Feb 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] Autofs4 4.1.3-28 with NetApp filer; Ian Kent <raven@themaw.net> adds:
>
> raven> On Sun, 20 Feb 2005, Lever, Charles wrote:
>>> Customer of ours describes this problem:
>>>
>>>> We have several netapp boxes that we use as filers and all > of them
>>> at this site, with the exception of this one box, would unmount > for
>>> the linux workstation after the autmount timeout period.  With the >
>>> implementation of autofs-4.1.3-28 this particular netapp box would not >
>>> only NOT unmount (/net mounts) after timeouts, and would not release >
>>> its ports, it would begin to actively take more ports (without any >
>>> other mounts of this netapp box taking place).  Within 24 hours a linux
>>>> box can be hung by the port-taking activity of this netapp box mounted
>>>> via /net.
>>>
>>> They are running on RH 8.0, kernel 2.4.20-20.8smp.  Problem did not
>>> occur with autofs-4.1.2.
>>>
>>> Does this sound familiar to anyone?
>
> raven> This sounds like the mount order problem we had recently.  Also
> raven> against a Filer I think.
>
> raven> We can confirm this is the same problem by collecting a log with the
> raven> --debug option set.
>
> raven> I can forward a patch but Jeff may already have included it in his
> raven> rpm.
>
> raven> Lets confirm it first.
>
> Maybe it's just because it's Monday, but I'm not sure which patch you are
> referring to.  Could you post it, and then I'll let you know if I have an
> updated RPM?  ;-)
>

Sure thing. The patch forces the mount order to be shortest path to 
longest regardless of the order the export list.

There were two patches.  The second being a correction.

The first.

--- autofs-4.1.3/modules/parse_sun.c.multi-over	2005-01-14 19:44:39.000000000 +0800
+++ autofs-4.1.3/modules/parse_sun.c	2005-01-14 20:36:17.000000000 +0800
@@ -55,6 +55,13 @@
  	int slashify_colons;	/* Change colons to slashes? */
  };

+struct multi_mnt {
+	char *path;
+	char *options;
+	char *location;
+	struct multi_mnt *next;
+};
+
  struct utsname un;
  char processor[65];		/* Not defined on Linux, so we make our own */

@@ -609,6 +616,69 @@
  }

  /*
+ * Build list of mounts in shortest -> longest order.
+ * Pass in list head and return list head.
+ */
+struct multi_mnt *multi_add_list(struct multi_mnt *list,
+				 char *path, char *options, char *location)
+{
+	struct multi_mnt *mmptr, *new, *old = NULL;
+	int plen;
+
+	if (!path || !options || !location)
+		return NULL;
+
+	new = malloc(sizeof(struct multi_mnt));
+	if (!new)
+		return NULL;
+
+	new->path = path;
+	new->options = options;
+	new->location = location;
+
+	plen = strlen(path);
+	mmptr = list;
+	while (mmptr) {
+		if (plen <= strlen(mmptr->path))
+			break;
+		old = mmptr;
+		mmptr = mmptr->next;
+	}
+
+	if (old)
+		old->next = new;
+	new->next = mmptr;
+
+	return old ? list : new;
+}
+
+void multi_free_list(struct multi_mnt *list)
+{
+	struct multi_mnt *next;
+
+	if (!list)
+		return;
+
+	next = list;
+	while (next) {
+		struct multi_mnt *this = next;
+
+		next = this->next;
+
+		if (this->path)
+			free(this->path);
+
+		if (this->options)
+			free(this->options);
+
+		if (this->location)
+			free(this->location);
+
+		free(this);
+	}
+}
+
+/*
   * syntax is:
   *	[-options] location [location] ...
   *	[-options] [mountpoint [-options] location [location] ... ]...
@@ -661,6 +731,7 @@
  	debug(MODPREFIX "gathered options: %s", options);

  	if (*p == '/') {
+		struct multi_mnt *list, *head = NULL, *next;
  		int l;
  		char *multi_root;

@@ -684,11 +755,11 @@
  			if (myoptions == NULL) {
  				error(MODPREFIX "multi strdup: %m");
  				free(options);
+				multi_free_list(head);
  				return 1;
  			}

  			path = dequote(p, l = chunklen(p, 0));
-			pathlen = strlen(path);

  			p += l;
  			p = skipspace(p);
@@ -706,6 +777,7 @@
  						    "multi concat_options: %m");
  						free(options);
  						free(path);
+						multi_free_list(head);
  						return 1;
  					}
  					p = skipspace(p);
@@ -721,28 +793,42 @@
  			l = q - p;

  			loc = dequote(p, l);
-			loclen = strlen(loc);
-
  			if (loc == NULL || path == NULL) {
  				error(MODPREFIX "out of memory");
  				free(loc);
  				free(path);
  				free(options);
+				free(myoptions);
+				multi_free_list(head);
  				return 1;
  			}

  			p += l;
  			p = skipspace(p);

+			list = head;
+			head = multi_add_list(list, path, myoptions, loc);
+			if (!head) {
+				free(loc);
+				free(path);
+				free(options);
+				free(myoptions);
+				multi_free_list(head);
+				return 1;
+			}
+		} while (*p == '/');
+
+		next = head;
+		while (next) {
  			debug(MODPREFIX
  			      "multimount: %.*s on %.*s with options %s",
-			      loclen, loc, pathlen, path, myoptions);
+			      strlen(next->location), next->location,
+			      strlen(next->path), next->path, next->options);

-			rv = sun_mount(multi_root, path, pathlen, loc, loclen,
-				       myoptions);
-			free(path);
-			free(loc);
-			free(myoptions);
+			rv = sun_mount(multi_root,
+				       next->path, strlen(next->path),
+				       next->location, strlen(next->location),
+				       next->options);

  			/* Convert non-strict failure into success */
  			if (rv < 0) {
@@ -751,7 +837,10 @@
  			} else if (rv > 0)
  				break;

-		} while (*p == '/');
+			next = next->next;
+		}
+
+		multi_free_list(head);

  		free(options);
  		return rv;


The second

--- autofs-4.1.3/modules/parse_sun.c.multi-over-2	2005-01-17 21:50:18.000000000 +0800
+++ autofs-4.1.3/modules/parse_sun.c	2005-01-17 21:51:06.000000000 +0800
@@ -750,7 +750,6 @@
  		do {
  			char *myoptions = strdup(options);
  			char *path, *loc;
-			int pathlen, loclen;

  			if (myoptions == NULL) {
  				error(MODPREFIX "multi strdup: %m");
@@ -813,7 +812,7 @@
  				free(path);
  				free(options);
  				free(myoptions);
-				multi_free_list(head);
+				multi_free_list(list);
  				return 1;
  			}
  		} while (*p == '/');
