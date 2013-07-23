From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 4/6] fix no "libxml/tree.h" error in modules lookup_ldap.c
Date: Tue, 23 Jul 2013 18:37:21 +0800
Message-ID: <CAF1ZMEf1MjadEB-5aA6CUZ=tCREUqB4RLUsE3bHueOw_qKbQGQ@mail.gmail.com>
References: <dennis.yxun@gmail.com>
	<1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	<1374505194-22668-5-git-send-email-dennis.yxun@gmail.com>
	<1374574658.3418.7.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jE9zBBNa6R2KSQFpVgmGEUY1A3AbFSYAiIQg3DQsYWs=;
        b=sVFWFrmYzG5rcTfHQIHJVFX+fIDZnxr+rORG+4GaifMDMR8/gtkIKqXgXrV3Si7W6q
         lvP9hpAPxzWqCGpIyvvoB2050mXe/5YGjn5BB0peCivp35mVb1+G1rBiG9xLzjlysojZ
         hy4HzUlc60InfpjKwGDh8wrAKDSuYp+a405tRQUnS16hIw93PTkTx9KDR45aix41KDlT
         fc7jpbgFyz2CdJ6RyMfaTCAy0wk9WP8mIbCcln6hmH/SBWpej3s+bzymNMoqNqST5Zrp
         4xd4LL83+Xlptw7kLLW547MXLHKMI75/v0+c8LLUcWyXKDomjPMRGj9pWjpnWBgcYXN0
         byDA==
In-Reply-To: <1374574658.3418.7.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

On Tue, Jul 23, 2013 at 6:17 PM, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
>> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
>>
>> make "libxml/tree.h" controlled by WITH_SASL, also move it beind line of
>> #include "automount.h", since WITH_SASL is defined in config.h which is
>> included by automout.h
>
> Same again, WITH_LDAP defined and WITH_SASL not.
> I agree there appears to be a problem but not sure what to do about it.
>
>>
>> ---
>> Gentoo Bugs:
>>  https://bugs.gentoo.org/show_bug.cgi?id=468606
>>
>> gcc -shared -O2 -pipe -march=core2  -D_REENTRANT -D_FILE_OFFSET_BITS=64 -D_REENTRANT
>> -D_FILE_OFFSET_BITS=
>> 64 -I../include -I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib64/autofs\"
>> -DAUTOFS_MAP_DIR=\"/e
>> tc/autofs\" -DLDAP_DEPRECATED=1 -o lookup_ldap.so \
>>         lookup_ldap.c dclist.o base64.o  \
>>         ../lib/autofs.a -lldap -llber -lresolv
>> : lookup_yp.so
>> lookup_ldap.c:31:25: fatal error: libxml/tree.h: No such file or directory
>>  #include <libxml/tree.h>
>>                          ^
>> compilation terminated.
>>
>> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
>> ---
>>  modules/lookup_ldap.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
>> index b8970a6..fad558d 100644
>> --- a/modules/lookup_ldap.c
>> +++ b/modules/lookup_ldap.c
>> @@ -28,7 +28,6 @@
>>  #include <arpa/nameser.h>
>>  #include <resolv.h>
>>  #include <lber.h>
>> -#include <libxml/tree.h>
>>
>>  #define MODULE_LOOKUP
>>  #include "automount.h"
>> @@ -36,6 +35,10 @@
>>  #include "lookup_ldap.h"
>>  #include "base64.h"
>>
>> +#ifdef WITH_SASL
>> +#include <libxml/tree.h>
>> +#endif
>> +
>>  #define MAPFMT_DEFAULT "sun"
>>
>>  #define MODPREFIX "lookup(ldap): "
>
>
HI Ian:
   I haven't dig too much into the code.
   As far as I know (could be wrong).. LDAP SASL auth needs libxml?

quote from configure.in (line 170)

 # LDAP SASL auth needs libxml and Kerberos
 AF_CHECK_LIBXML()
 AF_CHECK_KRB5()

so libxml could be controlled by SASL, but not LDAP, right?
(Btw, SASL require LDAP enabled)

Dennis
