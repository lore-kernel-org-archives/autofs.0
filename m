From: raven@themaw.net
Subject: Re: Infinite loop when trying to access nonexistent
	directory (auto.home '&' substitution)
Date: Sat, 16 Oct 2004 11:45:52 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410161143240.8831@donald.themaw.net>
References: <Pine.LNX.4.61.0410151425360.7091@orion.arlut.utexas.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410151425360.7091@orion.arlut.utexas.edu>
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
To: Robert Giles <rgiles@arlut.utexas.edu>
Cc: autofs@linux.kernel.org

On Fri, 15 Oct 2004, Robert Giles wrote:

> 
> I'm not sure if this is the same bug mentioned in 
> autofs-4.1.3-strict.patch.  ???

Neither am I.

> 
> Problem surfaced when I upgraded from 2.4.25 to 2.4.27, but it doesn't 
> look like there were any autofs4 changes made between 2.4.25 and 2.4.27. 
> If it makes any difference, I am using the SNARE C2 auditing patches for 
> the kernel, but I don't think those would have any impact on autofs.
> 
> I'm seeing this problem regardless of what autofs package I use (SuSE 9.0 
> autofs3, autofs4.0.0-pre10, or the latest autofs-4.1.3 + patches from 
> kernel.org).
> 
> I've upgraded util-linux to 2.12b and nfs-utils to 1.06, no luck.  Have 
> also upgraded nfs-utils server-side, no luck.
> 
> I also applied the autofs4-2.4.22-20040508.patch to 2.4.27 and haven't 
> seen any change in behavior (the autofs-4.1.3-strict.patch mentioned a 
> the kernel patch might be required if the problem didn't go away).

And at least 2 hunks in the patch failed, right?
One against fs/namei.c.

This should be the case.

Ian
