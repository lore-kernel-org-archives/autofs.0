From: "Philip Ong Jr." <pongjr@gmail.com>
Subject: make errors for autofs 5.0.4/5.0.5
Date: Mon, 31 Jan 2011 16:39:49 -0800
Message-ID: <4D475655.3070002@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
	:subject:content-type:content-transfer-encoding;
	bh=NmkPlQKo5zeW/oL5HXV8yHTahFq4bthKS4m70yotYsE=;
	b=jekVC5R8Mq40YLASqiJInU4zkfmn4q2YDeqwyUTg/NNbAnp3PsBFNx7X2UcMo6hzNv
	4JYBXIjrSi5sOwxBOKEBk5GQoPvwBR8M5v5U6841eye5b7R87RwaN0FXUzFHFOhNc15R
	wrGGPeY2qMdQY00jZjUf4jwytVKT7e0+noAy4=
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

I've applied all the patches for both trees, but i'm getting these errors.

I'm running a kernel.org kernel 2.6.29.4 64bit RHEL4u5. Are there any 
specific software requirements for compiling?

make[1]: Leaving directory `/usr/src/autofs-5.0.4/lib'
make[1]: Entering directory `/usr/src/autofs-5.0.4/daemon'
gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"  
-DAUTOFS_MAP_DIR=\"/etc\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\" 
-DAUTOFS_FIFO_DIR=\"/var/run\" -DAUTOFS_FLAG_DIR=\"/var/run\" 
-DVERSION_STRING=\"5.0.4\" -c automount.c
automount.c:43:27: libxml/parser.h: No such file or directory
automount.c: In function `main':
automount.c:2118: warning: implicit declaration of function `xmlInitParser'
automount.c:2163: warning: implicit declaration of function 
`xmlCleanupParser'
make[1]: *** [automount.o] Error 1
make[1]: Leaving directory `/usr/src/autofs-5.0.4/daemon'
make: *** [daemon] Error 2

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
-D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"  
-DAUTOFS_MAP_DIR=\"/etc\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\" 
-DAUTOFS_FIFO_DIR=\"/var/run\" -DAUTOFS_FLAG_DIR=\"/var/run\" 
-DVERSION_STRING=\"5.0.5\" -c flag.c
gcc -s -lpthread -rdynamic -pie -o automount automount.o indirect.o 
direct.o spawn.o module.o mount.o lookup.o state.o flag.o 
../lib/autofs.a -ldl
strip --strip-debug automount
make[1]: Leaving directory `/usr/src/autofs-5.0.5/daemon'
make[1]: Entering directory `/usr/src/autofs-5.0.5/modules'
Makefile:75: Extraneous text after `else' directive
Makefile:80: Extraneous text after `else' directive
Makefile:80: *** only one `else' per conditional.  Stop.
make[1]: Leaving directory `/usr/src/autofs-5.0.5/modules'
make: *** [daemon] Error 2
