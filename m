From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta1 release
Date: Thu, 27 Jan 2005 09:21:10 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0501270916190.20105@wombat.indigo.net.au>
References: <Pine.LNX.4.61.0501262151370.1716@donald.themaw.net>
	<20050126151344.GA841@uio.no>
	<Pine.LNX.4.61.0501262320080.1890@donald.themaw.net>
	<20050126161454.GA9417@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050126161454.GA9417@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Wed, 26 Jan 2005, Steinar H. Gunderson wrote:

> On Wed, Jan 26, 2005 at 11:35:18PM +0800, raven@themaw.net wrote:
> >>- There is a patch for rc.autofs.in missing, changing an "else" to en
> >>  "elif".  The idea is that failure in loading the autofs4 module should not
> >>  break first-time installation (see http://bugs.debian.org/280276).
> > What if autofs[4] is not compiled as a module?
> 
> In that case, it is in /proc/filesystems, and there is no problem. You
> _could_ argue that is autofs3 was compiled into the kernel, it should fail,
> but I can't find a good way to detect that.

Unless I see anything else I'll make the approriate change.

> 
> >>- There seem to have been a lot of changes in rc.autofs.in (especially
> >>  related to timeout parsing); I'm unable to follow them all, but I hope
> >>  you've done the right thing in merging in the Debian patches here :-)
> > Do you remember what the issues were?
> 
> (Just to clear up; "there seems to have been a lot of changes" refers to your
> changes, not the Debian changes, although there are several of those as
> well.) I'm afraid this was before I took over the maintainership of the
> package; the changelog is the best thing I can point you to.

That's right.

The Debian side of things really refers to the merging of patches I 
found in the packages (as best as I could) and some init script changes 
which you are, no doubt checking.

Ian
