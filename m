From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs Error Messages
Date: Thu, 18 Jun 2009 12:49:11 -0400
Message-ID: <x49y6rp4hdk.fsf@segfault.boston.devel.redhat.com>
References: <448461.91454.qm@web54303.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <448461.91454.qm@web54303.mail.re2.yahoo.com> (Thanh Tran's
	message of "Thu, 18 Jun 2009 08:02:53 -0700 (PDT)")
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
To: Thanh Tran <ttran7700@yahoo.com>
Cc: autofs@linux.kernel.org

Thanh Tran <ttran7700@yahoo.com> writes:

> I've been having problems w/ automount.  It does not detect my usb
> drive.  Looking at the system logs, my kernel seems to see the usb
> stick insertion just fine.  The automount log indicates it's running.
> I get the following message.
>
> automount[900]: attempting to mount entry /mnt/usbdrive/usbdrive
> automount[900]: lookup(program): lookup for usbdrive failed
> automount[900]: failed to mount /mnt/usbdrive/usbdrive
>
> The auto.master:
>
> /mnt/usbdrive /etc/auto.usbdrive
>
> The auto.usbdrive:
> usbdrive	-fstype=vfat,uid=500,gid=500,umask=002	:/dev/sdb1
>
> I've done a quick internet search on the issue and the advice I got
> was to check the auto.usbdrive file.  It seems OK to me.  Any other
> suggestions?  Thanks in advance.

Hmm, second report of this sort of thing.  Does a chmod -x of
/etc/auto.usbdrive make things work?

Cheers,
Jeff
