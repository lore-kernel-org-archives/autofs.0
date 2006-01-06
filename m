From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [PATCH] 4.1.4 - fix multimounts with single entry
Date: Fri, 6 Jan 2006 17:55:36 +0300
Message-ID: <200601061755.37441.arvidjaar@mail.ru>
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[I am not subscribed to this list]

This easily happens when you are using e.g. /net map and host exports single 
directory. In this case currently automount will mount this directory 
on /net/host instead of creating path under /net/host,

regards

- -andrey

- --- autofs-4.1.4/modules/parse_sun.c.multi	2005-04-05 16:42:42.000000000 +0400
+++ autofs-4.1.4/modules/parse_sun.c	2006-01-06 17:33:01.000000000 +0300
@@ -759,50 +759,6 @@ void multi_free_list(struct multi_mnt *l
 }
 
 /*
- - * Scan map entry looking for evidence it has multiple key/mapent
- - * pairs.
- - */
- -static int check_is_multi(const char *mapent)
- -{
- -	const char *p = (char *) mapent;
- -	int multi = 0;
- -	int first_chunk = 0;
- -
- -	while (*p) {
- -		p = skipspace(p);
- -
- -		/*
- -		 * After the first chunk there can be additional
- -		 * locations (possibly not multi) or possibly an
- -		 * options string if the first entry includes the
- -		 * optional '/' (is multi). Following this any
- -		 * path that begins with '/' indicates a mutil-mount
- -		 * entry.
- -		 */
- -		if (first_chunk) {
- -			if (*p == '/' || *p == '-') {
- -				multi = 1;
- -				break;
- -			}
- -		}
- -
- -		while (*p == '-') {
- -			p += chunklen(p, 0);
- -			p = skipspace(p);
- -		}
- -
- -		/*
- -		 * Expect either a path or location
- -		 * after which it's a multi mount.
- -		 */
- -		p += chunklen(p, check_colon(p));
- -		first_chunk++;
- -	}
- -
- -	return multi;
- -}
- -
- -/*
  * syntax is:
  *	[-options] location [location] ...
  *	[-options] [mountpoint [-options] location [location] ... ]...
@@ -855,7 +811,8 @@ int parse_mount(const char *root, const 
 
 	debug(MODPREFIX "gathered options: %s", options);
 
- -	if (check_is_multi(p)) {
+	/* '/' here means path and hence multi entry */
+	if (*p == '/') {
 		struct multi_mnt *list, *head = NULL;
 		char *multi_root;
 		int l;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDvoTpR6LMutpd94wRApOUAKCYz0G44CEQwnJZnKekknw5n0OZkwCggahc
cMxr5QUtWxgNhnPT+1UnpHs=
=rMqb
-----END PGP SIGNATURE-----
