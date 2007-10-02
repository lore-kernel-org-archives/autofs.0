From: Ian Kent <raven@themaw.net>
Subject: Re: nested automounts: bind and nfs
Date: Tue, 02 Oct 2007 13:03:09 +0800
Message-ID: <1191301389.26331.29.camel@raven.themaw.net>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Mon, 2007-10-01 at 16:08 +0200, Lukas Kolbe wrote:

> Should I try the patch mentioned in the thread last year? I'm currently
> using kernel 2.6.18 (from debian, we're bound to that one since it
> supports xen), autofs-5.0.2 with all patches from kernel.org applied.

Oh .. hang on, what configure options are you using?

If you don't use "--disable-mount-locking" with configure then the code
mentioned in the thread above can't be used because it would deadlock
the recursive mount.

Ian
