From: Ryan Go <ryan@rentec.com>
Subject: Re: make errors for autofs 5.0.4/5.0.5
Date: Wed, 2 Feb 2011 16:11:23 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1102021609130.3973@elr.eragrp.pbz>
References: <4D475655.3070002@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4D475655.3070002@gmail.com>
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
To: "Philip Ong Jr." <pongjr@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 31 Jan 2011, Philip Ong Jr. wrote:

> I've applied all the patches for both trees, but i'm getting these errors.
>
> I'm running a kernel.org kernel 2.6.29.4 64bit RHEL4u5. Are there any 
> specific software requirements for compiling?
>
> make[1]: Leaving directory `/usr/src/autofs-5.0.4/lib'
> make[1]: Entering directory `/usr/src/autofs-5.0.4/daemon'
> gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -rdynamic -fPIE 
> -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
> -DAUTOFS_MAP_DIR=\"/etc\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\" 
> -DAUTOFS_FIFO_DIR=\"/var/run\" -DAUTOFS_FLAG_DIR=\"/var/run\" 
> -DVERSION_STRING=\"5.0.4\" -c automount.c
> automount.c:43:27: libxml/parser.h: No such file or directory
                      ^^^^^^^^^^^^^^^

You would need to have the libxml development libraries installed to 
compile. I am not sure what RedHat calls it (for reference, it's 
libxml2-devel for OpenSuSE 11.2).

HTH,
Ryan
