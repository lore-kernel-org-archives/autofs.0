From: Ian Kent <raven@themaw.net>
Subject: Re: Re: [patch] make autofs understand the -[no]browse
 option
Date: Wed, 24 Nov 2004 09:28:58 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0411240921090.28302@wombat.indigo.net.au>
References: <16793.2017.226139.516137@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0411160853060.9913@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411160853060.9913@wombat.indigo.net.au>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 16 Nov 2004, Ian Kent wrote:

> On Mon, 15 Nov 2004, Jeff Moyer wrote:
> 
> > Hi, Ian, list,
> > 
> > The patch below makes the Linux automounter a bit more compatibile with the
> > Sun automounter, by parsing the -[no]browse options, and converting them
> > into the equivalent --ghost option.
> > 
> > Ian, I've not made this patch against vanilla 4.1.3.  This is the patch
> > that went into the Red Hat RPM.  I will generate a diff to whatever version
> > you like, but I didn't want to do extra work since your tree may be quite
> > different from 4.1.3 at this point.
> 
> Quite likely.
> 
> Doesn't look to complicated. I might do it by hand if needed.

I've tried to apply this but it appears to depend on a previous patch.
It's one of the few patches that remain outstanding for 4.1.4.

I didn't spend long on it. When I saw some stuff I didn't recognise in the 
init script I put it on the "get back to it list".

If you get a chance to create a diff againt the current code that would be 
good otherwise I'll get back to it after I've done the straight forward 
stuff.

Ian
