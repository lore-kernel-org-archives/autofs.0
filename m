From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] Sample auto.net provided with autofs is
	incorrect
Date: Wed, 06 Jun 2007 10:05:25 -0400
Message-ID: <x49abvduqje.fsf@segfault.boston.devel.redhat.com>
References: <1178053209.20217.57.camel@psmithub>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1178053209.20217.57.camel@psmithub> (Paul Smith's message of
	"Tue, 01 May 2007 17:00:09 -0400")
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
To: psmith@netezza.com
Cc: autofs@linux.kernel.org

==> On Tue, 01 May 2007 17:00:09 -0400, Paul Smith <psmith@netezza.com> said:

Paul> Hi all;
Paul> Please see this bug I just reported against Ubuntu:

Paul> https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/111612

Paul> I believe this problem also exists in the original autofs package.
Paul> However, I can't seem to find the source anywhere; the freshmeat page
Paul> for autofs looks quite out of date and doesn't have any homepage/etc.
Paul> info, and Google searches came up empty as well.

So, ubuntu ships with autofs version 4.1.x?  You can find the upstream
git tree here:
  git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git

Autofs version 5 no longer uses the auto.net script.  If you checkout
the autofs-4_1_4 branch, you'll find the auto.net script in the
samples directory.

I can't speak to your failure, however.  The auto.net script you
reference is a little different from the one upstream.  Upstream uses
sort -k 1 (no -u).

Cheers,

Jeff
