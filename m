From: raven@themaw.net
Subject: Re: backfstype parameter supported.
Date: Tue, 29 Jun 2004 22:03:27 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406292140380.14746@donald.themaw.net>
References: <40E1632D.1080903@deragon.biz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40E1632D.1080903@deragon.biz>
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
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

On Tue, 29 Jun 2004, Hans Deragon wrote:

> Greetings.
> 
> 
>   Newbie with automount.  Its been a week I tried to communicate with H. Peter
> Anvin at hpa|at|zytor.com but never received any answer.  I then found this
> mailing list.

I think Peter is a very busy man.

In any case he's happy for me to handle the autofs maintenance.

> 
>   cachefs is not supported by Linux.  In a mix Solaris/Linux environment,
> where NIS is provided by Solaris, many yp maps specify cachefs as the
> filesystem, but backfstype is set to nfs.  Automount does not support backfstype.
>

Yes. Handling unknown options is a headache and needs attention.

I haven't been able to work on this at all and I haven't really 
thought a great deal about how we can handle it in a clean way.
 
>   Here is a exert of an entry:
> 
> .. fstype=cachefs,cachedir=<dir>,backfstype=nfs ...
> 
>   I changed the code and now I have a modified 4.1.3 version which tries for
> the filesystem defined with "fstype" and if this fails, "backfstype" is then
> tried.  It works.
> 
>   My patch is not perfect though.  While trying "cachefs", modprobe errors
> shows up in /var/log/messages.  Until backfstype also fails, ideally no error
> message should be emitted.  Maybe there is a way to test for the existance of
> the kernel module before actually try to load it, thus avoiding error messages.

Those messages are difficult to eliminate as they often come from 
mount(8) itself.

> 
>   Altough I am a programmer, I do not program in C and do know pratically
> nothing about system calls.  I would like my patch to be accepted in the main
> branch and that someone experienced with autofs clean it up.
> 
>   Please comment.  I would be glade to send you the patch, but first I have to
> read "man patch" to figure out how to generate one. :)  Its a pretty small
> change to the code.

Certainly, send the patch over.

But please be aware that I can't say when I will merge it.
There's a backlog. I've had some patches for ages and when I start work on 
them I seem to get side tracked onto bug fixes and the like.

Fact is if it looks like it won't produce side effects, has no hard coded 
paths and works straight out then there's a good chance.

Bottom line is if it doesn't get merged then it's not a reflection on you 
and I would encourage you to continue to maintain your patch(es) until I 
can get to it. Unfortunately most people become to busy to keep their 
patches up to date and when I eventually ask it becomes a bit of a big job 
and the vicious cycle continues.

To make a patch I usually create a clean copy of the distribution tar and 
call it, say, autofs-4.1.3.orig. Then make another, say autofs-4.1.3 and 
make the changes to it. Then do something like

diff -Nur autofs-4.1.3.orig autofs-4.1.3 >autofs-4.1.3-my_patch.patch

Unified diffs are best please (the -u).

Ian
