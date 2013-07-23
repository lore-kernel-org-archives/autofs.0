From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 4/6] fix no "libxml/tree.h" error in modules lookup_ldap.c
Date: Tue, 23 Jul 2013 18:49:49 +0800
Message-ID: <CAF1ZMEcAL53CznpLPoBGfmsUeLTXWU2XuG+Xm_spZ3G3zro4eg@mail.gmail.com>
References: <dennis.yxun@gmail.com>
	<1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	<1374505194-22668-5-git-send-email-dennis.yxun@gmail.com>
	<1374574658.3418.7.camel@perseus.fritz.box>
	<CAF1ZMEf1MjadEB-5aA6CUZ=tCREUqB4RLUsE3bHueOw_qKbQGQ@mail.gmail.com>
	<1374576170.3418.16.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OW9HJLky0g4oNy+Zog+AvSp9KPOFo7m918Fxlg1vIRo=;
        b=jYuthSnfcWkiayc4VHXgEYfCJaaV93HWZVvol2E5yXyZci+ND/v7MQl5+gzBa6TQcE
         SIS6/BH6tKdhQiv/1OX8et1a1Ol9+HpQ7ePI6GSHr2pDBNRRBSw6kmGu8kzlVsHCYqlK
         YP4oGMBWIW0Q9mLU2hTZ0QlJjE+6tlpTxaDHNOTjdDyAdKaGFUTyKAcSIiAgbGHwUNwH
         sfddjAfkV2/l6f2Et5M3Whwb6+XHtx6hIPvBeB29l/c7vPt3DF3x6WJ4RlQeH1xi502h
         2w8Z1EA1kaO4iO2qkle3h9poMmbAXlBN10yKcgKN/TE3xgNOPYyS3jp3gpPuIndt+UJI
         aYpQ==
In-Reply-To: <1374576170.3418.16.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

On Tue, Jul 23, 2013 at 6:42 PM, Ian Kent <raven@themaw.net> wrote:
> On Tue, 2013-07-23 at 18:37 +0800, Dennis Lan (dlan) wrote:
>> On Tue, Jul 23, 2013 at 6:17 PM, Ian Kent <raven@themaw.net> wrote:
>> > On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
>> >> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
>> >>
>> >> make "libxml/tree.h" controlled by WITH_SASL, also move it beind line of
>> >> #include "automount.h", since WITH_SASL is defined in config.h which is
>> >> included by automout.h
>> >
>> > Same again, WITH_LDAP defined and WITH_SASL not.
>> > I agree there appears to be a problem but not sure what to do about it.
>> >
>> >>
>> >> ---
>> >> Gentoo Bugs:
>> >>  https://bugs.gentoo.org/show_bug.cgi?id=468606
>> >>
>> >> gcc -shared -O2 -pipe -march=core2  -D_REENTRANT -D_FILE_OFFSET_BITS=64 -D_REENTRANT
>> >> -D_FILE_OFFSET_BITS=
>> >> 64 -I../include -I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib64/autofs\"
>> >> -DAUTOFS_MAP_DIR=\"/e
>> >> tc/autofs\" -DLDAP_DEPRECATED=1 -o lookup_ldap.so \
>> >>         lookup_ldap.c dclist.o base64.o  \
>> >>         ../lib/autofs.a -lldap -llber -lresolv
>> >> : lookup_yp.so
>> >> lookup_ldap.c:31:25: fatal error: libxml/tree.h: No such file or directory
>> >>  #include <libxml/tree.h>
>> >>                          ^
>> >> compilation terminated.
>> >>
>> >> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
>> >> ---
>> >>  modules/lookup_ldap.c | 5 ++++-
>> >>  1 file changed, 4 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
>> >> index b8970a6..fad558d 100644
>> >> --- a/modules/lookup_ldap.c
>> >> +++ b/modules/lookup_ldap.c
>> >> @@ -28,7 +28,6 @@
>> >>  #include <arpa/nameser.h>
>> >>  #include <resolv.h>
>> >>  #include <lber.h>
>> >> -#include <libxml/tree.h>
>> >>
>> >>  #define MODULE_LOOKUP
>> >>  #include "automount.h"
>> >> @@ -36,6 +35,10 @@
>> >>  #include "lookup_ldap.h"
>> >>  #include "base64.h"
>> >>
>> >> +#ifdef WITH_SASL
>> >> +#include <libxml/tree.h>
>> >> +#endif
>> >> +
>> >>  #define MAPFMT_DEFAULT "sun"
>> >>
>> >>  #define MODPREFIX "lookup(ldap): "
>> >
>> >
>> HI Ian:
>>    I haven't dig too much into the code.
>>    As far as I know (could be wrong).. LDAP SASL auth needs libxml?
>>
>> quote from configure.in (line 170)
>>
>>  # LDAP SASL auth needs libxml and Kerberos
>>  AF_CHECK_LIBXML()
>>  AF_CHECK_KRB5()
>>
>> so libxml could be controlled by SASL, but not LDAP, right?
>> (Btw, SASL require LDAP enabled)
>
> That's what occurred to me but, after a quick look, I'm thinking the xml
> config still needs to be read. That's why I agree there's a problem that
> needs fixing.
>
> I'll have to look at it along with that old Gentoo ldap patch I want to
> commit.
>
>>
Hi Ian:
   Good, if you have any progress, let me know ;_)
   Thanks

>> Dennis
>> --
>> To unsubscribe from this list: send the line "unsubscribe autofs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
