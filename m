From: Thanh Tran <ttran7700@yahoo.com>
Subject: Re: Autofs Error Messages
Date: Thu, 18 Jun 2009 10:15:30 -0700 (PDT)
Message-ID: <465630.44269.qm@web54304.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org


The execute bit was set on the file.  I chmod -x and it works now.  Thanks.

--- On Thu, 6/18/09, Ian Kent <raven@themaw.net> wrote:

> From: Ian Kent <raven@themaw.net>
> Subject: Re: [autofs] Autofs Error Messages
> To: "Thanh Tran" <ttran7700@yahoo.com>
> Cc: autofs@linux.kernel.org
> Date: Thursday, June 18, 2009, 12:53 PM
> Thanh Tran wrote:
> > I've been having problems w/ automount.=A0 It does
> not detect my usb
> > drive.=A0 Looking at the system logs, my kernel
> seems to see the usb
> > stick insertion just fine.=A0 The automount log
> indicates it's running.
> > I get the following message.
> > =

> > automount[900]: attempting to mount entry
> /mnt/usbdrive/usbdrive =

> > automount[900]: lookup(program): lookup for usbdrive
> failed =

> > automount[900]: failed to mount
> /mnt/usbdrive/usbdrive
> > =

> > The auto.master:
> > =

> > /mnt/usbdrive /etc/auto.usbdrive
> > =

> > The auto.usbdrive: usbdrive=A0=A0=A0
> -fstype=3Dvfat,uid=3D500,gid=3D500,umask=3D002
> > :/dev/sdb1
> > =

> > I've done a quick internet search on the issue and the
> advice I got
> > was to check the auto.usbdrive file.=A0 It seems OK
> to me.=A0 Any other
> > suggestions?=A0 Thanks in advance.
> =

> Looks like /etc/auto.usbdrive is executable and autofs is
> trying to
> execute it instead of reading it.
> =

> Ian
> =

> =



      =
