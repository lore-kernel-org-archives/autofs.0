From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: sasl plugin compilation failure
Date: Thu, 03 May 2007 17:46:18 -0400
Message-ID: <x49bqh1inrp.fsf@segfault.boston.devel.redhat.com>
References: <44EC6AC2.3050503@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44EC6AC2.3050503@inria.fr> (Guillaume Rousse's message of "Wed,
	23 Aug 2006 16:48:34 +0200")
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

==> On Wed, 23 Aug 2006 16:48:34 +0200, Guillaume Rousse <Guillaume.Rousse@inria.fr> said:

Guillaume> gcc -shared -Xlinker -rpath -Xlinker /usr/lib64/autofs -O2
Guillaume> -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -DDONTSTRIP
Guillaume> -D_REENTRANT -D_REENTRANT -I../include -I../lib -fPIC
Guillaume> -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib64/autofs\"
Guillaume> -DAUTOFS_MAP_DIR=\"/etc/autofs\" -o mount_nfs.so \
Guillaume> mount_nfs.c replicated.o ../lib/autofs.a -lnsl In file
Guillaume> included from cyrus-sasl.c:59: ../include/lookup_ldap.h:41:
Guillaume> error: expected specifier-qualifier-list before
Guillaume> 'krb5_principal'

Guillaume> I had to disable sasl explicitely. I'm using gcc 4.1.1.  --
Guillaume> Guillaume Rousse Projet Estime, INRIA Domaine de Voluceau
Guillaume> Rocquencourt - B.P. 105 78153 Le Chesnay Cedex - France

Do you have krb5 development libraries installed?

-Jeff
