From: Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>
Subject: LDAP: suggesting one tiny and one larger patch
Date: Fri, 24 Sep 2004 12:26:37 +0200 (CEST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409231703430.28706@uranos.quantum.physik.uni-potsdam.de>
Reply-To: Timo.Felbinger@physik.uni-potsdam.de
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org


Hello,

I'm currently trying to get users' home directories automounted, with
maps stored in LDAP. I found that I want some things which the current
lookup_ldap module cannot do (I believe), so I decided to patch it :-)

Doing this, I discovered the undocumented(?) yet (IMO) useful option
--no-slashify, which however seems to be buggy in 4.1.3, so I suggest
a tiny fix to actually make it work:

diff -u -r autofs-4.1.3-orig/modules/parse_sun.c autofs-4.1.3/modules/parse_sun.c
--- autofs-4.1.3-orig/modules/parse_sun.c	2004-05-18 14:22:40.000000000 +0200
+++ autofs-4.1.3/modules/parse_sun.c	2004-09-22 15:36:56.539912580 +0200
@@ -391,7 +391,7 @@
 					bval = 1;
 				}

-				if (strmcmp(xopt, "slashify-colons", 1))
+				if (!strmcmp(xopt, "slashify-colons", 1))
 					ctxt->slashify_colons = bval;
 				else
 					error(MODPREFIX "unknown option: %s",

My actual patch of lookup_ldap.c grew somewhat larger than initially
planned (so I'm not posting a diff), and I believe it could be useful
and could be merged into the autofs source (after more testing, of
course), so I put a modified lookup_ldap.c at

  http://www.timof.qipc.org/autofs-4.1.3-patch/lookup_ldap.c-patched

I invite everyone using autofs with LDAP to try and use it. Basically,
it will parse map names in (almost) the form of LDAP URIs as defined
in rfc2255:

 [[scheme:]//server[:port]][/basedn][?attr[?scope[?filter[?ext]]]]]

This gives more flexibility: e.g., you can get TLS, you can use your
own LDAP schema, and apply arbitrary filters; details are in

  http://www.timof.qipc.org/autofs-4.1.3-patch/README.ldap-patch

The last example there is approximately what I wanted to have, and
what I am currently (test-)using (and so far it seems to work well):
In addition to being able to connect with TLS, I wanted to put the
automountInformation for home directories right into the account
database (rather than into a separate subtree), using homeDirectory
(which is there anyway) as the "key" (ie, mountpoint) attribute.

I tried to keep everything backward compatible: the current form of
ldap map names, [//host/]base, should still work, with both
autofs.schema and nis.schema, so not too many things should break.
(and following Jun Futagawa's recent suggestion, the modified lookup
module will print human-readable LDAP error messages, where possible.)


Regards,

Timo


-- 
Timo Felbinger                  <Timo.Felbinger@physik.uni-potsdam.de>
Quantum Physics Group           http://www.quantum.physik.uni-potsdam.de
Institut fuer Physik            Tel: +49 331 977 1793      Fax: -1767
Universitaet Potsdam, Germany
