From: Nail El-Sourani <sourani@math.uni-muenster.de>
Subject: 5.0.4 with all patches -> compile error on 64bit
Date: Thu, 04 Jun 2009 10:56:27 +0200
Message-ID: <4A278C3B.6050207@math.uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
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
To: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

hi everyone,

trying to compile latest source code from
kernel.org/pub/linux/daemons/autofs/v5 with ALL patches applied as of today.

./configure works
make gives error:

...
gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=3D64 -rdynamic -fPIE
-D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=3D\"/usr/lib/autofs\" =

-DAUTOFS_MAP_DIR=3D\"/etc\" -DAUTOFS_CONF_DIR=3D\"/etc/sysconfig\"
-DAUTOFS_FIFO_DIR=3D\"/var/run\" -DAUTOFS_FLAG_DIR=3D\"/var/run\"
-DVERSION_STRING=3D\"5.0.4\" -c flag.c
gcc -s -lpthread -rdynamic -pie -o automount automount.o indirect.o
direct.o spawn.o module.o mount.o lookup.o state.o flag.o
../lib/autofs.a -ldl
../lib/autofs.a(master_tok.o): In function `master_set_scan_buffer':
master_tok.c:(.text+0x257): undefined reference to `master_lex_destroy'
collect2: ld gab 1 als Ende-Status zur=FCck
make[1]: *** [automount] Fehler 1
make[1]: Leaving directory `/root/Desktop/autofs-5.0.4/daemon'
make: *** [daemon] Fehler 2


(these are the last few lines)

i am suspecting a problem with 64bit but then again, what do i know...
this is a centos5.3 64bit machine

kind regards,
*nail el-Sourani
