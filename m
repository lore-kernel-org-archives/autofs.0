From: Ian Kent <raven@themaw.net>
Subject: Re: Need help w/ autofs application
Date: Wed, 28 Jan 2009 12:33:43 +0900
Message-ID: <1233113623.3005.25.camel@zeus.themaw.net>
References: <alpine.DEB.2.00.0901271826510.7987@duo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.DEB.2.00.0901271826510.7987@duo>
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
To: Steven Hirsch <snhirsch@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 2009-01-27 at 18:50 -0500, Steven Hirsch wrote:
> All,
> 
> I have a situation where I need a functional autofs directory in a 
> chroot'ed environment.  Unfortunately, this is turning out to be quite a 
> challenge and I don't fully understand some of what I've observed.
> 
> After thrashing around with bind mounts for the better part of a day, I 
> became convinced that it was not possible to have the primary /net 
> directory in the root environment appear also in the chroot session.
> 
> The only thing that seems to work is having a second instance of automount 
> active.  However, I cannot find any way to start this prior to the chroot 
> session and still have it be active there.  For example, I have an 
> installation of Ubuntu Hardy 32-bit under /var/chroot/hardy.  I use 
> 'schroot' to setup and manage the sessions.  When started, it creates a 
> unique directory under /var/lib/schroot (using a hashed session id as the 
> name), bind-mounts /var/chroot/hardy at that location and makes it the new 
> root of the filesystem.  Some of the system directories, such as /dev are 
> also bind-mounted at the same time.  As a last step, it drops privileges 
> and presents me with a shell running under my own user id.
> 
> I have tried starting a second automount daemon targeting, e.g. 
> /var/chroot/hardy/net or /var/lib/schroot/<session_key>/net ahead of time. 
> It is functional to the root environment, but simply does not appear in 
> the chroot session.  The directory is there, of course, but it does not 
> have autofs mounted on it.
> 
> Finally, I tried starting autofs manually inside the chroot session (using 
> sudo to gain root permissions).  This worked.  Next step was to automate 
> the autofs startup.  That's where the real weirdness begins:  I hacked the 
> equivalent of run-parts into schroot (using other code that was there for 
> pre-chroot setup) to startup autofs as root before presenting the initial 
> shell.  For reasons I cannot understand, this simply will not work for the 
> base case where I want to gain a shell in my home directory (NFS mount). 
> The daemon reports a successful status code for startup, but when schroot 
> tries to change to, e.g. /net/my_home_directory before presenting the 
> shell it fails with "directory does not exist" and dumps me in '/' 
> (relative to the chrooted environment).  Sure enough, the autofs directory 
> is not there and the daemon is not running.
> 
> After trying just about everything, I discovered that if had the shell 
> commence in a directory not under the autofs mount point (e.g. /home/junk) 
> the mount point _was_ there and NFS mounts could be properly triggered 
> when I manually typed "cd".  No amount of effort would let me simply go 
> directly there.
> 
> The question is this:  WHAT is going on with the autofs startup that 
> requires me to first end up in location outside of it before it will work? 
> Thinking it might be a race, I started experimenting with sleep calls to 
> give autofs a chance to initialize before trying to move into it.  No 
> dice.  Whether I wait 2 seconds or a minute, the results were the same.
> 
> The schroot maintainer is mildly convinced that there must be an easier 
> way to get automount working in the chroot and I tend to agree.  Does 
> anyone have any advice?

Collect some debug logs of the different things you've tried and we'll
see if we can work out what is happening. Versions or autofs and kernel
could be useful. 

See http://people.redhat.com/jmoyer for info.

> 
> Steve
> 
> 
