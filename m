From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs Error Messages
Date: Fri, 19 Jun 2009 00:53:19 +0800
Message-ID: <4A3A70FF.3030704@themaw.net>
References: <448461.91454.qm@web54303.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <448461.91454.qm@web54303.mail.re2.yahoo.com>
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

Thanh Tran wrote:
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
> The auto.usbdrive: usbdrive	-fstype=vfat,uid=500,gid=500,umask=002
> :/dev/sdb1
> 
> I've done a quick internet search on the issue and the advice I got
> was to check the auto.usbdrive file.  It seems OK to me.  Any other
> suggestions?  Thanks in advance.

Looks like /etc/auto.usbdrive is executable and autofs is trying to
execute it instead of reading it.

Ian
