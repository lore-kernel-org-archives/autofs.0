From: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Subject: Re: autofs {3, 4,
 5} and bind mounts which point to other automount points
Date: Fri, 25 Aug 2006 17:19:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0608251710580.17316@frank.dcs.qmul.ac.uk>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk> 
	<1156517163.30971.45.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608251546430.14075@frank.dcs.qmul.ac.uk>
	<1156521300.31377.3.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1156521300.31377.3.camel@raven.themaw.net>
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

At 23:55 +0800 Ian Kent wrote:

> I think I know why this isn't working.
> It's due to the conversion to a threaded model.
> And I fairly sure it can't work within v5 if we don't make changes.
> It's actually quite difficult.

I appreciate this--thanks for taking the time to understand it :)

> Basically, the daemon doesn't ever trigger a mount itself and since
> there is only one daemon now you can't cause a mount to happen in
> another mount point.

Yes.. (that's why the accept() patch doesn't help); it may need some kind 
of ability to recurse.

For bonus points, the following scenario is a quick route to a nasty 
deadlock in autofs{3,4}: /a/1 binds to :/b/2; /b/2 binds to :/a/1. Having 
some kind of cycle-detection might prevent some difficult-to-diagnose 
crashes. (It happened to us..)
