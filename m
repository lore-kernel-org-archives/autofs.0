From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: sasl plugin compilation failure
Date: Wed, 23 Aug 2006 16:48:34 +0200
Message-ID: <44EC6AC2.3050503@inria.fr>
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

gcc -shared -Xlinker -rpath -Xlinker /usr/lib64/autofs -O2 -g -pipe
-Wp,-D_FORTIFY_SOURCE=2 -fexceptions -DDONTSTRIP -D_REENTRANT
-D_REENTRANT -I../include -I../lib -fPIC -D_GNU_SOURCE
-DAUTOFS_LIB_DIR=\"/usr/lib64/autofs\" -DAUTOFS_MAP_DIR=\"/etc/autofs\"
-o mount_nfs.so \
        mount_nfs.c replicated.o ../lib/autofs.a -lnsl
In file included from cyrus-sasl.c:59:
../include/lookup_ldap.h:41: error: expected specifier-qualifier-list
before 'krb5_principal'

I had to disable sasl explicitely. I'm using gcc 4.1.1.
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
