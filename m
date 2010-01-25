From: Ian Kent <raven@themaw.net>
Subject: Re: problem installing 5.0.5
Date: Mon, 25 Jan 2010 11:28:49 +0800
Message-ID: <4B5D0FF1.1010701@themaw.net>
References: <4B5958A8.2050308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B5958A8.2050308@gmail.com>
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
To: "Philip Ong Jr." <pongjr@gmail.com>
Cc: autofs@linux.kernel.org

On 01/22/2010 03:50 PM, Philip Ong Jr. wrote:
> When installing 5.0.5 on a Centos 4u5 system with kernel.org 2.6.29.4, i
> receive a daemon error.
> 
> Here are the last couple of lines...
> 
> # DEBUG=1 make
> gcc -g -Wall -DDEBUG -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE
> -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
> -DAUTOFS_MAP_DIR=\"/etc\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\"
> -DAUTOFS_FIFO_DIR=\"/var/run\" -DAUTOFS_FLAG_DIR=\"/var/run\"
> -DVERSION_STRING=\"5.0.5\" -I/usr/include/libxml2 -c state.c
> gcc -g -Wall -DDEBUG -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE
> -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
> -DAUTOFS_MAP_DIR=\"/etc\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\"
> -DAUTOFS_FIFO_DIR=\"/var/run\" -DAUTOFS_FLAG_DIR=\"/var/run\"
> -DVERSION_STRING=\"5.0.5\" -I/usr/include/libxml2 -c flag.c
> gcc -g -lpthread -rdynamic -pie -o automount automount.o indirect.o
> direct.o spawn.o module.o mount.o lookup.o state.o flag.o
> ../lib/autofs.a -ldl -lxml2 -lz -lpthread -lm
> ../lib/autofs.a(master_tok.o)(.text+0x1b45): In function
> `master_set_scan_buffer':
> /usr/src/autofs-5.0.5/lib/master_tok.l:417: undefined reference to
> `master_lex_destroy'
> collect2: ld returned 1 exit status
> make[1]: *** [automount] Error 1
> make[1]: Leaving directory `/usr/src/autofs-5.0.5/daemon'
> make: *** [daemon] Error 2

You need to check on kernel.org for patch updates.
This was resolved with patch
autofs-5.0.5-dont-use-master_lex_destroy-to-clear-parse-buffer.patch

Since the patch changes the CHANGELOG file and there are several other
patches before it in patch_order-5.0.5 you will get a rejection unless
you also apply the previous patches. I recommend applying all the
current 5.0.5 patches (as you would expect).

Ian
