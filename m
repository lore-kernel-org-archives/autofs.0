From: raven@themaw.net
Subject: Re: mount point created if automount map is empty during
 daemon startup?
Date: Tue, 4 May 2004 23:22:10 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405042317540.17014@donald.themaw.net>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<20040503175506.GA14889@sun.com>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504122536.GK5041@neu.nirvana> <4097AABF.5050709@freescale.com>
	<16535.45364.767370.38110@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16535.45364.767370.38110@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 4 May 2004, Jeff Moyer wrote:

> ==> Regarding [autofs]  mount point created if automount map is empty during daemon startup?; Tom Georgoulias <tom.georgoulias@freescale.com> adds:
> 
> [snip]
> 
> tom.georgoulias> * Thu Mar 18 2004 Jeff Moyer <jmoyer@redhat.com> -
> tom.georgoulias> 1:4.1.1-3
> 
> tom.georgoulias> - Fix bug in get_best_mount, whereby if there is only one
> tom.georgoulias> option, we choose nothing.  This is primarily due to the
> tom.georgoulias> fact that we pass 0 in to the get_best_mount function for
> tom.georgoulias> the long timeout parameter.  So, we timeout trying to
> tom.georgoulias> contact our first and only server, and never retry.
> 
> Ugh, skeleton is out of the closet.  ;-P  To clarify, I only saw this when
> the map was an LDAP map (which I thought should make absolutely no
> difference).  This patch is actually just a work-around.  I was hoping to
> track down the real issue later...

Saw that patch. Was a bit curious about it. Didn't add it.

I think that I discovered that the error return from get_best_mount was 
not being checked. This may have been the cause of that.

I thought that was fixed.

CHANGELOG says 4.1.2.

I think the replicated server behaviour is working OK now. Fingers 
crossed.

Ian
