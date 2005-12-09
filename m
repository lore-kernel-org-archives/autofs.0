From: Ian Kent <raven@themaw.net>
Subject: Re: disable-mount-locking patch
Date: Fri, 9 Dec 2005 08:43:18 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0512090842400.26935@wombat.indigo.net.au>
References: <Pine.LNX.4.62.0512080954130.22388@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0512080954130.22388@gate.nmr.mgh.harvard.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Raines <raines@nmr.mgh.harvard.edu>
Cc: autofs@linux.kernel.org

On Thu, 8 Dec 2005, Paul Raines wrote:

> 
> Where can I get the disable-mount-locking patch for 4.1.4?  And
> the patch for mount?
> 
> The locking is an absolute killer for me.  One user on a big interactive 
> server accessing a mount on a down box causes every other user accessing 
> perfectly valid mounts to have their accesses fail (giving the aquire_lock 
> error in the log) while the first mount takes forever to timeout.

I'll have a look and see if I can find it.

Ian
