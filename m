From: jmoyer@redhat.com
Subject: Re: sasl plugin compilation failure
Date: Mon, 07 May 2007 08:25:36 -0400
Message-ID: <m3irb4x1kv.fsf@redhat.com>
References: <44EC6AC2.3050503@inria.fr>
	<x49bqh1inrp.fsf@segfault.boston.devel.redhat.com>
	<20070504210921.GD16190@cornholio.qualcomm.com>
	<x49abwkguch.fsf@segfault.boston.devel.redhat.com>
	<20070505001644.GG16190@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070505001644.GG16190@cornholio.qualcomm.com> (Mike Marion's
	message of "Fri, 4 May 2007 17:16:44 -0700")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Mike Marion <mmarion@qualcomm.com>

==> Regarding Re: [autofs] sasl plugin compilation failure; Mike Marion <mmarion@qualcomm.com> adds:

mmarion> On Fri, May 04, 2007 at 05:19:26PM -0400, Jeff Moyer wrote:
>> Hmm, can you add a: #include <krb5.h>
>> 
>> to include/lookup_ldap.h ?

mmarion> Yep.. that did it.  Compiles and links against libsasl2.so now.

Ian, it seems we need this patch.  I have no idea how things build without
it!  Additionally, we should add some configure magic to check for the krb5
development libraries.

-Jeff

diff --git a/include/lookup_ldap.h b/include/lookup_ldap.h
index d33bda9..571c8fe 100644
--- a/include/lookup_ldap.h
+++ b/include/lookup_ldap.h
@@ -5,6 +5,7 @@
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
 #include <openssl/err.h>
+#include <krb5.h>
 #include <sasl/sasl.h>
 #include <libxml/tree.h>
 #endif
