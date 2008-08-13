From: Thanh Tran <ttran7700@yahoo.com>
Subject: Re: Fedora 8 And Autofs
Date: Wed, 13 Aug 2008 05:43:10 -0700 (PDT)
Message-ID: <274390.64191.qm@web54304.mail.re2.yahoo.com>
References: <1218595897.3148.3.camel@raven.themaw.net>
Reply-To: ttran7700@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1218595897.3148.3.camel@raven.themaw.net>
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

Thanks for the reply.

My auto.master file looks like this.

/mnt/cdrom /etc/auto.cdrom --timeout 2
/mnt/floppy /etc/auto.floppy --timeout 1
/mnt/usbdrive /etc/auto.usbdrive --timeout 2

My auto.cdrom looks like this.

cdrom    -fstype=iso9660,user,suid   :/dev/cdrom

I did a lshal -monitor to make sure the physical devices were at least being detected when I inserted them to the USB.  

I did a "/etc/rc.d/init.d/autofs status" under Fedora 8 and only got this.

automount (pid 1524) is running...

I did the same call under Fedora 5 and got this.

Configured Mount Points:
------------------------
/usr/sbin/automount --timeout=60 /mnt/cdrom file /etc/auto.cdrom
/usr/sbin/automount --timeout=60 /mnt/floppy file /etc/auto.floppy
/usr/sbin/automount --timeout=60 /mnt/usbdrive file /etc/auto.usbdrive

Active Mount Points:
--------------------
/usr/sbin/automount --timeout=60 /mnt/cdrom file /etc/auto.cdrom
/usr/sbin/automount --timeout=60 /mnt/floppy file /etc/auto.floppy
/usr/sbin/automount --timeout=60 /mnt/usbdrive file /etc/auto.usbdrive

This output leads me to believe the auto.master is not loading correctly under Fedora 8.  

Thanks.

--- On Tue, 8/12/08, Ian Kent <raven@themaw.net> wrote:

> From: Ian Kent <raven@themaw.net>
> Subject: Re: [autofs] Fedora 8 And Autofs
> To: ttran7700@yahoo.com
> Cc: autofs@linux.kernel.org
> Date: Tuesday, August 12, 2008, 10:51 PM
> On Tue, 2008-08-12 at 16:03 -0700, Thanh Tran wrote:
> > I'm sorry if this is a repost.  I'm not sure
> if the 1st one got
> > through.  I've been using autofs just fine on
> Fedora 5.  I recently
> > upgraded to Fedora 8.  I ran yum install autofs to get
> the latest.
> > Then, I updated my auto.master file to match my old
> one under Fedora
> 
> So what is in your auto.master?
> 
> >  5.  It does not seem to work.  The autofs does not
> seem to load my
> > master mount file.  I checked hal and it's happy
> as a clam.  It sees
> 
> Any messages in the system log.
> What has hal got to do with this?
> 
> >  new devices being added when I plug my usb cdrom and
> usb memory
> > stick.  I looked at the autofs script in /etc/init.d
> and compared it
> > to the one on Fedora 5 and they totally different. 
> Could someone
> > please direct me to a tutorial?  I never had this much
> trouble on
> > Fedora 5.
> > 
> > 
> >       
> > 
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
