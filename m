From: Frank Thommen <fthommen@embl.de>
Subject: Re: No include of NIS maps in automounter maps possible
 any more?
Date: Thu, 30 Nov 2006 16:17:50 +0100
Message-ID: <456EF61E.6050705@embl.de>
References: <456EE067.3090208@embl.de>
	<x49odqpuhb2.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49odqpuhb2.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Hi Jeff,

> Frank> Is there an other way to *combine* nis and local maps for
> Frank> automounting? Any hints or pointers are appreciated.
> 
> Well, you could use the multi-map syntax.  In auto.master, you would
> have something like the following:
> 
> /foo  multi: file /etc/auto.foo -- yp map.in.nis

Thanks. Great solution.  It's pity the manpages don't mention it ;-)

    frank
