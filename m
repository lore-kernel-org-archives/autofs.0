From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: [ANNOUNCE] autofs 5.0.1 release
Date: Tue, 20 Feb 2007 21:56:46 +0100
Message-ID: <1172005006.21431.10.camel@localhost>
References: <200702200718.l1K7Ixlk029511@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200702200718.l1K7Ixlk029511@raven.themaw.net>
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
To: autofs@linux.kernel.org

On Di, 2007-02-20 at 16:18 +0900, Ian Kent wrote:
> Hi all,
> 
> There will always be bugs and the line must be drawn at some point and a
> release issued and that time is now.
> 
> This release is an important milestone for autofs. At last we are at a point
> where can expect Linux autofs to function in a multi-vendor environment
> without having to maintain separate configurations. This was no easy task
> and was made possible by the help and patience of many people, thank you
> all.

Cool! 
We just installed it on our mailserver. Sorry for lack of updates on
that thread, I'll get to it later.

The thing we noticed is that autofs5 doesn't seem to support the
"-symlink"-option anymore, is that correct? For local automounted
directories, it now always uses bind mounts.

This is not really a problem, because our stress-test revealed that the
race-condition is not there anymore, so 1000+ simultanous bind-mounts,
umounts and remounts work flawlessly (for stress-testing purposes I set
the automount timeout to 2 seconds), unless you manually and massively
unmount the directories - this leads to a race-condition in mount(8),
because it doesn't seem to lock /etc/mtab correctly. If I leave
automount alone and don't fuss with the mounts, everything works!

Well, there's no real point in this message other than to say *thank
you*, it works!

-- 
Lukas
