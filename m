From: Tom Georgoulias <tom.georgoulias@freescale.com>
Subject: Re: mount point created if automount map is empty during
 daemon startup?
Date: Tue, 04 May 2004 10:43:29 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4097BA21.5060307@freescale.com>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<Pine.LNX.4.58.0405032046130.3257@donald.themaw.net>
	<20040503175506.GA14889@sun.com> <20040504003214.GA31852@neu.nirvana>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504010928.GL14889@sun.com> <20040504122536.GK5041@neu.nirvana>
	<4097AABF.5050709@freescale.com>
	<Pine.LNX.4.58.0405042248180.17014@donald.themaw.net>
	<4097B610.6090405@freescale.com>
	<Pine.LNX.4.58.0405042334080.17014@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405042334080.17014@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

raven@themaw.net wrote:

> We'll leave this to the people on the list to decide whether this 
> behaviour should be changed.

Well, from our point of view, it is nice to be able to create maps that 
are empty at first and not have to worry about populating them until 
later.  This gives us our group the flexibility to plan out in advance 
how our mounts will look, put the necessary mount points in place during 
the regular maintenance intervals (by rebooting the systems, something 
we can't always do), and adding map entries later on as the data is 
moved to the new location.

Just my two cents.

Tom

-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Freescale Semiconductor Internal Use
[] Freescale Semiconductor Confidential Proprietary
