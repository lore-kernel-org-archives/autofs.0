From: Ian Kent <raven@themaw.net>
Subject: Re: Very good the patches.
Date: Thu, 12 Jun 2008 20:48:50 +0800
Message-ID: <1213274930.4994.114.camel@raven.themaw.net>
References: <4850D72C.8000301@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4850D72C.8000301@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org


On Thu, 2008-06-12 at 09:58 +0200, Stef Bon wrote:
> Hello,
> 
> thanks for the patches.
> 
> I experienced some problems with my construction on autofs managed 
> network maps:
> 
> - still problems on not wanting to run when auto.master file is empty, 
> and the included /var/run/autofs.auto.master is not found
> - unmounting everything when sutting down with the signal USR2 (and 
> compiled with the enable-forcesd-shutdown) does not what it's supposed to do
> - when I've got two networks, I've got two toplevel directories on my 
> mountpoint. When both are expired and there are no mounts, one will 
> disappear. This is not what I want. The best for my construction is that 
> the toplevel directories (for example "Windows Network" and "SSH hosts")
> will remain.
> 
> 
> Well anyway,
> 
> I'll try the patches. Can I actually apply them? I've been looking in 
> the source, and the latest patch is from may...

Are you referring to the patches I posted for Jim Carter today.
They are for him for testing.

If I remember I mentioned I should be able to fix the problem of the
empty master map fairly easily but I haven't finished the dependent work
on that yet (the current patches are still in test).

I've got my hands full still so you'll need to wait a bit longer.

Ian
