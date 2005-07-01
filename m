From: Ian Kent <raven@themaw.net>
Subject: Re: Cached NIS map?
Date: Fri, 1 Jul 2005 13:50:17 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0507011335240.26508@wombat.indigo.net.au>
References: <Pine.LNX.4.61.0506301010100.19272@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0506301010100.19272@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

On Thu, 30 Jun 2005, Jim Carter wrote:

> This is seen with autofs-4.1.3.  I'm using a NIS map with this command 
> line:
>     /usr/sbin/automount /home yp auto.home
> ypmatch -k mathtest auto.home says: mathtest julia:/h1/maint/mathtest
> /home/mathtest cannot be mounted (i.e. any access returns "no such file or 
> directory"), whereas other users on the same host can.  If the above 
> automount process is killed and restarted (or the client is rebooted,  
> same thing), /home/mathnet can then be mounted normally.

4.1.3 without patches doesn't see updates unless you send it a HUP signal.
OTOH if the name and path dosn't change and the mount has been 
umounted it should work OK except for local host name caching in the 
resolver or by nscd. If the mount is not umounted you will surely get 
error messages or not be able to umount the mount. You may need to do a
umount -l on the offending mount.

I'm completely stumped by some people being able to mount the same mount 
and others not? Except of course if they actually trying to mount 
different mounts (ie. different user).

The issue should be whether the mount is present on the client before the 
change, leading to not being able to umount it and hence not being able to 
mount the new mount.

> 
> During the life of the automount process, the mathtest account (and a 
> number of others, which also were affected) were moved from a differently 
> named machine, and it's quite possible that the automounter on the affected 
> clients mounted the old homedir at some time. On the other hand, some 
> homedirs that were mounted normally were moved to a new machine with the 
> same name but a different IP address.  To make this clear:
> 
>     State	Hostname	IP		Users on Server
>     Before	julia		128.97.4.254	maggie
>     Before	sonia		128.97.4.247	mathtest
>     After	julia (new)	128.97.4.6	mathtest, maggie
>     After	oldjulia	128.97.4.254	(none)
> 
> /home/mathtest could not be mounted until a restart; /home/maggie could.
> 
> But to make matters more obscure, four clients could not mount 
> /home/maggie, of which one *could* mount /home/mathtest, and it is almost 
> but not quite beyond imagination that any of them might have ever tried to 
> mount /home/maggie before.  Restarting automount brought back both 
> homedirs.
> 
> I'm wondering if the NIS map row is cached by automount with a very long 
> timeout.  Or if anyone else recognizes the symptoms.  We're going to be 
> moving a lot of users over the summer, and it looks like we're going to 
> have to restart the automounter frequently.

Yes it is cached and basically never times out.
Recognising map changes was the subject of heaps of work toward 
4.1.4. Seems to work OK.

Ian
