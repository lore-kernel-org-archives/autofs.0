From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH] add missing libtirpc lib to mount_nfs.so when TIRPC enabled
Date: Wed, 24 Jul 2013 13:29:46 +0800
Message-ID: <CAF1ZMEdAim2OVXsU0JsbLpE40to+8UMhJDT63=fJAa_99hKVGw@mail.gmail.com>
References: <1374633420-28235-1-git-send-email-dennis.yxun@gmail.com>
	<1374636703.2358.25.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D1s3WBe4Qoe/+lGRUeelQWzYx9TUb6puLjcNSgn5SVU=;
        b=SIcYhZ/wPe2+GvgXUI03MU8Xkydeb411FZpuLO367JKCk98k5uuWz9T825XXnNVOjr
         zoLj5XAaiyG1lcADFYoBTngQfDtDaRKEQoDTmVC7RXcMFunb1WiQUJyCy8kr893z4Of0
         QRLnhavOhsZs9YKwcHsta4FI0gpqxLMxe4134jMUL1CndQYEIe4fwSbAJ9ekQoPo3JMV
         xsjfMHsZM31mZLw587FUq7SyxDxcO7hi73k9DeJNv6vVbLhIFvrvshBNLF7PmX7p0a3n
         489XYCKJAwn/rEy5MTGKmsCtrUuwSl6tfXH7MynKO76g8f5T2x+uOR5kdRTFub2RIj1u
         Pw9w==
In-Reply-To: <1374636703.2358.25.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

On Wed, Jul 24, 2013 at 11:31 AM, Ian Kent <raven@themaw.net> wrote:
> On Wed, 2013-07-24 at 10:37 +0800, Lan Yixun (dlan) wrote:
>> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
>>
>> this is need when libtirpc is enabled, otherwise autofs fail to start
>> due to it can't find symbol clnt_dg_create (which is provided by libtirpc)
>
> Yeah, I use libtirpc all the time but that's something I haven't
> noticed, probably because TIRPC_WORKAROUND will cause the library to be
> dlopen()ed at start.
>
> So while the change is needed and I'll apply it, I'm not sure why you're
> seeing it since the library should be open and loaded already.
>
>>
>> ---
>> autofs error log from /var/log/message:
>>
>> Jul 23 12:11:58 ofire automount[25699]: open_mount:244: parse(sun): cannot open mount module
>> nfs (/usr/lib64/autofs/mount_nfs.so: undefined symbol: clnt_dg_create)
>> Jul 23 12:11:58 ofire automount[25699]: lookup(file): failed to open parse context
>>
>> without this patch, mount_nfs.so fail link to libtirpc.so
>>  # ldd /usr/lib64/autofs/mount_nfs.so |grep tirpc
>>
>> with this patch applied:
>>  # ldd /usr/lib64/autofs/mount_nfs.so |grep tirpc
>>         libtirpc.so.1 => /lib64/libtirpc.so.1 (0x00007f7d94920000)
>>
>> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
>> ---
>>  modules/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/modules/Makefile b/modules/Makefile
>> index 4bb1096..0fe8ae8 100644
>> --- a/modules/Makefile
>> +++ b/modules/Makefile
>> @@ -116,6 +116,6 @@ lookup_ldap.so: lookup_ldap.c dclist.o base64.o $(SASL_OBJ)
>>
>>  mount_nfs.so: mount_nfs.c replicated.o
>>       $(CC) $(SOLDFLAGS) $(CFLAGS) -o mount_nfs.so \
>> -             mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL)
>> +             mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL) $(TIRPCLIB)
>>       $(STRIP) mount_nfs.so
>>
>
>
Hi Ian:
   I  spend a few time dig into the code, and found the root cause.
   In gentoo linux, user are legal to pass customized CFLAGS/LDFLAGS,
and here we append "-Wl,--as-needed" to LDFLAGS.
with this flag append, the final image - "automount" won't link to
library tirpc.
command of "ldd /usr/sbin/automount  |grep tirpc" shows nothing. I
think this is totally fine, since autmount itself doesn't use any
symbol from libtirpc.
  but without my previous patch, the mount_nfs.so don't link to
libtirpc, see following.
 # ldd /usr/lib64/autofs/mount_nfs.so
        linux-vdso.so.1 (0x00007fff4bfff000)
        libnsl.so.1 => /lib64/libnsl.so.1 (0x00007fc55957c000)
        libc.so.6 => /lib64/libc.so.6 (0x00007fc5591d1000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fc559a04000)
 #objdump -t /usr/lib64/autofs/mount_nfs.so |grep clnt_dg_creat
        0000000000000000         *UND*  0000000000000000
clnt_dg_create

you can see clnt_dg_create is a undefined symbol, which is come from libtirpc.
so,  module mount_nfs need libtirpc.

   I think you haven't encounter the problem is that the application
automont accidentally link in libtirpc, while mount_nfs.so doesn't. so
mount_nfs.so can found the symbol which loaded by automount when it
started to run.
   I can filter the "-Wl,--as-needed" flag, but still think my patch
address right to the problem.
   Thanks.

Dennis Lan (dlan)
