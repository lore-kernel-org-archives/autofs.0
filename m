From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs-4.1.2-6 test rpms available
Date: Fri, 7 May 2004 13:57:16 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16539.52732.173643.109020@segfault.boston.redhat.com>
References: <16538.43940.58650.642984@segfault.boston.redhat.com>
	<1083952048.18740.75.camel@serpentine.internal.keyresearch.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1083952048.18740.75.camel@serpentine.internal.keyresearch.com>
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
To: Bryan O'Sullivan <bos@serpentine.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] autofs-4.1.2-6 test rpms available; "Bryan O'Sullivan" <bos@serpentine.com> adds:

bos> On Thu, 2004-05-06 at 14:18, Jeff Moyer wrote:
>> Here is the changelog for the latest version.

bos> Jeff, I suggest that if you have time, you take a look to see if your
bos> 4.1.0 RPMs have the "never notice updates to NIS maps" problem that is
bos> in 4.1.2.  It's not entirely a showstopper, but it's a huge headache.

I'm not quite sure what you're asking, here.  FC2t3 will have
autofs-4.1.2-2.  I'm going to push either 4.1.2-6+ or 4.1.3-x into the next
FC release.  I certainly won't support people running 4.1.0, as it has a
few bugs that users often trip over.

Having said that, the 4.1.2 rpms I've released (both for testing and for
inclusion in FC) have the bug to which you refer.

I'll work with Ian and the list as best I can to get this resolved.

Thanks!

Jeff
