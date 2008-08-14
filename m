From: Thanh Tran <ttran7700@yahoo.com>
Subject: Re: Fedora 8 And Autofs
Date: Thu, 14 Aug 2008 05:55:32 -0700 (PDT)
Message-ID: <62560.18090.qm@web54304.mail.re2.yahoo.com>
References: <1218690041.27280.82.camel@raven.themaw.net>
Reply-To: ttran7700@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1218690041.27280.82.camel@raven.themaw.net>
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

Thank you for your reply.  I'm using autofs because my system is stripped down.  I'm not running any GUI's.  It's all command lines for me.  Only esseintial services and apps were installed.  I did the same thing under Fedora 5 and didn't have any problems.  Perhaps, I'm missing a service that autofs needs???


--- On Thu, 8/14/08, Ian Kent <raven@themaw.net> wrote:

> From: Ian Kent <raven@themaw.net>
> Subject: Re: [autofs] Fedora 8 And Autofs
> To: ttran7700@yahoo.com
> Cc: autofs@linux.kernel.org
> Date: Thursday, August 14, 2008, 1:00 AM
> On Wed, 2008-08-13 at 05:43 -0700, Thanh Tran wrote:
> > Thanks for the reply.
> > 
> > My auto.master file looks like this.
> > 
> > /mnt/cdrom /etc/auto.cdrom --timeout 2
> > /mnt/floppy /etc/auto.floppy --timeout 1
> > /mnt/usbdrive /etc/auto.usbdrive --timeout 2
> > 
> > My auto.cdrom looks like this.
> > 
> > cdrom    -fstype=iso9660,user,suid   :/dev/cdrom
> > 
> > I did a lshal -monitor to make sure the physical
> devices were at least being detected when I inserted them to
> the USB.  
> 
> And I suppose you've configured Gnome to not mount
> these removable
> devices for you when they are become available?
> 
> Fact is that GUI handling of removable devices is usually
> better than
> using autofs for these, but I guess you use autofs rather
> than the GUI
> for a reason.
> 
> > 
> > I did a "/etc/rc.d/init.d/autofs status"
> under Fedora 8 and only got this.
> > 
> > automount (pid 1524) is running...
> > 
> > I did the same call under Fedora 5 and got this.
> > 
> > Configured Mount Points:
> > ------------------------
> > /usr/sbin/automount --timeout=60 /mnt/cdrom file
> /etc/auto.cdrom
> > /usr/sbin/automount --timeout=60 /mnt/floppy file
> /etc/auto.floppy
> > /usr/sbin/automount --timeout=60 /mnt/usbdrive file
> /etc/auto.usbdrive
> > 
> > Active Mount Points:
> > --------------------
> > /usr/sbin/automount --timeout=60 /mnt/cdrom file
> /etc/auto.cdrom
> > /usr/sbin/automount --timeout=60 /mnt/floppy file
> /etc/auto.floppy
> > /usr/sbin/automount --timeout=60 /mnt/usbdrive file
> /etc/auto.usbdrive
> > 
> > This output leads me to believe the auto.master is not
> loading correctly under Fedora 8.  
> 
> There isn't a simple way for the init script to get
> this information
> from version 5 yet. You can "cat /proc/mounts|grep
> autofs" if you want
> to see what autofs mounts have been made but there are no
> individual
> processes any more. Having the init script interrogate
> /proc/mounts was
> considered at one stage but that hasn't been done
> because we would
> rather get the information from the daemon.
> 
> Ian
