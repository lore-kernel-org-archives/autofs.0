From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: 
	mount point created if automount map is empty during daemon startup?
Date: Tue, 4 May 2004 11:05:24 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16535.45364.767370.38110@segfault.boston.redhat.com>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<Pine.LNX.4.58.0405032046130.3257@donald.themaw.net>
	<20040503175506.GA14889@sun.com>
	<20040504003214.GA31852@neu.nirvana>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504122536.GK5041@neu.nirvana>
	<4097AABF.5050709@freescale.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4097AABF.5050709@freescale.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Tom Georgoulias <tom.georgoulias@freescale.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding [autofs]  mount point created if automount map is empty during daemon startup?; Tom Georgoulias <tom.georgoulias@freescale.com> adds:

[snip]

tom.georgoulias> * Thu Mar 18 2004 Jeff Moyer <jmoyer@redhat.com> -
tom.georgoulias> 1:4.1.1-3

tom.georgoulias> - Fix bug in get_best_mount, whereby if there is only one
tom.georgoulias> option, we choose nothing.  This is primarily due to the
tom.georgoulias> fact that we pass 0 in to the get_best_mount function for
tom.georgoulias> the long timeout parameter.  So, we timeout trying to
tom.georgoulias> contact our first and only server, and never retry.

Ugh, skeleton is out of the closet.  ;-P  To clarify, I only saw this when
the map was an LDAP map (which I thought should make absolutely no
difference).  This patch is actually just a work-around.  I was hoping to
track down the real issue later...

-Jeff
