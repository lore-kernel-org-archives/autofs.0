From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs and NIS+ bug
Date: Fri, 3 Jun 2005 12:13:30 -0400
Message-ID: <17056.33194.160849.89353@segfault.boston.redhat.com>
References: <20050603141451.GJ18045@lenin.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050603141451.GJ18045@lenin.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: "Peter C. Norton" <spacey-autofs@lenin.net>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Autofs and NIS+ bug; "Peter C. Norton" <spacey-autofs@lenin.net> adds:

spacey-autofs> Greetings list, I've been working on an issue with the
spacey-autofs> lookup_nisplus.c that runs headfirst into a bug in the linux
spacey-autofs> glibc's NIS+ code.

[snip]

spacey-autofs> So let me know if in principle this kind of patch could be
spacey-autofs> reviewed, and I'll pass it along, with a minimal description
spacey-autofs> of how to reproduce a test case... if anyone is interested.

Of course you should send the patch!  Also, please don't skimp on the
description of how to reproduce.  If I can't reliably reproduce the problem
and verify the fix, I have a hard time justifying the fix to management!

-Jeff
