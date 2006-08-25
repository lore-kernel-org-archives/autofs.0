From: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Subject: Re: autofs {3, 4,
 5} and bind mounts which point to other automount points
Date: Fri, 25 Aug 2006 14:22:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0608251417500.14075@frank.dcs.qmul.ac.uk>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net>
	<Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608251506180.25004@raven.themaw.net>
	<Pine.LNX.4.64.0608251917030.30523@raven.themaw.net>
	<Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk>
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

At 14:09 +0100 Matt Bernstein wrote:

> At 19:18 +0800 Ian Kent wrote:
>
>> Could you try this patch please.
>
> Thanks.. now my messages are slightly different (though it still fails).
>
> Aug 25 14:07:19 laurel automount[17416]: attempting to mount entry /homes/mb
> Aug 25 14:07:19 laurel automount[17416]: mount(nfs): nfs: mount failure :/home/cream/home71/mb on /homes/mb
> Aug 25 14:07:19 laurel automount[17416]: failed to mount /homes/mb

Actually, this only happens when the target isn't already mounted. It does 
perform a bind mount if there's something to bind to. Now what we need to 
do (I think) is tickle the target in case it's another automount point, a 
la our-bad-patch-for-autofs4.
