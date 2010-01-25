From: "Philip Ong Jr." <pongjr@gmail.com>
Subject: Re: problem installing 5.0.5
Date: Mon, 25 Jan 2010 15:40:25 -0800
Message-ID: <4B5E2BE9.8020701@gmail.com>
References: <4B5958A8.2050308@gmail.com> <4B5D0FF1.1010701@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from
	:user-agent:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding;
	bh=0E2KATZderZOiiXd1qXxzjzhXn9tKyLhPOLcZ/8OIG8=;
	b=CAksv1hEor6nvNtxx4NPnzrv19t4veJf8TO4t/EKULixqwuN5PZQgRinueXtwgRHyM
	EW8M05d9QdXPJcx6apGOhrFFM+knoas4RxB2qmoqeAquZa+EhwuV8xQaUIYERHbbTNm5
	hxWnbr/DKPwLndXVIRqRzLon/RQ+mK3so/XfU=
In-Reply-To: <4B5D0FF1.1010701@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

I applied the patches starting from top to down...and now receiving 
error messages pertaining to conditional statements.

patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-included-map-read-fail-handling.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-refactor-ldap-sasl-bind.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.4-add-mount-wait-parameter.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-special-case-cifs-escapes.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-libxml2-workaround-configure.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-more-code-analysis-corrections.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-backwards-ifndef-INET6.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-stale-init-for-file-map-instance.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-ext4-fsck-at-mount.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-dont-use-master_lex_destroy-to-clear-parse-buffer.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-make-documentation-for-set-log-priority-clearer.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-timeout-in-connect_nb.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-pidof-init-script-usage.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-check-for-path-mount-location-in-generic-module.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-dont-fail-mount-on-access-fail.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-rpc-large-export-list.patch
patch -p1 < 
/usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-memory-leak-on-reload.patch

# ./configure --disable-mount-locking --enable-ignore-busy

# DEBUG=1 make

gcc -g -lpthread -rdynamic -pie -o automount automount.o indirect.o 
direct.o spawn.o module.o mount.o lookup.o state.o flag.o 
../lib/autofs.a -ldl -lxml2 -lz -lpthread -lm
: automount
make[1]: Leaving directory `/usr/src/autofs-5.0.5/daemon'
make[1]: Entering directory `/usr/src/autofs-5.0.5/modules'
Makefile:75: Extraneous text after `else' directive
Makefile:80: Extraneous text after `else' directive
Makefile:80: *** only one `else' per conditional.  Stop.
make[1]: Leaving directory `/usr/src/autofs-5.0.5/modules'
make: *** [daemon] Error 2

Thoughts?


Ian Kent wrote:
> On 01/22/2010 03:50 PM, Philip Ong Jr. wrote:
>   
>> When installing 5.0.5 on a Centos 4u5 system with kernel.org 2.6.29.4, i
>> receive a daemon error.
>>
>> Here are the last couple of lines...
>>
>> # DEBUG=1 make
>> gcc -g -Wall -DDEBUG -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE
>> -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
>> -DAUTOFS_MAP_DIR=\"/etc\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\"
>> -DAUTOFS_FIFO_DIR=\"/var/run\" -DAUTOFS_FLAG_DIR=\"/var/run\"
>> -DVERSION_STRING=\"5.0.5\" -I/usr/include/libxml2 -c state.c
>> gcc -g -Wall -DDEBUG -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE
>> -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
>> -DAUTOFS_MAP_DIR=\"/etc\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\"
>> -DAUTOFS_FIFO_DIR=\"/var/run\" -DAUTOFS_FLAG_DIR=\"/var/run\"
>> -DVERSION_STRING=\"5.0.5\" -I/usr/include/libxml2 -c flag.c
>> gcc -g -lpthread -rdynamic -pie -o automount automount.o indirect.o
>> direct.o spawn.o module.o mount.o lookup.o state.o flag.o
>> ../lib/autofs.a -ldl -lxml2 -lz -lpthread -lm
>> ../lib/autofs.a(master_tok.o)(.text+0x1b45): In function
>> `master_set_scan_buffer':
>> /usr/src/autofs-5.0.5/lib/master_tok.l:417: undefined reference to
>> `master_lex_destroy'
>> collect2: ld returned 1 exit status
>> make[1]: *** [automount] Error 1
>> make[1]: Leaving directory `/usr/src/autofs-5.0.5/daemon'
>> make: *** [daemon] Error 2
>>     
>
> You need to check on kernel.org for patch updates.
> This was resolved with patch
> autofs-5.0.5-dont-use-master_lex_destroy-to-clear-parse-buffer.patch
>
> Since the patch changes the CHANGELOG file and there are several other
> patches before it in patch_order-5.0.5 you will get a rejection unless
> you also apply the previous patches. I recommend applying all the
> current 5.0.5 patches (as you would expect).
>
> Ian
>
>   
