From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Please help - cleanup
Date: Tue, 4 May 2004 10:59:00 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16535.44980.475389.900686@segfault.boston.redhat.com>
References: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
	<Pine.LNX.4.58.0405042233560.17014@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405042233560.17014@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [autofs] Please help - cleanup; raven@themaw.net adds:

raven> Hi all again,

raven> Further to yesterdays replicated server patch I have done some
raven> cleanup to it.

raven> This patch replaces the previous patch so you will need to back out
raven> the previous one before applying this one.

raven> I have:

raven> - corrected some inconsistent messages.  - cleaned up paths (there
raven> were some double slashes, function was OK though)

raven> One problem remains and seems not to be easily fixed. For multi
raven> mount maps dead mount point directories (from failed mounts) are
raven> left. This is not simple to fix without breaking other
raven> functionality. I believe it is better than those "BUG" messages
raven> though. So we`ll have to live with it for now.

Hmm... along the same lines, I just configured ghosting for a map which
uses wildcards (which I'm guessing is not supported, right?). If you cd
to a directory, any directory, it will create that directory and leave it
around, even though there is no such mount.  This sounds like something
that should be fixed up.

raven> If anyone is able to test this also that would be great.

I will roll another test rpm with this patch and post to my people page.

-Jeff
