From: raven@themaw.net
Subject: Re: Please help - cleanup
Date: Tue, 4 May 2004 23:16:52 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405042308070.17014@donald.themaw.net>
References: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
 <Pine.LNX.4.58.0405042233560.17014@donald.themaw.net>
 <16535.44980.475389.900686@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16535.44980.475389.900686@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 4 May 2004, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] Please help - cleanup; raven@themaw.net adds:
> 
> raven> Hi all again,
> 
> raven> Further to yesterdays replicated server patch I have done some
> raven> cleanup to it.
> 
> raven> This patch replaces the previous patch so you will need to back out
> raven> the previous one before applying this one.
> 
> raven> I have:
> 
> raven> - corrected some inconsistent messages.  - cleaned up paths (there
> raven> were some double slashes, function was OK though)
> 
> raven> One problem remains and seems not to be easily fixed. For multi
> raven> mount maps dead mount point directories (from failed mounts) are
> raven> left. This is not simple to fix without breaking other
> raven> functionality. I believe it is better than those "BUG" messages
> raven> though. So we`ll have to live with it for now.
> 
> Hmm... along the same lines, I just configured ghosting for a map which
> uses wildcards (which I'm guessing is not supported, right?). If you cd
> to a directory, any directory, it will create that directory and leave it
> around, even though there is no such mount.  This sounds like something
> that should be fixed up.

That problem is a little different to the one sited above.

If there is a map that contains some entries and a wildcard map at the end 
I can't tell if the directory should be removed or not. So either we keep 
that behaviour or we disable ghosting altogether when a wildcard map 
entry is seen.

In the past I considered that if ghosting was requested in this case I 
would leave the entries and allow autofs to "learn" about the mounts as 
it went.

So what do people think we should do here?

> 
> raven> If anyone is able to test this also that would be great.
> 
> I will roll another test rpm with this patch and post to my people page.

Thanks Jeff.

Ian
