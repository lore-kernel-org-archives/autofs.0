From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: BUG: /foo/bar already mounted
Date: Thu, 14 Apr 2005 10:18:47 -0400
Message-ID: <16990.31687.286825.639821@segfault.boston.redhat.com>
References: <20050412175850.GA1556@pixar.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050412175850.GA1556@pixar.com>
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
To: Chris Walker <cwalker@pixar.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] BUG: /foo/bar already mounted; Chris Walker <cwalker@pixar.com> adds:

cwalker> Apologies if this in faq or changelog somewhere. I get run into
cwalker> this bug quite frequently:

cwalker> Apr 11 15:40:15 XXXXX automount[21296]: BUG: /foo/bar/blah already
cwalker> mounted

cwalker> Once hitting this, the filesystem in question is unavailable until
cwalker> reboot. Has this bug been addressed? If so, in what version of the
cwalker> autofs or the kernel has it been fixed? Thanks!

cwalker> OS: fedora core 2 kernel: 2.6.8-1.521smp autofs: 4.1.3-47 (autofs4
cwalker> kernel mod)

Hmm, old.  I don't make patches for FC2 anymore.  You can try the latest
autofs utility from fc4, it will compile and run happily on FC2.  You will
be missing one kernel patch that fixes map updates when using direct maps
and ghosting.  Everything else should work as advertised.

So, can you try the 4.1.4 version of autofs?  You can get an SRPM to build
from here:

  http://people.redhat.com/~jmoyer/autofs/fc4/4.1.4-4/SRPMS/

If that still fails, then we'll talk about how to get more debugging
information.

-Jeff
