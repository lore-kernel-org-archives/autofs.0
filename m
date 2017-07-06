From: Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: [PATCH v3] use pkg-config to search for libtirpc to fix
 cross-compilation
Date: Thu, 6 Jul 2017 23:09:47 +0200
Message-ID: <20170706210947.GG2081@waldemar-brodkorb.de>
References: <20170630085439.GA14206@waldemar-brodkorb.de>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630085439.GA14206@waldemar-brodkorb.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org, Ian Kent <raven@themaw.net>

Hi,

friendly ping?

> When trying to cross-compile autofs for example with a buildsystem
> like buildroot, the compilation fails in case the user wants to use
> libtirpc library as RPC implementation. A hard coded include path
> in aclocal.m4 is used. Other opensource software like rpcbind or
> nfs-utils are suing autotools pkgconfig infrastructure to find
> the libtirpc headers and to pass the correct linker flags.
> 
> Convert configure.in to use PKG_CHECK_MODULES and remove the
> hand written autoconf macros from aclocal.m4. Move aclocal.m4
> to m4 directory, so that autoconf does not skip global
> directories, otherwise pkg.m4 (pkg-config macros) are not found.
> 
> This fixes cross-compilation of autofs and allows to use
> alternative C libraries as uClibc-ng without internal RPC
> support to be used in cross-compiling environments.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
