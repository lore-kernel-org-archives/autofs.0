From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta1 release
Date: Wed, 26 Jan 2005 16:13:44 +0100
Message-ID: <20050126151344.GA841@uio.no>
References: <Pine.LNX.4.61.0501262151370.1716@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501262151370.1716@donald.themaw.net>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Wed, Jan 26, 2005 at 10:17:53PM +0800, raven@themaw.net wrote:
> So let me know when you find more and I'll fix`em as quick as I can!

Looks like you missed a patch or two from the Debian archive, at least:

- Quite recently, I uploaded a patch for the debian/event.d script, but this
  is probably not relevant for the upstream distribution.
- There is a patch for rc.autofs.in missing, changing an "else" to en "elif".
  The idea is that failure in loading the autofs4 module should not break
  first-time installation (see http://bugs.debian.org/280276).
- There seem to have been a lot of changes in rc.autofs.in (especially
  related to timeout parsing); I'm unable to follow them all, but I hope
  you've done the right thing in merging in the Debian patches here :-)
- The rc.autofs.in searches for "^automount: ", which breaks if a tab is used
  instead of a space (see http://bugs.debian.org/277320).
- I'm also having a hard time figuring out whether parse_sun.c does the right
  thing wrt. handling whitespace at the end of maps or not; the code looks
  different, at least, but I think it's broken for non-multimaps. Could you
  verify? (Of course, the simplest thing is probably to test :-) )
- I can't see if lookup_file.c handles maps without a trailing newline now
  (Debian patch 051_maps_without_trailing_newline.diff has a hackish fix
  which is obviously not applied, but you might have implemented it
  differently).

Apart from those, it appears like everything else from Debian's 4.1.3 package
is in, at least -- which removes the need for twenty or so local patches :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
