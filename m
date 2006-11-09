From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs4 patch] Define LDAP_DEPRECATED in the build
Date: Thu, 09 Nov 2006 10:35:09 +0800
Message-ID: <1163039709.3337.8.camel@localhost>
References: <x498xilpf2d.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x498xilpf2d.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Wed, 2006-11-08 at 20:46 -0500, Jeff Moyer wrote:
> Without this, newer 64 bit installs will have problems with the
> sources (since return codes default to int's).

A patch to add this to the LDAP_FLAGS var has already been added to the
4.1 tree.

[raven@raven autofs-4.1.4]$ find . -exec grep -Hn LDAP_DEPRECATED {} \;
./configure.in:121:     LDAP_FLAGS="$LDAP_FLAGS -DLDAP_DEPRECATED=1"
./configure:3415:       LDAP_FLAGS="$LDAP_FLAGS -DLDAP_DEPRECATED=1"
[raven@raven autofs-4.1.4]$


> 
> -Jeff
> 
> diff --git a/lib/Makefile b/lib/Makefile
> index a35b208..148828d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -18,7 +18,8 @@ OBJS = cache.o mount_clnt.o mount_xdr.o 
>  LIB = autofs.a
>  NSSWITCH = nsswitch
>  
> -CFLAGS += -I../include -fPIC -D_GNU_SOURCE -DHAVE_TCP_WRAPPER -DNFS3_SUPPORTED
> +CFLAGS += -I../include -fPIC -D_GNU_SOURCE -DHAVE_TCP_WRAPPER \
> +	-DNFS3_SUPPORTED -DLDAP_DEPRECATED
>  
>  .PHONY: all install clean
>  
> diff --git a/modules/Makefile b/modules/Makefile
> index f87721a..e37d980 100644
> --- a/modules/Makefile
> +++ b/modules/Makefile
> @@ -87,7 +87,7 @@ lookup_hesiod.so: lookup_hesiod.c
>  	$(STRIP) lookup_hesiod.so
>  
>  lookup_ldap.so: lookup_ldap.c
> -	$(CC) $(SOLDFLAGS) $(CFLAGS) $(LDAP_FLAGS) -o lookup_ldap.so \
> +	$(CC) $(SOLDFLAGS) $(CFLAGS) $(LDAP_FLAGS) -DLDAP_DEPRECATED -o lookup_ldap.so \
>  		lookup_ldap.c $(AUTOFS_LIB) $(LIBLDAP)
>  	$(STRIP) lookup_ldap.so
>  
> diff --git a/samples/Makefile b/samples/Makefile
> index d69d6e7..029ea9e 100644
> --- a/samples/Makefile
> +++ b/samples/Makefile
> @@ -10,7 +10,7 @@ ifeq ($(LDAP), 1)
>    BINS = autofs-ldap-auto-master
>  endif
>  
> -CFLAGS += -I../include
> +CFLAGS += -I../include -DLDAP_DEPRECATED
>  LIBS = -lldap -llber
>  
>  all: $(BINS) rc.autofs
> 
