From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: RFT: new autofs test package with map expiry changes
Date: Fri, 6 Aug 2004 08:41:05 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16659.31841.663187.637400@segfault.boston.redhat.com>
References: <16658.38020.371365.856850@segfault.boston.redhat.com>
	<ufa3c310vz3.fsf@epithumia.math.uh.edu>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ufa3c310vz3.fsf@epithumia.math.uh.edu>
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
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] RFT: new autofs test package with map expiry changes; Jason L Tibbitts III <tibbs@math.uh.edu> adds:

>>>>>> "JM" == Jeff Moyer <jmoyer@redhat.com> writes:
JM> I also posted a kernel patch against 2.6.7, which is _required_.
JM> autofs-4.1.3-11 is the version with these changes.

tibbs> Not to be overly dense, but is there any way to test this under FC2?
tibbs> I need map expiry and I'm happy to test, but I haven't found the time
tibbs> to bring up FC3t1 yet.

The kernel patch should apply to an fc2 kernel, as well.  The userland
utilities should also install fine.  If not, you can rebuild the SRPM for
fc2.  If you need further help in doing either of these things, feel free
to contact me off-list.

Thanks!

Jeff
