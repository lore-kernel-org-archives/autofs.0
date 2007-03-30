From: Ian Kent <raven@themaw.net>
Subject: Re: Unmount not working with 2.6.21  & 4.1.3/4.1.4
Date: Fri, 30 Mar 2007 20:43:24 +0800
Message-ID: <1175258604.3374.28.camel@raven.themaw.net>
References: <5761954.7251175247508702.JavaMail.root@holcus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <5761954.7251175247508702.JavaMail.root@holcus>
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
To: Jarl Stefansson <jarl@marimo.is>
Cc: autofs@linux.kernel.org

On Fri, 2007-03-30 at 09:38 +0000, Jarl Stefansson wrote:
> I'm still at a loss as to why automounted file-systems are not being unmounted.
> 
> Any suggestions on how to proceed with debugging this issue are appreciated, if there
> is any additional information I can provide please don't hesitate to ask.

I don't have any ideas about how to find out what is accessing your
mount.

lsof may give some information but it looks like the frequency of access
is high and probably brief (or there's an open file or working directory
within the automount), as there is no umount followed by mount in the
log.

Perhaps /mnt is a bad place to put this automount in Gentoo.
Try another location.

Obviously, this isn't a usb device because as you know, once they're
mounted, they can often be polled frequently. Don't ask me what software
or why, I don't know.

> Yours
> Jarl
> 
> ----- Original Message -----
> From: Jarl Stefansson <jarl@marimo.is>
> To: Ian Kent <raven@themaw.net>
> Cc: autofs@linux.kernel.org
> Sent: Tuesday, March 27, 2007 3:10:52 PM GMT Africa/Casablanca
> Subject: Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4
> 
> Hey Ian,
> 
> Here is a list of the processes running:
> 
> http://pastebin.ca/412160
> 
> Jarl 
> 
> 
> ----- Original Message -----
> From: Ian Kent <raven@themaw.net>
> To: Jarl Stefansson <jarl@marimo.is>
> Cc: jmoyer@redhat.com, autofs@linux.kernel.org
> Sent: Tuesday, March 27, 2007 2:52:21 PM GMT Africa/Casablanca
> Subject: Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4
> 
> On Tue, 2007-03-27 at 10:32 +0000, Jarl Stefansson wrote:
> > Hey Jeff,
> > 
> > Here is the debug log when set to 60 sec
> > 
> > http://pastebin.ca/411870
> 
> Unfortunately, that hasn't helped.
> Version 4 doesn't log the pid of the process accessing the mount point,
> so we still don't know what's causing this.
> 
> Do you have hald running?
> Does this behavior change after an hour or so?
> 
> Are there many processes running?
> If not perhaps a list of them would help.
> 
> > Jarl 
> > 
> > 
> > ----- Original Message -----
> > From: jmoyer@redhat.com
> > To: Jarl Stefansson <jarl@marimo.is>
> > Cc: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org
> > Sent: Monday, March 26, 2007 7:29:18 PM GMT Africa/Casablanca
> > Subject: Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4
> > 
> > ==> Regarding Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4; Jarl Stefansson <jarl@marimo.is> adds:
> > 
> > jarl> Hey Jeff, Yes, I am 100% sure that there is nothing using the mounted
> > jarl> filesystems.  For debugging I have a system with just bare minimals,
> > jarl> kernel + glibc + base utilities so there really aren't any
> > jarl> applications which can interfere.
> > 
> > jarl> According to what I have read I should also be getting some debug
> > jarl> info in the log regarding the timeout period but I can't see any
> > jarl> mention of timeout or unmount.
> > 
> >   Mar 26 01:33:54 kidsq daemon.debug automount[3626]: expire_proc: 1 remaining in /mnt/auto 
> > 
> > This means that (in your case) the kernel thought that the mount point was
> > in use.  Could you humor me and up the timeout to something like 60 seconds
> > and see if that helps matters?
> > 
> > Thanks,
> > 
> > Jeff
> > 
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
