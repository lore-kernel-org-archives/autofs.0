From: Stew Smith <stew.smith@sun.com>
Subject: Re: [announce] Autofs NG 0.1
Date: Wed, 29 Sep 2004 16:16:41 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040929231641.GC29260@crashy.west.sun.com>
References: <4154C0F2.708@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <4154C0F2.708@sun.com>
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
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org, thockin@hockin.org, raven@themaw.net

On Fri, Sep 24, 2004 at 08:50:58PM -0400, Mike Waychison wrote:
> 
> Hi folks,
> 
> Some of you may remember my posting of a new way to do autofs in Linux a
> while back:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107341940326348&w=2
> 
> Anyhow,  I've gotten to the point where I have code that people can play
> with.  I've posted it all at http://autofsng.bkbits.net
> 
> There are two repos located there, one is the userspace bits (autofsng).
> ~ It has the 'utility' (automount) and the autofs usermode agent
> (autofs).  This tree began as a automount 3.1.7 tree, but has
> drastically changed.  Lots of good stuff has yet to be merged in from
> the automount 4 daemon.
> 
> The kernel bits are in the linux-2.6-autofsng repository.   Broken out
> patches are forthcoming in the next (weeks?) [*].  It has the following
> major changes to it:

autofsng userland tarball and kernel patch can now be found
here for non-bitkeeper users:

ftp://ftp-eng.cobalt.com/pub/users/ssmith/autofsng/

thanks,

--
Stew Smith
