From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v2] use pkg-config to search for libtirpc to fix
 cross-compilation
Date: Thu, 29 Jun 2017 21:15:00 +0800
Message-ID: <1498742100.2734.6.camel@themaw.net>
References: <20170628102950.GA7247@waldemar-brodkorb.de>
         <1498694049.2734.0.camel@themaw.net>
         <20170629090814.GD26922@waldemar-brodkorb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=QNgCKztifzkhrMQ2Op
        dKHgxOfEaivsGwWQ6d/G53qfk=; b=VelaH6NuJzjHP5/P8r5kNnn1puUnQCR7qP
        qGAXfn13XtSc/X0wXxC8OataZrAJNQJ+3U41o2A5bADI/QLhZAUPsCh9WUW2nHhH
        pADMB6YzJ6tZ8yyPFFKYFqu346c0lxOtltuZcG4+LvSqs5fwPezPQwYRz6YPFlCu
        Qdl1UncQo8cQI04o1xxMpfmcuuUT9I7+6e2GdZnUndA4VdxUNGxzXeI7bksjDk/q
        nIHT6Oy22whpYR31zqQIlWOKGLnl1DdXZdaBiVAHbfNsQvlU3whNHP2NuNhxNhAp
        Y0eG3R08T+84T1oiQeuOPffCAz1WwmXmqy9wU1trDHNwyy4Qd84Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=QNgCKztifzkhrMQ2OpdKHgxOfEaivsGwWQ6d/G53qfk=; b=YtqvcLDf
        JXnRFK1JmShy6hq5Y+d849UppHtEERCrA/59wfg/o7Y6q/uyxc6KF/a6Mty2zIny
        5lYLL0505g27XiQABOh5gv0NLa6lWzbTQiLw88UUOq+/tzBwnUujgCLVyGVe2b9l
        49gdqOHCU2I04btnq2pSMlkPTAHKZgqyfxps6wNyZOGdu5kaLUzV504VtUnM+f1a
        yloqt9pXu6ysCsaZ6xydtYssZxfCTJQqhrBoaVptLERioS+bNsnz+KKQHRWH53Ea
        WSTJS/HUCBp9tlcdjj8e9vqxsdp4cnixr/wOROyW1QJCVPj9yv9JiSihSa26S66b
        aJP09bS6y2CATg==
In-Reply-To: <20170629090814.GD26922@waldemar-brodkorb.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: autofs@vger.kernel.org

On Thu, 2017-06-29 at 11:08 +0200, Waldemar Brodkorb wrote:
> Hi,
> Ian Kent wrote,
> 
> > On Wed, 2017-06-28 at 12:29 +0200, Waldemar Brodkorb wrote:
> > > When trying to cross-compile autofs for example with a buildsystem
> > > like buildroot, the compilation fails in case the user wants to use
> > > libtirpc library as RPC implementation. A hard coded include path
> > > in aclocal.m4 is used. Other opensource software like rpcbind or
> > > nfs-utils are suing autotools pkgconfig infrastructure to find
> > > the libtirpc headers and to pass the correct linker flags.
> > > 
> > > Convert configure.in to use PKG_CHECK_MODULES and remove the
> > > hand written autoconf macros from aclocal.m4.
> > > 
> > > To autoreconf the package you need pkg-config or pkgconf installed,
> > > which provides the needed autoconf macros in pkg.m4. For an
> > > non-automake project a full path to pkg.m4 is required.
> > > 
> > > This fixes cross-compilation of autofs and allows to use
> > > alternative C libraries as uClibc-ng without internal RPC
> > > support to be used in cross-compiling environments.
> > > 
> > > Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> > > ---
> > > v1 -> v2:
> > >   - add a better commit decription
> > >   - add back missing TIRPC_WORKAROUND/WITH_LIBTIRPC defines
> > >   - add back AC_CHECK_FUNCS([getrpcbyname getservbyname])
> > > 
> > > For autoheader/autoconf to generate configure/config.h you
> > > need to have pkg-config installed on your development machine.
> > > When the user does not have installed pkg-config later, he
> > > can use autofs without libtirpc as before. 
> > > Configure will fail when the user use --with-libtirpc and
> > > pkg-config is not installed.
> > 
> > Thanks for this, I'll have a look through it.
> > 
> > > +# for pkg-config macros
> > > +m4_include([/usr/share/aclocal/pkg.m4])
> > > +
> 
> Yann (Buildroot developer) found out, that this include
> can be avoided when the aclocal.m4 would be moved.
> It seems autoconf does not search for macros in any
> global directories, if this file is in the current
> directory found.

Yes, I was wondering if there was a way to avoid the full path.

> 
> Add this to configure.in: AC_CONFIG_MACRO_DIR([m4])
> mkdir m4
> git mv aclocal.m4 m4/autofs-macros.m4
> 
> Should I update the patch, according to this?

You could, to save me a bit of time, I won't get to it until tomorrow (my time).

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
