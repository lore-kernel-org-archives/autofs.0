From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch rfc] address regression in duplicate map entry
	order
Date: Mon, 7 Feb 2005 13:10:29 -0500
Message-ID: <16903.44821.752046.306391@segfault.boston.redhat.com>
References: <16798.38327.587983.840248@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0411212219580.10238@donald.themaw.net>
	<16802.11524.992409.610071@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0411230856060.27086@wombat.indigo.net.au>
	<16898.16820.640543.489325@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0502040929270.21690@wombat.indigo.net.au>
	<16899.45023.789578.736494@segfault.boston.redhat.com>
	<Pine.LNX.4.61.0502051136030.1673@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.61.0502051136030.1673@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [patch rfc] address regression in duplicate map entry order; raven@themaw.net adds:

[snip]

raven> So consider the following patch together with the original patch. I
raven> think this might be all that's needed, at least in populating the
raven> cache.

raven> It reverts the change in 2) and changes cache_update to cache_add in
raven> the needed places.

raven> What do you think?

raven> As I said above the other question that needs to be answered is
raven> whether this will have undesirable side affects at lookup time?

Hi, Ian,

I've tested this patch and it resolves the problem.  We should pursue the
other map expiry related problem I described in my last mail separately, I
think.

Thanks!

-Jeff
