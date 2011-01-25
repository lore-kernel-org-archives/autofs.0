From: "Philip Ong Jr." <pongjr@gmail.com>
Subject: make error when installing 5.0.3
Date: Tue, 25 Jan 2011 00:57:50 -0800
Message-ID: <4D3E908E.9070102@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
	:subject:content-type:content-transfer-encoding;
	bh=3svcoABTRxxdJPugBUqCGdiTI7C0LJcjziYDxnhnpOY=;
	b=mHmuskgF+v/VmEer6vpnmrvOc6cWmMf6wPzItRKKUSHFdI6Ref75YBpnBkQsbue9Hb
	mi2R7Yt+YbIugRCwRrD8dsrldVht9A9LmSgkmEObMZB5stwPb9cXCzo7/1C6vtIMaNZF
	lSdetboetlEnul6OGPWaQ1Ks+rX7hDhUagmFg=
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
To: autofs@linux.kernel.org

1) Are there any specific gcc requirements or other utility requirements 
for builing autofs503?

I'm getting this error on a Centos 4.5 install with a kernel.org kernel 
2.6.29.4
I applied all the patches for 5.0.3...then did a configure and then 
make...but had this error...


Linux **** 2.6.29.4 #11 SMP Wed Sep 1 02:15:20 PDT 2010 x86_64 x86_64 
x86_64 GNU/Linux
CentOS release 4.5 (Final)

# for f in `cat ../patch_order-5.0.3`; do patch -Np1 -i ../$f; done

patching file CHANGELOG

patching file aclocal.m4

patching file configure

patching file configure.in

patching file modules/lookup_ldap.c

patching file CHANGELOG

patching file lib/master_parse.y

patching file lib/master_tok.l

patching file CHANGELOG

patching file lib/master_tok.l

patching file CHANGELOG

patching file modules/mount_nfs.c

patching file CHANGELOG

patching file aclocal.m4

patching file configure

patching file configure.in

patching file CHANGELOG

patching file lib/master.c

patching file modules/lookup_file.c

patching file CHANGELOG

patching file daemon/direct.c

patching file daemon/indirect.c

patching file CHANGELOG

patching file daemon/direct.c

patching file daemon/indirect.c

patching file CHANGELOG

patching file daemon/automount.c

patching file include/linux/auto_fs4.h

patching file CHANGELOG

patching file daemon/direct.c

patching file daemon/indirect.c

patching file daemon/indirect.c

patching file CHANGELOG

patching file modules/lookup_yp.c

patching file CHANGELOG

patching file include/lookup_ldap.h

patching file modules/cyrus-sasl.c

patching file modules/lookup_ldap.c

patching file CHANGELOG

patching file lib/master_tok.l

patching file CHANGELOG

patching file daemon/direct.c

patching file daemon/indirect.c

patching file CHANGELOG

patching file daemon/direct.c

patching file include/automount.h

patching file lib/parse_subs.c

patching file CHANGELOG

patching file lib/nss_parse.y

patching file lib/nss_tok.l

patching file modules/mount_bind.c

patching file modules/mount_nfs.c

patching file CHANGELOG

patching file lib/cache.c

patching file modules/lookup_file.c

patching file modules/lookup_ldap.c

patching file modules/lookup_nisplus.c

patching file modules/lookup_yp.c

patching file CHANGELOG

patching file include/replicated.h

patching file include/rpc_subs.h

patching file lib/rpc_subs.c

patching file modules/replicated.c

patching file CHANGELOG

patching file daemon/direct.c

patching file daemon/indirect.c

patching file CHANGELOG

patching file lib/mounts.c

patching file CHANGELOG

patching file daemon/direct.c

patching file include/automount.h

patching file daemon/direct.c

patching file daemon/indirect.c

patching file CHANGELOG

patching file daemon/lookup.c

patching file modules/parse_sun.c

patching file CHANGELOG

patching file daemon/automount.c

patching file man/automount.8

patching file CHANGELOG

patching file Makefile.conf.in

patching file aclocal.m4

patching file configure

patching file configure.in

patching file daemon/Makefile

patching file daemon/automount.c

patching file daemon/flag.c

patching file daemon/lookup.c

patching file daemon/lookup.c

patching file modules/lookup_file.c

patching file modules/lookup_ldap.c

patching file modules/lookup_nisplus.c

patching file modules/lookup_program.c

patching file modules/lookup_yp.c

patching file daemon/lookup.c

patching file modules/replicated.c

patching file daemon/direct.c

patching file daemon/indirect.c

patching file include/automount.h

patching file include/mounts.h

patching file include/parse_subs.h

patching file lib/mounts.c

patching file lib/parse_subs.c

patching file CHANGELOG

patching file daemon/automount.c

patching file include/automount.h

patching file lib/master.c

patching file modules/mount_autofs.c

patching file CHANGELOG

patching file daemon/automount.c

patching file daemon/direct.c

patching file daemon/indirect.c

patching file daemon/lookup.c

patching file daemon/state.c

patching file include/automount.h

patching file include/master.h

patching file include/state.h

patching file lib/alarm.c

patching file lib/master.c

patching file modules/mount_autofs.c

patching file CHANGELOG

patching file daemon/automount.c

patching file daemon/direct.c

patching file daemon/indirect.c

patching file daemon/spawn.c

patching file include/master.h

patching file lib/master.c

patching file lib/mounts.c

patching file daemon/spawn.c

patching file include/defaults.h

patching file lib/defaults.c

patching file man/auto.master.5.in

patching file redhat/autofs.sysconfig.in

patching file samples/autofs.conf.default.in

patching file CHANGELOG

patching file daemon/automount.c

patching file daemon/direct.c

patching file daemon/indirect.c

patching file daemon/lookup.c

patching file daemon/state.c

patching file include/automount.h

patching file include/master.h

patching file include/mounts.h

patching file lib/master.c

patching file lib/mounts.c

patching file modules/mount_autofs.c

patching file modules/mount_bind.c

patching file modules/mount_changer.c

patching file modules/mount_ext2.c

patching file modules/mount_generic.c

patching file modules/mount_nfs.c

patching file modules/parse_sun.c

patching file daemon/direct.c

patching file modules/parse_sun.c

patching file modules/replicated.c

patching file CHANGELOG

patching file modules/replicated.c

patching file CHANGELOG

patching file README.replicated-server

patching file CHANGELOG

patching file modules/replicated.c

patching file CHANGELOG

patching file daemon/spawn.c

patching file CHANGELOG

patching file modules/replicated.c

patching file modules/lookup_ldap.c

patching file modules/replicated.c

patching file daemon/spawn.c

patching file modules/lookup_yp.c

patching file modules/replicated.c

patching file daemon/direct.c

patching file CHANGELOG

patching file patches/autofs4-2.6.10-v5-update-20080924.patch

patching file patches/autofs4-2.6.10-v5-update.patch

patching file patches/autofs4-2.6.11-v5-update-20080924.patch

patching file patches/autofs4-2.6.11-v5-update.patch

patching file patches/autofs4-2.6.12-v5-update-20080924.patch

patching file patches/autofs4-2.6.12-v5-update.patch

patching file patches/autofs4-2.6.13-v5-update-20080924.patch

patching file patches/autofs4-2.6.13-v5-update.patch

patching file patches/autofs4-2.6.14-v5-update-20080924.patch

patching file patches/autofs4-2.6.14-v5-update.patch

patching file patches/autofs4-2.6.15-v5-update-20080924.patch

patching file patches/autofs4-2.6.15-v5-update.patch

patching file patches/autofs4-2.6.16-v5-update-20080924.patch

patching file patches/autofs4-2.6.16-v5-update.patch

patching file patches/autofs4-2.6.17-v5-update-20080924.patch

patching file patches/autofs4-2.6.17-v5-update.patch

patching file patches/autofs4-2.6.18-v5-update-20080924.patch

patching file patches/autofs4-2.6.18-v5-update.patch

patching file patches/autofs4-2.6.19-v5-update-20080924.patch

patching file patches/autofs4-2.6.19-v5-update.patch

patching file patches/autofs4-2.6.20-v5-update-20080924.patch

patching file patches/autofs4-2.6.20-v5-update.patch

patching file patches/autofs4-2.6.21-v5-update.patch

patching file patches/autofs4-2.6.22-v5-update-20080924.patch

patching file patches/autofs4-2.6.22-v5-update.patch

patching file patches/autofs4-2.6.22.17-v5-update-20080924.patch

patching file patches/autofs4-2.6.23-v5-update-20080924.patch

patching file patches/autofs4-2.6.23-v5-update.patch

patching file patches/autofs4-2.6.24-v5-update-20080924.patch

patching file patches/autofs4-2.6.24.4-v5-update-20080924.patch

patching file patches/autofs4-2.6.25-v5-update-20080924.patch

patching file patches/autofs4-2.6.26-v5-update-20080924.patch

patching file patches/autofs4-2.6.9-v5-update-20080924.patch

patching file patches/autofs4-2.6.9-v5-update.patch

patching file CHANGELOG

patching file daemon/direct.c

patching file CHANGELOG

patching file modules/parse_sun.c

patching file lib/master_tok.l

patching file CHANGELOG

patching file lib/master.c

patching file CHANGELOG

patching file modules/lookup_nisplus.c

patching file CHANGELOG

patching file daemon/direct.c

patching file CHANGELOG

patching file lib/master.c

patching file CHANGELOG

patching file include/lookup_ldap.h

patching file modules/lookup_ldap.c

patching file CHANGELOG

patching file daemon/automount.c

patching file daemon/lookup.c

patching file daemon/state.c

patching file include/master.h

patching file lib/master.c

patching file CHANGELOG

patching file daemon/direct.c

patching file daemon/indirect.c

patching file CHANGELOG

patching file Makefile.conf.in

patching file CHANGELOG

patching file samples/rc.autofs.in

patching file CHANGELOG

patching file lib/master_tok.l

patching file CHANGELOG

patching file daemon/lookup.c

patching file aclocal.m4

patching file configure


# ./configure --disable-mount-locking --enable-ignore-busy

checking for binaries in... /usr/bin:/bin:/usr/sbin:/sbin

checking for Linux proc filesystem... yes

checking location of the init.d directory... /etc/init.d

checking for autofs configuration file directory... /etc/sysconfig

checking for autofs maps directory... /etc

checking for autofs fifos directory... /var/run

checking for autofs flag file directory... /var/run

checking if malloc debugging is wanted... no

checking for mount... /bin/mount

checking for umount... /bin/umount

checking for fsck.ext2... /sbin/fsck.ext2

checking for fsck.ext3... /sbin/fsck.ext3

checking for modprobe... /sbin/modprobe

checking for flex... /usr/bin/flex

checking for bison... /usr/bin/bison

checking for ranlib... /usr/bin/ranlib

checking for rpcgen... /usr/bin/rpcgen

checking if mount accepts the -s option... yes

checking for xml2-config... /usr/bin/xml2-config

checking for libxml2... yes

checking for gcc... gcc

checking for C compiler default output file name... a.out

checking whether the C compiler works... yes

checking whether we are cross compiling... no

checking for suffix of executables...

checking for suffix of object files... o

checking whether we are using the GNU C compiler... yes

checking whether gcc accepts -g... yes

checking for gcc option to accept ISO C89... none needed

checking for yp_match in -lnsl... yes

checking for res_query in -lresolv... no

checking for libhesiod... yes

checking how to run the C preprocessor... gcc -E

checking for grep that handles long lines and -e... /bin/grep

checking for egrep... /bin/grep -E

checking for ANSI C header files... yes

checking for sys/types.h... yes

checking for sys/stat.h... yes

checking for stdlib.h... yes

checking for string.h... yes

checking for memory.h... yes

checking for strings.h... yes

checking for inttypes.h... yes

checking for stdint.h... yes

checking for unistd.h... yes

checking rpcsvc/nis.h usability... yes

checking rpcsvc/nis.h presence... yes

checking for rpcsvc/nis.h... yes

checking for ldap_initialize in -lldap... yes

checking for ldap_create_page_control in -lldap... no

checking for ldap_parse_page_control in -lldap... no

checking for sasl_client_start in -lsasl2... yes

checking for gcc... (cached) gcc

checking whether we are using the GNU C compiler... (cached) yes

checking whether gcc accepts -g... (cached) yes

checking for gcc option to accept ISO C89... (cached) none needed

checking whether gcc -fPIE works... yes

configure: creating ./config.status

config.status: creating Makefile.conf

config.status: creating include/config.h

config.status: include/config.h is unchanged


# make

set -e; for i in lib daemon modules man samples; do make -C $i all; done

make[1]: Entering directory `/usr/src/autofs-5.0.3/lib'

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c cache.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c rpc_subs.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c mounts.c

/usr/bin/flex -omaster_tok.c -Pmaster_ master_tok.l

/usr/bin/bison -v -d -p master_ -b master_parse master_parse.y

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c master_tok.c

master_tok.c:2734: warning: \u2018yy_flex_realloc\u2019 defined but not used

master_tok.c:2268: warning: \u2018input\u2019 defined but not used

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c master_parse.tab.c

/usr/bin/flex -onss_tok.c -Pnss_ nss_tok.l

/usr/bin/bison -v -d -p nss_ -b nss_parse nss_parse.y

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c nss_tok.c

nss_tok.c:1224: warning: \u2018input\u2019 defined but not used

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c nss_parse.tab.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c alarm.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c master.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c defaults.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -fPIC 
-D_GNU_SOURCE -DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -c parse_subs.c

rm -f autofs.a

ar rv autofs.a cache.o mount_clnt.o mount_xdr.o cat_path.o rpc_subs.o 
mounts.o log.o nsswitch.o master_tok.o master_parse.tab.o nss_tok.o 
nss_parse.tab.o args.o alarm.o macros.o master.o defaults.o parse_subs.o

ar: creating autofs.a

a - cache.o

a - mount_clnt.o

a - mount_xdr.o

a - cat_path.o

a - rpc_subs.o

a - mounts.o

a - log.o

a - nsswitch.o

a - master_tok.o

a - master_parse.tab.o

a - nss_tok.o

a - nss_parse.tab.o

a - args.o

a - alarm.o

a - macros.o

a - master.o

a - defaults.o

a - parse_subs.o

/usr/bin/ranlib autofs.a

make[1]: Leaving directory `/usr/src/autofs-5.0.3/lib'

make[1]: Entering directory `/usr/src/autofs-5.0.3/daemon'

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include 
-DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"-DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DAUTOFS_FIFO_DIR=\"/var/run\" 
-DAUTOFS_FLAG_DIR=\"/var/run\" -DVERSION_STRING=\"5.0.3\" -c automount.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include 
-DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"-DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DAUTOFS_FIFO_DIR=\"/var/run\" 
-DAUTOFS_FLAG_DIR=\"/var/run\" -DVERSION_STRING=\"5.0.3\" -c indirect.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include 
-DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"-DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DAUTOFS_FIFO_DIR=\"/var/run\" 
-DAUTOFS_FLAG_DIR=\"/var/run\" -DVERSION_STRING=\"5.0.3\" -c direct.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include 
-DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"-DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DAUTOFS_FIFO_DIR=\"/var/run\" 
-DAUTOFS_FLAG_DIR=\"/var/run\" -DVERSION_STRING=\"5.0.3\" -c spawn.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include 
-DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"-DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DAUTOFS_FIFO_DIR=\"/var/run\" 
-DAUTOFS_FLAG_DIR=\"/var/run\" -DVERSION_STRING=\"5.0.3\" -c lookup.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include 
-DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"-DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DAUTOFS_FIFO_DIR=\"/var/run\" 
-DAUTOFS_FLAG_DIR=\"/var/run\" -DVERSION_STRING=\"5.0.3\" -c state.c

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include 
-DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"-DAUTOFS_MAP_DIR=\"/etc\" 
-DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DAUTOFS_FIFO_DIR=\"/var/run\" 
-DAUTOFS_FLAG_DIR=\"/var/run\" -DVERSION_STRING=\"5.0.3\" -c flag.c

gcc -s -lpthread -rdynamic -pie -o automount automount.o indirect.o 
direct.o spawn.o module.o mount.o lookup.o state.o flag.o 
../lib/autofs.a -ldl

strip --strip-debug automount

make[1]: Leaving directory `/usr/src/autofs-5.0.3/daemon'

make[1]: Entering directory `/usr/src/autofs-5.0.3/modules'

gcc -shared -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include 
-I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
-DAUTOFS_MAP_DIR=\"/etc\" -o lookup_yp.so lookup_yp.c ../lib/autofs.a-lnsl

strip --strip-debug lookup_yp.so

gcc -shared -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include 
-I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
-DAUTOFS_MAP_DIR=\"/etc\" -o lookup_file.so lookup_file.c 
../lib/autofs.a-lnsl

strip --strip-debug lookup_file.so

gcc -shared -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include 
-I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
-DAUTOFS_MAP_DIR=\"/etc\" -o lookup_program.so lookup_program.c 
../lib/autofs.a-lnsl

strip --strip-debug lookup_program.so

gcc -shared -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include 
-I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
-DAUTOFS_MAP_DIR=\"/etc\" -o parse_sun.so parse_sun.c ../lib/autofs.a-lnsl

parse_sun.c: In function \u2018move_mount\u2019:

parse_sun.c:991: error: \u2018MS_MOVE\u2019 undeclared (first use in 
this function)

parse_sun.c:991: error: (Each undeclared identifier is reported only once

parse_sun.c:991: error: for each function it appears in.)

make[1]: *** [parse_sun.so] Error 1

make[1]: Leaving directory `/usr/src/autofs-5.0.3/modules'

make: *** [daemon] Error 2
