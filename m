From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: sasl plugin compilation failure
Date: Thu, 24 Aug 2006 08:44:24 +0200
Message-ID: <44ED4AC8.1070903@inria.fr>
References: <44EC6AC2.3050503@inria.fr>
	<Pine.LNX.4.64.0608241027270.3051@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608241027270.3051@raven.themaw.net>
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
Cc: autofs@linux.kernel.org

Ian Kent a =E9crit :
> On Wed, 23 Aug 2006, Guillaume Rousse wrote:
> =

>> gcc -shared -Xlinker -rpath -Xlinker /usr/lib64/autofs -O2 -g -pipe
>> -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions -DDONTSTRIP -D_REENTRANT
>> -D_REENTRANT -I../include -I../lib -fPIC -D_GNU_SOURCE
>> -DAUTOFS_LIB_DIR=3D\"/usr/lib64/autofs\" -DAUTOFS_MAP_DIR=3D\"/etc/autof=
s\"
>> -o mount_nfs.so \
>>         mount_nfs.c replicated.o ../lib/autofs.a -lnsl
>> In file included from cyrus-sasl.c:59:
>> ../include/lookup_ldap.h:41: error: expected specifier-qualifier-list
>> before 'krb5_principal'
>>
>> I had to disable sasl explicitely. I'm using gcc 4.1.1.
> =

> What version and what patches?
5.0.1, with all patches applied until autofs-5.0.1-rc1-shutdown-races.patch.
