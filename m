From: peter.a.harris@exgate.tek.com
Subject: RE: [ANNOUNCE] autofs v4 releases, at last
Date: Mon, 6 Oct 2003 12:19:11 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <BA0E4392AD99D040885C414D992C24BE0526D052@us-bv-m11.bv.tek.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Ian,

I am having problems with the 2.4 module compile.  I am running Red Hat 7.3,
2.4.20-20.7 kernel and I get:

gcc -I. -I./include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe
-mpreferred-stack-boundary=2 -march=i686 -D__KERNEL__ -DMODULE
-I/usr/src/linux-2.4.20-20.7/include -DMODVERSIONS -include
/usr/src/linux-2.4.20-20.7/include/linux/modversions.h -DREDHAT_KERNEL   -c
-o waitq.o waitq.c
waitq.c: In function `autofs4_write':
waitq.c:81: structure has no member named `sighand'
waitq.c:83: too few arguments to function `recalc_sigpending_Rsmp_e98ecd0c'
waitq.c:84: structure has no member named `sighand'
waitq.c: In function `autofs4_wait':
waitq.c:254: structure has no member named `sighand'
waitq.c:257: too few arguments to function `recalc_sigpending_Rsmp_e98ecd0c'
waitq.c:258: structure has no member named `sighand'
waitq.c:275: structure has no member named `sighand'
waitq.c:277: too few arguments to function `recalc_sigpending_Rsmp_e98ecd0c'
waitq.c:278: structure has no member named `sighand'
make: *** [waitq.o] Error 1

I see you test for 2.4.19+ before using this code, so I am at loss.

Any ideas?  Thanks.


Pete Harris
Tektronix, Inc. / Technical Computing
MS 39-325 / PO BOX 500 / BEAVERTON OR 97077-0500
Ph: 1-503-627-3989 / Fax: 1-503-627-5587
PGP:	0xD1F493F6
	EA9E 25B8 EF02 3EBD 26CB 7E28 026E 74DB D1F4 93F6

-- Any opinions expressed are those of the author and 
   may not represent Tektronix, Inc. --
