From: raven@themaw.net
Subject: Re: Re: debug failed automount
Date: Mon, 2 May 2005 21:54:11 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505022150110.9314@donald.themaw.net>
References: <11101302050428071921ec8bb7@mail.gmail.com> 
	<11101302050429222770e0df9d@mail.gmail.com>
	<Pine.LNX.4.62.0504302318540.2229@donald.themaw.net>
	<Pine.LNX.4.62.0505012144150.2824@donald.themaw.net> 
	<1110130205050116184381a11e@mail.gmail.com>
	<Pine.LNX.4.58.0505020959430.8040@wombat.indigo.net.au>
	<11101302050501195219712615@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <11101302050501195219712615@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Robert Swan <rswanster@gmail.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sun, 1 May 2005, Robert Swan wrote:

> On 5/1/05, Ian Kent <raven@themaw.net> wrote:
>> On Sun, 1 May 2005, Robert Swan wrote:
>>
>
>>> Is there a way to attach a debugger to the automount process that gets
>>> spawned when the kernel attempts an automount?
>>
>> Nothing that will help in this situation.
>> All the mount/umount is done in userspace by the daemon.
>
> I couldn't figure out how to attach to the user space code either.
> I.E. I wanted to step through get_best_mount() but wasn't able; still
> would like to know how to do that.

That's a bit hard.
There are a couple of reasons. First lots of stuff is done in 
sub-proccesses, second the exe is usually a position independent exe.

I haven't got around to fixing the debug compile options to see if I can 
remedy that.

But then I do all my debuging with debug prints.

Have you tried the patch?

Ian
