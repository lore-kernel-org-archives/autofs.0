From: raven@themaw.net
Subject: Re: mount point created if automount map is empty during
 daemon startup?
Date: Tue, 4 May 2004 23:37:29 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405042334080.17014@donald.themaw.net>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<20040503175506.GA14889@sun.com>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504010928.GL14889@sun.com> <20040504122536.GK5041@neu.nirvana>
	<Pine.LNX.4.58.0405042248180.17014@donald.themaw.net>
	<4097B610.6090405@freescale.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4097B610.6090405@freescale.com>
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
To: Tom Georgoulias <tom.georgoulias@freescale.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 4 May 2004, Tom Georgoulias wrote:

> raven@themaw.net wrote:
> 
> > Can you try killing and then starting that automount process by hand.
> 
> There wasn't any daemon running for that mount, so I started it by hand 
> and the mount is now functional.
> 
> I'm really confused as to why there wasn't a daemon running in the first 
> place.  There should've been, right?  I just checked a second system 
> where this was an issue and it is the same, not automount running for 
> /sync.  Starting it manually also gets the mount working.

Yes, I check it. See my last post on this.

We'll leave this to the people on the list to decide whether this 
behaviour should be changed.

Ian
