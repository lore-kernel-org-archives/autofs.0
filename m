From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Race condition in autofs 4.1.4
Date: Mon, 29 Jan 2007 21:56:25 +0100
Message-ID: <1170104185.6774.11.camel@localhost>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven> <1169835048.6781.16.camel@localhost>
	<1169861439.3595.11.camel@raven.themaw.net>
	<1170081194.2817.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170083944.2817.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170089728.3404.18.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1170089728.3404.18.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Di, 2007-01-30 at 01:55 +0900, Ian Kent wrote:
> > The system is now through more than 25000 mails, and hasn't hit the bug
> > yet.
> > When it finished delivering, I'll setup another mailbomb and stress it
> > over the night, let's cross fingers that it works. I'll then file a bug
> > with the debian util-linux package and attach the patch to it.
> > Not close()ing the "we_created_lockfile" in unlock_mtab() seems like a
> > bug to me, anyway ;)
> 
> Ya, but it gets closed at exit anyway.

Ah, of course!

I sent a mail earlier today, but it didn't come through to the list,
dunno why, hence the Cc: on you.

The bug/race hit again when the system delivered about 95% of the mail,
with a few directories in /homes/ and /nfs4homes/ that belonged to root
and were empty, with an error in syslog that said "/homes/musrXXX
already mounted" (I don't have the exact messages here, can post them
tomorrow when I'm in the office).

This was with the patch minus the typo applied. It seems that the patch
helps the situation, as it happens not that fast, but once it happens,
the directories in question cannot be mounted anymore by the
automounter.

Are there any other patches for mount floating around that I can try? I
only have tomorrow for that because we're now going to implement our
fallback configuration - a patched amd that understands our hesiod maps
and just symlinks the home directories in place. But that feels rather
not very correct ... and I'd much like to see mount fixed, because that
locking code really scares me (I'm not really a C developer, though).

> Ian

-- 
Lukas
