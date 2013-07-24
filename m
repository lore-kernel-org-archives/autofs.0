From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH] fix hesiod check error, use correct $(LIBS)
Date: Wed, 24 Jul 2013 10:24:59 +0800
Message-ID: <CAF1ZMEfh2VYE5EN5gLNjrWKVJe6gNDMNPYhMW1zBa8vsrHjn2A@mail.gmail.com>
References: <1374595177-24485-1-git-send-email-dennis.yxun@gmail.com>
	<1374632204.2358.20.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=56p8gWl1y507JCFQdilWzjg8TeXF9B5IMCrhFYO5PWM=;
        b=E+eRMK84Kes5RbIk1PHmhoNq3e89k2M6hmXhRX3+/GCeKDH70Sa6+TI9MDT3MU3sJP
         jy6VuFvDy8Y49qQR9bZhO73RrDfIHRwbwafHhOkx149SR9BOlwo7E3aIvAI61dSnxtto
         6U7TDN47fye1UBk90vCSvgaOEHEEKAzc1Kj2+Z0y9UKRzrg4Ta3xrulQuRKOjP+QnjYE
         0N+CtfWTfDOL99JCv0EULZyUM9mMApruHqX4V4A0WsvzNNMmVaCvFVT90m5kaXniohUq
         xPshoep7zB6v89SARnn6q9aFlRdcDQ4O/hIuGKnTe6zIkG9/GqwWtW12p60MhnKGPI1m
         3xHA==
In-Reply-To: <1374632204.2358.20.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

On Wed, Jul 24, 2013 at 10:16 AM, Ian Kent <raven@themaw.net> wrote:
> On Tue, 2013-07-23 at 23:59 +0800, Lan Yixun (dlan) wrote:
>> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
>>
>> the problem here is that hesiod checking always fail due to wrong $(=
LDFLAGS),
>> no matter hesiod library is installed or not. moving "-lhesiod" into
>> $(LIBS) solve this problem.
>>
>> 1) convert "char *" -> "void *" to fix the compile warning
>> 2) put "-lhesiod -lresolv" into $(LIBS), not into $(LDFLAGS), otherw=
ise we got link error
>
> Right, on the queue, will push to the repo next time I commit.
> Thanks
> Ian
>
>>
>> ---
>> tst_hesiod.c: In function =E2=80=98main=E2=80=99:
>> tst_hesiod.c:38:3: warning: passing argument 1 of =E2=80=98hesiod_in=
it=E2=80=99 from incompatible pointer type
>> [enabled by default]
>>    char *c; hesiod_init(&c);
>>    ^
>> In file included from tst_hesiod.c:34:0:
>> /usr/include/hesiod.h:36:5: note: expected =E2=80=98void **=E2=80=99=
 but argument is of type =E2=80=98char **=E2=80=99
>>  int hesiod_init(void **context);
>>
>>
>>
>> $ x86_64-pc-linux-gnu-gcc -o conftest -O2 -pipe -march=3Dcore2  -I/u=
sr/include
>>  -Wl,-O1 -Wl,--as-needed -g -lhesiod -lresolv tst_hesiod.c -L/usr/li=
b64
>>  -lkrb5 -lhx509 -lcom_err -lhcrypto -lasn1 -lwind -lheimbase -lroken
>> -lcrypt -ldl -lresolv
>>
>> /tmp/ccN6GW0r.o: In function `main':
>> /root/tst_hesiod.c:38: undefined reference to `hesiod_init'
>> collect2: error: ld returned 1 exit status
>>
>> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
>> ---
>>  aclocal.m4 | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/aclocal.m4 b/aclocal.m4
>> index 7a8b03c..637a775 100644
>> --- a/aclocal.m4
>> +++ b/aclocal.m4
>> @@ -316,20 +316,20 @@ dnl ------------------------------------------=
--------------------------------
>>  AC_DEFUN([AF_CHECK_LIBHESIOD],
>>  [AC_MSG_CHECKING(for libhesiod)
>>
>> -# save current ldflags
>> -af_check_hesiod_save_ldflags=3D"$LDFLAGS"
>> -LDFLAGS=3D"$LDFLAGS -lhesiod -lresolv"
>> +# save current libs
>> +af_check_hesiod_save_libs=3D"$LIBS"
>> +LIBS=3D"$LIBS -lhesiod -lresolv"
>>
>>  AC_TRY_LINK(
>>    [ #include <hesiod.h> ],
>> -  [ char *c; hesiod_init(&c); ],
>> +  [ void *c; hesiod_init(&c); ],
>>    [ HAVE_HESIOD=3D1
>>      LIBHESIOD=3D"$LIBHESIOD -lhesiod -lresolv"
>>      AC_MSG_RESULT(yes) ],
>>    [ AC_MSG_RESULT(no) ])
>>
>> -# restore ldflags
>> -LDFLAGS=3D"$af_check_hesiod_save_ldflags"
>> +# restore libs
>> +LIBS=3D"$af_check_hesiod_save_libs"
>>  ])
>>
>>  dnl ---------------------------------------------------------------=
-----------
>
>
Hi Ian:
 Great! Thanks.

Dennis Lan (dlan)
