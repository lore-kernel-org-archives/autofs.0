From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.1 release
Date: Wed, 21 Feb 2007 12:48:13 +0900
Message-ID: <1172029693.3380.10.camel@raven.themaw.net>
References: <200702200718.l1K7Ixlk029511@raven.themaw.net>
	<1172005006.21431.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1172005006.21431.10.camel@localhost>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Tue, 2007-02-20 at 21:56 +0100, Lukas Kolbe wrote:
> On Di, 2007-02-20 at 16:18 +0900, Ian Kent wrote:
> > Hi all,
> > 
> > There will always be bugs and the line must be drawn at some point and a
> > release issued and that time is now.
> > 
> > This release is an important milestone for autofs. At last we are at a point
> > where can expect Linux autofs to function in a multi-vendor environment
> > without having to maintain separate configurations. This was no easy task
> > and was made possible by the help and patience of many people, thank you
> > all.
> 
> Cool! 
> We just installed it on our mailserver. Sorry for lack of updates on
> that thread, I'll get to it later.

No problem.

> 
> The thing we noticed is that autofs5 doesn't seem to support the
> "-symlink"-option anymore, is that correct? For local automounted
> directories, it now always uses bind mounts.

I'll check but I must admit that I've been working with the assumption
that we don't need symlinking anymore so if it's broken it is a
consequence of the new development and I'd rather not fix it. 
 
> 
> This is not really a problem, because our stress-test revealed that the
> race-condition is not there anymore, so 1000+ simultanous bind-mounts,
> umounts and remounts work flawlessly (for stress-testing purposes I set
> the automount timeout to 2 seconds), unless you manually and massively
> unmount the directories - this leads to a race-condition in mount(8),
> because it doesn't seem to lock /etc/mtab correctly. If I leave
> automount alone and don't fuss with the mounts, everything works!

Cool, that's great to hear.
I expect, as always, we will have a few new bug reports as new people
try the release out so 5.0.2 is probably where we want to be. That's
always the way though.

Ian
