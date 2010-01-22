From: "Philip Ong Jr." <pongjr@gmail.com>
Subject: problem installing 5.0.5
Date: Thu, 21 Jan 2010 23:50:00 -0800
Message-ID: <4B5958A8.2050308@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from
	:user-agent:mime-version:to:subject:content-type
	:content-transfer-encoding;
	bh=5XQuTf/FTF995sK5/NMWqfkkeA3vahmyAztVB38G9vE=;
	b=VY8bBdcV6nanzsbW395n58/UqkG0PBw1nNLvi+nLbNT0lqv8kHsgP+klqkWc7CDgYQ
	EQ3j92tanZAAuM43sRDLmDdBI4sju24hP8oupKuUZUkhYFuMBzuwTALqrS8B+1zk2jCb
	96I5UFHLWtNB/dTX9McdZj36w+j4H5t5gvVSc=
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

When installing 5.0.5 on a Centos 4u5 system with kernel.org 2.6.29.4, i 
receive a daemon error.

Here are the last couple of lines...

# DEBUG=1 make
gcc -g -Wall -DDEBUG -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"  
-DAUTOFS_MAP_DIR=\"/etc\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\" 
-DAUTOFS_FIFO_DIR=\"/var/run\" -DAUTOFS_FLAG_DIR=\"/var/run\" 
-DVERSION_STRING=\"5.0.5\" -I/usr/include/libxml2 -c state.c
gcc -g -Wall -DDEBUG -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"  
-DAUTOFS_MAP_DIR=\"/etc\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\" 
-DAUTOFS_FIFO_DIR=\"/var/run\" -DAUTOFS_FLAG_DIR=\"/var/run\" 
-DVERSION_STRING=\"5.0.5\" -I/usr/include/libxml2 -c flag.c
gcc -g -lpthread -rdynamic -pie -o automount automount.o indirect.o 
direct.o spawn.o module.o mount.o lookup.o state.o flag.o 
../lib/autofs.a -ldl -lxml2 -lz -lpthread -lm
../lib/autofs.a(master_tok.o)(.text+0x1b45): In function 
`master_set_scan_buffer':
/usr/src/autofs-5.0.5/lib/master_tok.l:417: undefined reference to 
`master_lex_destroy'
collect2: ld returned 1 exit status
make[1]: *** [automount] Error 1
make[1]: Leaving directory `/usr/src/autofs-5.0.5/daemon'
make: *** [daemon] Error 2
