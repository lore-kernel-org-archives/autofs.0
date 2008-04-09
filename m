From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: error returned upon mount failure
Date: Wed, 09 Apr 2008 08:59:10 -0400
Message-ID: <x49d4ozchgh.fsf@segfault.boston.devel.redhat.com>
References: <Pine.GSO.4.55.0804081730320.21655@loogie.intranet.csupomona.edu>
	<1207714911.2992.15.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1207714911.2992.15.camel@raven.themaw.net> (Ian Kent's message
	of "Wed\, 09 Apr 2008 12\:21\:51 +0800")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent <raven@themaw.net> writes:

> from mount(8) reflect the errors. I really don't want to have to pull
> in, and then have to maintain separately, all the mount code.

This is the purpose of libmount.  I think Karel is working on that.

Cheers,

Jeff
