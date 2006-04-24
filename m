From: Ian Kent <raven@themaw.net>
Subject: Re: Problem between autofs 3 and autofs4
Date: Mon, 24 Apr 2006 10:30:53 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0604241030210.3106@raven.themaw.net>
References: <042320061324.20487.444B800C000C9242000050072207020653969B0E099D0A@comcast.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <042320061324.20487.444B800C000C9242000050072207020653969B0E099D0A@comcast.net>
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
To: autofs mailing list <autofs@linux.kernel.org>

On Sun, 23 Apr 2006, ergatz@comcast.net wrote:

> I tried all sorts of things, to include autofs reload, autofs stop and start, ypbind stop and start.
> The only thing that would work was too reboot the machine.  Rebooting a SERVER is not
> really something I want to do when I make changes.

Oh and you think I don't realize that!

> 
> One of the guys in the office found an updated version of autofs.  I installed it, and everything
> works like a charm.  

What version?

> 
> A commentary:  I found somewhere that autofs 4 was written by someone who did not write
> autofs3.  In fact, the author of 3 said he would like to come back to write 5.  It seems the author
> of 4 did not know as much about autofs as he should have to write properly functioning code.

Who are you talking about.
All this happened a very long time ago.

Perhaps "me" since I took over the v4 maintenance several years ago and 
4.1.3 is one of my releases.

The fact is that what you have should work and if it's been broken by the 
addition of a patch then we need to identify which patch that is.

You should also consider the fact that changes to the package are often 
driven by requests for functionality on this list. I don't always get that 
right but I try.

You might also have a look at the CHANGELOG in 4.1.4.
The list of bugs fixed is so long that I didn't have any time to work on 
developing things that really need doing.

Previous to my current job at RedHat I worked as an infrastructure analyst 
at a Solaris site. Very demanding of time as you likely realize and then 
would go home and try to work on autofs.

That was really hard.

> 
> Just one of my many frustrations with RedHat and open source....

How is RedHat responsible for my mistakes?

Another fact is that there are many devoted people at RedHat that try to 
fix breakage in my packages (including me) and they have a difficult time 
to be sure.

On a lighter note I must apologize (to everyone) for not being more 
helpful on the list lately but I'm heavily focused on version 5 
development (which no doubt will not work properly either, ha).

Ian
