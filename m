From: raven@themaw.net
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta1 release
Date: Wed, 26 Jan 2005 23:35:18 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501262320080.1890@donald.themaw.net>
References: <Pine.LNX.4.61.0501262151370.1716@donald.themaw.net>
	<20050126151344.GA841@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050126151344.GA841@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Wed, 26 Jan 2005, Steinar H. Gunderson wrote:

Cool.

I'll work through this during the beta.

> On Wed, Jan 26, 2005 at 10:17:53PM +0800, raven@themaw.net wrote:
>> So let me know when you find more and I'll fix`em as quick as I can!
>
> Looks like you missed a patch or two from the Debian archive, at least:
>
> - Quite recently, I uploaded a patch for the debian/event.d script, but this
>  is probably not relevant for the upstream distribution.

I'll grab it for my Debian package test build.

> - There is a patch for rc.autofs.in missing, changing an "else" to en "elif".
>  The idea is that failure in loading the autofs4 module should not break
>  first-time installation (see http://bugs.debian.org/280276).

I see.

What if autofs[4] is not compiled as a module?

This might need some more work.

> - There seem to have been a lot of changes in rc.autofs.in (especially
>  related to timeout parsing); I'm unable to follow them all, but I hope
>  you've done the right thing in merging in the Debian patches here :-)

Do you remember what the issues were?

> - The rc.autofs.in searches for "^automount: ", which breaks if a tab is used
>  instead of a space (see http://bugs.debian.org/277320).

Missed that one.

> - I'm also having a hard time figuring out whether parse_sun.c does the right
>  thing wrt. handling whitespace at the end of maps or not; the code looks
>  different, at least, but I think it's broken for non-multimaps. Could you
>  verify? (Of course, the simplest thing is probably to test :-) )

Yep. There's been a bit of work there, not only related to white space.
Please test this out as I need to know what I've broken.

> - I can't see if lookup_file.c handles maps without a trailing newline now
>  (Debian patch 051_maps_without_trailing_newline.diff has a hackish fix
>  which is obviously not applied, but you might have implemented it
>  differently).

I'll check.

Ian
