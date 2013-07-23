From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 4/6] fix no "libxml/tree.h" error in modules
 lookup_ldap.c
Date: Tue, 23 Jul 2013 18:42:50 +0800
Message-ID: <1374576170.3418.16.camel@perseus.fritz.box>
References: <dennis.yxun@gmail.com>
	 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	 <1374505194-22668-5-git-send-email-dennis.yxun@gmail.com>
	 <1374574658.3418.7.camel@perseus.fritz.box>
	 <CAF1ZMEf1MjadEB-5aA6CUZ=tCREUqB4RLUsE3bHueOw_qKbQGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=jUjxoRVzJBFiRz2R4W7+T2YrMD0=; b=oU9ajoU/cGBFg0GF/s0DRavEn3QW
	YfYyUOy7KY13i6B1UZX5vOOp8xC+sMU42k08HxVuyvgM7gufcNzodX3ZVA9AyT1u
	PB5bkpsQ6KBG7/gs4/3dIewbcATIYBRNX+MdNJXq7uvNJGjVBt60U59ueN5x5pvL
	lLvimhMeZ19P2HY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=jUjxoRVzJBFiRz2R4W7+T2
	YrMD0=; b=qlkM9N8lm62UCaZe16S8pdLXmYwoSRAKNvY9/h9e98NbVnCjP6l70n
	KweaSSM2PGqJCbnZyTexjUphUzJNv8jx7d0Epp29aITKqX7ngz9nwKN/bCe8uMsa
	yRnQl1oL+vOEIr1lJ9RBBryRU5Tv9wbA4I1jxWVHRjOVQxG3bl9aQ=
In-Reply-To: <CAF1ZMEf1MjadEB-5aA6CUZ=tCREUqB4RLUsE3bHueOw_qKbQGQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Tue, 2013-07-23 at 18:37 +0800, Dennis Lan (dlan) wrote:
> On Tue, Jul 23, 2013 at 6:17 PM, Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
> >> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> >>
> >> make "libxml/tree.h" controlled by WITH_SASL, also move it beind line of
> >> #include "automount.h", since WITH_SASL is defined in config.h which is
> >> included by automout.h
> >
> > Same again, WITH_LDAP defined and WITH_SASL not.
> > I agree there appears to be a problem but not sure what to do about it.
> >
> >>
> >> ---
> >> Gentoo Bugs:
> >>  https://bugs.gentoo.org/show_bug.cgi?id=468606
> >>
> >> gcc -shared -O2 -pipe -march=core2  -D_REENTRANT -D_FILE_OFFSET_BITS=64 -D_REENTRANT
> >> -D_FILE_OFFSET_BITS=
> >> 64 -I../include -I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib64/autofs\"
> >> -DAUTOFS_MAP_DIR=\"/e
> >> tc/autofs\" -DLDAP_DEPRECATED=1 -o lookup_ldap.so \
> >>         lookup_ldap.c dclist.o base64.o  \
> >>         ../lib/autofs.a -lldap -llber -lresolv
> >> : lookup_yp.so
> >> lookup_ldap.c:31:25: fatal error: libxml/tree.h: No such file or directory
> >>  #include <libxml/tree.h>
> >>                          ^
> >> compilation terminated.
> >>
> >> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> >> ---
> >>  modules/lookup_ldap.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
> >> index b8970a6..fad558d 100644
> >> --- a/modules/lookup_ldap.c
> >> +++ b/modules/lookup_ldap.c
> >> @@ -28,7 +28,6 @@
> >>  #include <arpa/nameser.h>
> >>  #include <resolv.h>
> >>  #include <lber.h>
> >> -#include <libxml/tree.h>
> >>
> >>  #define MODULE_LOOKUP
> >>  #include "automount.h"
> >> @@ -36,6 +35,10 @@
> >>  #include "lookup_ldap.h"
> >>  #include "base64.h"
> >>
> >> +#ifdef WITH_SASL
> >> +#include <libxml/tree.h>
> >> +#endif
> >> +
> >>  #define MAPFMT_DEFAULT "sun"
> >>
> >>  #define MODPREFIX "lookup(ldap): "
> >
> >
> HI Ian:
>    I haven't dig too much into the code.
>    As far as I know (could be wrong).. LDAP SASL auth needs libxml?
> 
> quote from configure.in (line 170)
> 
>  # LDAP SASL auth needs libxml and Kerberos
>  AF_CHECK_LIBXML()
>  AF_CHECK_KRB5()
> 
> so libxml could be controlled by SASL, but not LDAP, right?
> (Btw, SASL require LDAP enabled)

That's what occurred to me but, after a quick look, I'm thinking the xml
config still needs to be read. That's why I agree there's a problem that
needs fixing.

I'll have to look at it along with that old Gentoo ldap patch I want to
commit.

> 
> Dennis
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


