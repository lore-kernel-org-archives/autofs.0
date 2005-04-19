From: Ian Kent <raven@themaw.net>
Subject: Re: Re: [patch, rfc] fix hung automounter issues
Date: Tue, 19 Apr 2005 10:56:04 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504191054060.12674@wombat.indigo.net.au>
References: <16990.26693.814813.479017@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0504182108230.14946@donald.themaw.net>
	<Pine.LNX.4.62.0504182136110.14946@donald.themaw.net>
	<16996.18646.775008.395575@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16996.18646.775008.395575@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Dan.Berrange@ubs.com

On Mon, 18 Apr 2005, Jeff Moyer wrote:

> 
> Okay, I've reviewed all parts except for the actual logging functions.  I'm
> actually not convinced this is the right approach.  The overhead of setting
> up and tearing down the signal mask is quite expensive.  I fear that
> environments with a great number of mounts will fall over when debugging is
> turned on, and that is the very thing we are trying to save.  Perhaps it is
> worth another look at a separate logging process.
> 

I'm also concerned about using an array to store the log messages.
This could overflow in heavy load mount situations.

Ian
