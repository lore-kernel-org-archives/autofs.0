From: Ian Kent <raven@themaw.net>
Subject: Re: mount point created if automount map is empty during
 daemon startup?
Date: Wed, 5 May 2004 09:08:30 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405050903590.18190@wombat.indigo.net.au>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<20040503175506.GA14889@sun.com>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504122536.GK5041@neu.nirvana> <4097AABF.5050709@freescale.com>
	<16535.45364.767370.38110@segfault.boston.redhat.com>
	<4097B8CF.9050104@freescale.com><4097FFF0.5020206@freescale.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4097FFF0.5020206@freescale.com>
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

> 
> Should I wait for the kernel module patches or just go ahead with testing?
> 
> I have set aside a Red Hat 8 system to test out the latest patches you 
> have written and want to be sure I make this test as productive as 
> possible for all.
> 
> I'm looking at either running the autofs 4.1.2 plus patches from 
> kernel.org, or Jeff Moyer's latest RPM, 4.1.2-5, and using either the 
> 04172004 kernel module patch or waiting for a new one.

It would be OK but 20040417 is a little old. I've just updated the kernel 
modules last night. I haven't made the patches yet. People kept firing of 
bug reports you know.

You won't need to wait for autofs as I will be placing them on kernel.org. 
I expect that will happen tonight (my time).

Ian
