From: Robert Swan <rswanster@gmail.com>
Subject: Re: Re: debug failed automount
Date: Sun, 1 May 2005 22:52:42 -0400
Message-ID: <11101302050501195219712615@mail.gmail.com>
References: <11101302050428071921ec8bb7@mail.gmail.com>
	<11101302050429222770e0df9d@mail.gmail.com>
	<Pine.LNX.4.62.0504302318540.2229@donald.themaw.net>
	<Pine.LNX.4.62.0505012144150.2824@donald.themaw.net>
	<1110130205050116184381a11e@mail.gmail.com>
	<Pine.LNX.4.58.0505020959430.8040@wombat.indigo.net.au>
Reply-To: Robert Swan <rswanster@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0505020959430.8040@wombat.indigo.net.au>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On 5/1/05, Ian Kent <raven@themaw.net> wrote:
> On Sun, 1 May 2005, Robert Swan wrote:
> 

> > Is there a way to attach a debugger to the automount process that gets
> > spawned when the kernel attempts an automount?
> 
> Nothing that will help in this situation.
> All the mount/umount is done in userspace by the daemon.

I couldn't figure out how to attach to the user space code either.
I.E. I wanted to step through get_best_mount() but wasn't able; still
would like to know how to do that.

Robert

> 
> Ian
> 
>
