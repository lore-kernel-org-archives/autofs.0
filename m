From: Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: [PATCH v2] use pkg-config to search for libtirpc to fix
 cross-compilation
Date: Thu, 29 Jun 2017 11:08:14 +0200
Message-ID: <20170629090814.GD26922@waldemar-brodkorb.de>
References: <20170628102950.GA7247@waldemar-brodkorb.de>
 <1498694049.2734.0.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498694049.2734.0.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: Waldemar Brodkorb <wbx@openadk.org>, autofs@vger.kernel.org

Hi,
Ian Kent wrote,

> On Wed, 2017-06-28 at 12:29 +0200, Waldemar Brodkorb wrote:
> > When trying to cross-compile autofs for example with a buildsystem
> > like buildroot, the compilation fails in case the user wants to use
> > libtirpc library as RPC implementation. A hard coded include path
> > in aclocal.m4 is used. Other opensource software like rpcbind or
> > nfs-utils are suing autotools pkgconfig infrastructure to find
> > the libtirpc headers and to pass the correct linker flags.
> > 
> > Convert configure.in to use PKG_CHECK_MODULES and remove the
> > hand written autoconf macros from aclocal.m4.
> > 
> > To autoreconf the package you need pkg-config or pkgconf installed,
> > which provides the needed autoconf macros in pkg.m4. For an
> > non-automake project a full path to pkg.m4 is required.
> > 
> > This fixes cross-compilation of autofs and allows to use
> > alternative C libraries as uClibc-ng without internal RPC
> > support to be used in cross-compiling environments.
> > 
> > Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> > ---
> > v1 -> v2:
> >   - add a better commit decription
> >   - add back missing TIRPC_WORKAROUND/WITH_LIBTIRPC defines
> >   - add back AC_CHECK_FUNCS([getrpcbyname getservbyname])
> > 
> > For autoheader/autoconf to generate configure/config.h you
> > need to have pkg-config installed on your development machine.
> > When the user does not have installed pkg-config later, he
> > can use autofs without libtirpc as before. 
> > Configure will fail when the user use --with-libtirpc and
> > pkg-config is not installed.
> 
> Thanks for this, I'll have a look through it.
> 
> > +# for pkg-config macros
> > +m4_include([/usr/share/aclocal/pkg.m4])
> > +

Yann (Buildroot developer) found out, that this include
can be avoided when the aclocal.m4 would be moved.
It seems autoconf does not search for macros in any
global directories, if this file is in the current
directory found.

Add this to configure.in: AC_CONFIG_MACRO_DIR([m4])
mkdir m4
git mv aclocal.m4 m4/autofs-macros.m4

Should I update the patch, according to this?

best regards
 Waldemar
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
