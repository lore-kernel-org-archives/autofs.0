From: Ian Kent <raven@themaw.net>
Subject: Re: Linux+Solaris - NIS auto.master versus autofs5
Date: Sat, 22 Dec 2007 17:28:25 +0900
Message-ID: <1198312105.3114.71.camel@raven.themaw.net>
References: <753ec7300712211400g3eb45b21n1f236fe7056f87a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <753ec7300712211400g3eb45b21n1f236fe7056f87a1@mail.gmail.com>
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
To: David Mack <davidwmack@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 2007-12-21 at 14:00 -0800, David Mack wrote:
> I work in an environment in which Solaris and Linux machines NIS mount
> the same automount maps, including auto.master. Typically,
> /etc/auto.master just contains "+auto.master" on all of them.

That should work fine.

> 
> With the advent of autofs5, this has started breaking. To get the
> Linux machines running autofs5 to work, we've had to replace
> /etc/auto.master with a version that looks something like this:
> 
> /volume yp:auto.vols
> /system yp:auto.home
> /local yp:auto.local
> /homes yp:auto.homes
> /home yp:auto.home
> /xfn -xfn
> /net -hosts             -nosuid

Using the map type syntax is very version 4 and shouldn't be needed at
all by version 5.

> 
> The NIS version (used by Solaris and older Linux machines) looks like this:
> 
> /volume auto.vols -intr,bg,tcp
> /system auto.home
> /local auto.local
> /homes auto.homes -intr,bg,tcp
> /home auto.home
> /xfn -xfn
> /net -hosts             -nosuid
> 
> 
> Needless to say, I'm not wild about having to install a separate
> /etc/auto.master on every new Linux machine.

And you shouldn't have to.

> 
> It appears that the problem is that autofs5 doesn't like parameters
> introduces with hyphens in auto.master, which Solaris unfortunately
> requires.

OK, I don't think that's correct.
Perhaps it has been fixed over time and I missed that I fixed it.

It is true that the man page specifies no "-" but I believe it is
accepted and works.

How about more information.
What version are you using?
How about a debug log?

Ian
