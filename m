From: Ian Kent <raven@themaw.net>
Subject: Re: get_best_mounts fixes.
Date: Tue, 8 Feb 2005 10:05:28 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502080936550.13459@wombat.indigo.net.au>
References: <4203B1C3.30303@redhat.com>
	<Pine.LNX.4.61.0502051243250.1673@donald.themaw.net>
	<4207EF51.1060004@redhat.com>
Mime-Version: 1.0
In-Reply-To: <4207EF51.1060004@redhat.com>
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
To: Chris Feist <cfeist@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 7 Feb 2005, Chris Feist wrote:

> raven@themaw.net wrote:
> > Oh, another unrelated thing.
> > 
> > I hope you didn't mind me jumping on the direct mounts work.
> 
> Sure, no problem.
> 
> > I've thought about how it could be done for so long and it was the 
> > original problem I wanted to fix when I first started work on autofs.
> 
> Do you have any idea how long it may take? Let me know if there is 
> anything I can do to help, we've got several users who *really* want 
> this functionality.  I would also be happy to beta test it when you're 
> ready.

Thanks for the offer to help.

The implementation is pretty much something a single person needs to do.

The code is done for all but the HUP map reread. It's a bit difficult.
I can get it to mount and umount the direct mount triggers.
I can get it to mount map entries.
I'm working on expiring mounts now.
Then there's a second pass to try and make the error checking sensible.
I'll need help testing about here.
Then there's the HUP signal processing.
Then there's a third pass to attempt to address loose ends noticed during 
the development.

I don't know how long it will be as I can't really tell what holdups there 
might be if I find hard unanticipated problems. As always getting time is a 
problem. Having said that, probably not much longer. A week or a little 
more if all goes well.

There are a couple of difficulties with testing.
The code is against 4.1.4 beta1.
There's a kernel patch as well.

Ian
