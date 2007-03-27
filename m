From: Jarl Stefansson <jarl@marimo.is>
Subject: Re: Unmount not working with 2.6.21  & 4.1.3/4.1.4
Date: Tue, 27 Mar 2007 15:10:52 +0000 (GMT)
Message-ID: <24399709.7011175008252093.JavaMail.root@holcus>
References: <1175007141.3499.4.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1175007141.3499.4.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hey Ian,

Here is a list of the processes running:

http://pastebin.ca/412160

Jarl 


----- Original Message -----
From: Ian Kent <raven@themaw.net>
To: Jarl Stefansson <jarl@marimo.is>
Cc: jmoyer@redhat.com, autofs@linux.kernel.org
Sent: Tuesday, March 27, 2007 2:52:21 PM GMT Africa/Casablanca
Subject: Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4

On Tue, 2007-03-27 at 10:32 +0000, Jarl Stefansson wrote:
> Hey Jeff,
> 
> Here is the debug log when set to 60 sec
> 
> http://pastebin.ca/411870

Unfortunately, that hasn't helped.
Version 4 doesn't log the pid of the process accessing the mount point,
so we still don't know what's causing this.

Do you have hald running?
Does this behavior change after an hour or so?

Are there many processes running?
If not perhaps a list of them would help.

> Jarl 
> 
> 
> ----- Original Message -----
> From: jmoyer@redhat.com
> To: Jarl Stefansson <jarl@marimo.is>
> Cc: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org
> Sent: Monday, March 26, 2007 7:29:18 PM GMT Africa/Casablanca
> Subject: Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4
> 
> ==> Regarding Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4; Jarl Stefansson <jarl@marimo.is> adds:
> 
> jarl> Hey Jeff, Yes, I am 100% sure that there is nothing using the mounted
> jarl> filesystems.  For debugging I have a system with just bare minimals,
> jarl> kernel + glibc + base utilities so there really aren't any
> jarl> applications which can interfere.
> 
> jarl> According to what I have read I should also be getting some debug
> jarl> info in the log regarding the timeout period but I can't see any
> jarl> mention of timeout or unmount.
> 
>   Mar 26 01:33:54 kidsq daemon.debug automount[3626]: expire_proc: 1 remaining in /mnt/auto 
> 
> This means that (in your case) the kernel thought that the mount point was
> in use.  Could you humor me and up the timeout to something like 60 seconds
> and see if that helps matters?
> 
> Thanks,
> 
> Jeff
> 
