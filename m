From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta1 release
Date: Wed, 26 Jan 2005 17:14:55 +0100
Message-ID: <20050126161454.GA9417@uio.no>
References: <Pine.LNX.4.61.0501262151370.1716@donald.themaw.net>
	<20050126151344.GA841@uio.no>
	<Pine.LNX.4.61.0501262320080.1890@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501262320080.1890@donald.themaw.net>
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

On Wed, Jan 26, 2005 at 11:35:18PM +0800, raven@themaw.net wrote:
>>- There is a patch for rc.autofs.in missing, changing an "else" to en
>>  "elif".  The idea is that failure in loading the autofs4 module should not
>>  break first-time installation (see http://bugs.debian.org/280276).
> What if autofs[4] is not compiled as a module?

In that case, it is in /proc/filesystems, and there is no problem. You
_could_ argue that is autofs3 was compiled into the kernel, it should fail,
but I can't find a good way to detect that.

>>- There seem to have been a lot of changes in rc.autofs.in (especially
>>  related to timeout parsing); I'm unable to follow them all, but I hope
>>  you've done the right thing in merging in the Debian patches here :-)
> Do you remember what the issues were?

(Just to clear up; "there seems to have been a lot of changes" refers to your
changes, not the Debian changes, although there are several of those as
well.) I'm afraid this was before I took over the maintainership of the
package; the changelog is the best thing I can point you to.

> Yep. There's been a bit of work there, not only related to white space.
> Please test this out as I need to know what I've broken.

OK, I'll give it a shot a bit later. :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
