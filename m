From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] automount does not close file descriptors at start
Date: Mon, 21 Feb 2005 12:57:22 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502211244540.9892@wombat.indigo.net.au>
References: <20050216125350.GA6031@uio.no>
Mime-Version: 1.0
In-Reply-To: <20050216125350.GA6031@uio.no>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Wed, 16 Feb 2005, Steinar H. Gunderson wrote:

> Hi,
> 
> My latest autofs package for Debian (4.1.3+4.1.4beta2-1) had problems
> installing, freezing after install; I've worked around this now
> (4.1.3+4.1.4beta2-2 is on its way up to the archive), but I've been told this
> is really a bug in automount. What I've been told is along the lines of:
> 
> "Any daemon going into the background should close all file descriptors from
> zero up to MAXFDS minus the ones it actually wants to have open."
> 
> In other words, one should probably have a for loop of sorts in
> become_daemon().

Steinar, I'm still wondering where this came from?

This is the first time I've heard this and the first time I wrote a Unix
daemon was fifteen years ago.

As far as I'm concerned redirecting stdin, stdout and stderr to the null 
device, then closing it and setting the process to a be the group leader 
(as autofs does) should be all that's needed to daemonize a process.

So are we saying that we don't trust the kernel to reliably duplicate the 
state of file handles when we fork?

If that's the case then the kernel is badly broken and needs fixing, not 
autofs!

Ian
