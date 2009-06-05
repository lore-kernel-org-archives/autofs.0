From: Ian Kent <raven@themaw.net>
Subject: Re: 5.0.4 with all patches -> compile error on 64bit
Date: Fri, 05 Jun 2009 10:04:47 +0800
Message-ID: <4A287D3F.70808@themaw.net>
References: <4A278C3B.6050207@math.uni-muenster.de>
	<4A2879A2.9010101@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A2879A2.9010101@themaw.net>
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
To: Nail El-Sourani <sourani@math.uni-muenster.de>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

Ian Kent wrote:
>> ...
>> gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=3D64 -rdynamic -fPIE
>> -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=3D\"/usr/lib/autofs\" =

>> -DAUTOFS_MAP_DIR=3D\"/etc\" -DAUTOFS_CONF_DIR=3D\"/etc/sysconfig\"
>> -DAUTOFS_FIFO_DIR=3D\"/var/run\" -DAUTOFS_FLAG_DIR=3D\"/var/run\"
>> -DVERSION_STRING=3D\"5.0.4\" -c flag.c
>> gcc -s -lpthread -rdynamic -pie -o automount automount.o indirect.o
>> direct.o spawn.o module.o mount.o lookup.o state.o flag.o
>> ../lib/autofs.a -ldl
>> ../lib/autofs.a(master_tok.o): In function `master_set_scan_buffer':
>> master_tok.c:(.text+0x257): undefined reference to `master_lex_destroy'
>> collect2: ld gab 1 als Ende-Status zur=FCck
>> make[1]: *** [automount] Fehler 1
>> make[1]: Leaving directory `/root/Desktop/autofs-5.0.4/daemon'
>> make: *** [daemon] Fehler 2
>>
>>
>> (these are the last few lines)
>>
>> i am suspecting a problem with 64bit but then again, what do i know...
>> this is a centos5.3 64bit machine
> =

> OK I'll fix that.
> I think it's the Lexx version what is too old.

But then again maybe not, the flex version is just to old, I'm not sure
that the bleeding edge upstream source should make compromises for older
flex versions. The function master_lex_destroy() (actually yy... since
this is a multiple parser lexer) does more than just clear the user
parse buffer, and the 5.0.4 patch does a couple of other things as well.

A configure change and some #ifdef ugliness might do the trick I guess.
Not looking forward to doing that!

Ian
