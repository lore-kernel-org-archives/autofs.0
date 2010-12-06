From: Ian Kent <raven@themaw.net>
Subject: Re: I have some patches for the autofs-4.x daemon - what
 to do with them?
Date: Mon, 06 Dec 2010 09:11:04 +0800
Message-ID: <1291597864.9376.5.camel@perseus>
References: <AANLkTinCncue4d-g_c0fSF1smE3i8cT-GT+w-eDygGPF@mail.gmail.com>
	<1291350420.3062.12.camel@perseus>
	<AANLkTimUAegMdD0kdAdK4Bb44NOpaNxAUZQcN5t7XpD-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <AANLkTimUAegMdD0kdAdK4Bb44NOpaNxAUZQcN5t7XpD-@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Bill Ryder <bill.ryder.nz@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2010-12-06 at 13:34 +1300, Bill Ryder wrote:
> 
> 
> On Fri, Dec 3, 2010 at 5:27 PM, Ian Kent <raven@themaw.net> wrote:
>         On Wed, 2010-12-01 at 11:07 +1300, Bill Ryder wrote:
>         > Where should I submit those?
>         >
>         >
>         
>         
>         
>         Probably, but it might be good for me to create a directory on
>         kernel.org and save them their, but a readme with applicable
>         version and
>         usage information would probably make sense.
> 
> 
> OK. How about if I break out the patches against 4.1.4
> against ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4
> 
> 
> I'll try to make the changelog detailed enough in each patch so it's
> clear what it does.

OK, so lets work through that.


snip ...

>         
>         I understand your need for segregation but it would be good to
>         get v5 to
>         a state where this isn't a problem for you any more.
> 
> 
> Yeah. 
> 
> 
> When I last looked (which was admittedly last year now) I was looking
> for a way to restart the thread responsible for a particular map if it
> had crashed or just needed a poke or if I wanted to change the ldap
> query it was using.  At that time I couldn't even find a way to easily
> see which thread owned which map. Let alone start up one map with a
> hand rolled ldap string.
> 
> 
>         
>         Tell me more about the "take out every single map" problem.
>         With current
>         v5 you should be able to just start it up again and your
>         mounts should
>         continue to function. The problem of course come when you have
>         a
>         non-responsive server, then you end up re-connecting to
>         non-responsive
>         mounts. Of course, there is still a time where new mounts
>         cannot be made
>         until the startup.
> 
> 
> 
> 
> As I understand it a core dump will take the autofs-5 daemon and all
> of it's threads down. 

Yep.

> 
> 
> So existing mounts will continue to function but any request requiring
> a new mount will not.

And, yep.

> 
> 
> With a process per map  you only lose one map - not all of them - if
> it should crash.

Now that I think about it we had a request similar to this a while ago.
I'm not sure about it now, I'll need to look through the history, but
you may be able to start multiple autofs instances, each using their own
master map. That's essentially what you want I think. There were a few
problem at the time, which were fixed I think, and there may be new
problems with it now. But it should be able to be done.

> 
> 
> We run a lot of checkers that will bring up individual broken maps.
> This used to be a constant thing with 4.1.3 but 4.1.4 is much more
> stable.
> 
> 
> Also sometimes when I'm testing things I'll want to start up a map
> with special options (ldap filter usually) but leave the other maps
> alone.
> 
> 
> As I see it the problem with the multithreaded automounter is all the
> functionality you get for free from linux (starting individual
> processes for each map, looking at which process owns which mount
> points by looking at ps, and so on) you need to code for explicitly in
> autofs 5. 
> 
> 
> 
> 
>  
>         
>         >
>         >
>         > The main work I've done is to build in retrying mounts
>         depending on
>         > the errors returned by mount (with our client count we
>         overload our
>         > fileservers often which causes retryable errors, and
>         sometimes a
>         > client will try to mount 100 or so mount points in a very
>         short amount
>         > of time which causes some tcp client port exhaustion - which
>         is also
>         > retryable).
>         
>         
>         So you can't export to allow clients to use insecure ports?
> 
> 
> I could do this but we have around 30 'normal' fileservers (netapps)
> and a lot (> 100) virtual NFS servers on 4 clusters which are more
> painful to administer. And of course the way to specify secure vs
> insecure is different.
> 
> 
> And since I already have retry code in place to handle overloaded
> fileservers  this was an easy - if ugly -  workaround (which hopefully
> we won't need anymore because we've changed some things which created
> these little storms). It was rare but it did happen. 
> 
> 
> For our work it's better if a mount hangs for a while rather than
> failing and returning a path not found to the application.
> 
> 
> The big fault with my retry code is I look at a set of compiled in
> strings of errors that are retryable. Very painful when you just want
> to add one more error message. Ideally I'd read a file with the list
> of retryable errors in it when automounter starts up.
> 
> 
> Bill
> 
> 
> 
> 
