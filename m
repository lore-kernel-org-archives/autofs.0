From: Ian Kent <raven@themaw.net>
Subject: Re: Please help - cleanup
Date: Fri, 7 May 2004 09:50:25 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405070949330.6274@wombat.indigo.net.au>
References: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
	<Pine.LNX.4.58.0405042233560.17014@donald.themaw.net>
	<16535.44980.475389.900686@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0405042308070.17014@donald.themaw.net>
	<409A4C04.1060604@freescale.com><409A6220.80403@freescale.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <409A6220.80403@freescale.com>
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

On Thu, 6 May 2004, Tom Georgoulias wrote:

> Chris Croswhite wrote:
> > I ran this on 40 clients last evening through our normal regression runs
> > (9 hours, 1.5T of data, 127 mount points) and found that it behaved as
> > expected.
> 
> I should clarify, the mount dropping problem I mentioned in my last 
> message is not specifically related to testing autofs-4.1.2-5 (or any 
> 4.1.2, I think).  I've got 4.1.1 rolled out and those systems are the 
> ones dropping mounts, at least at this point in time.  My intention is 
> to find a autofs release or set of patches that fixes this behavior 
> sooner rather than later as it is causing problems for my users.
> 
> Just for my sanity, can anyone help me confirm the following "facts" 
> about earlier behavior of the autofs-4.1.0pre10 release:
> 
> 1.  NIS maps were not cached by the automounter daemon
> 2.  changes made to the maps and pushed out went into effect 
> immediately, regardless of whether or not the changes were new key/mount 
> entries to an existing map or just changes to existing key/mount pairs 
> withing an existing map.

So your machines are not droping mounts. They just don't know about them, 
right.

Ian
