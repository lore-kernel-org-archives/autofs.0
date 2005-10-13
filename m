From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Using autofs with USB Devices
Date: Wed, 12 Oct 2005 22:01:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0510122137210.9742@xena.cft.ca.us>
References: <20051011135319.58411.qmail@web60016.mail.yahoo.com>
	<Pine.LNX.4.58.0510130942190.26706@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0510130942190.26706@wombat.indigo.net.au>
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
To: "Dr. Harold K. Brown, P.E." <hbrown_usa@yahoo.com>
Cc: autofs@linux.kernel.org

On Thu, 13 Oct 2005, Ian Kent wrote:

> On Tue, 11 Oct 2005, Dr. Harold K. Brown, P.E. wrote:

> > The issues at play here is when there are several
> > usb-storage devices, (i.e. ipod, memory cards, and
> > cameras) mounted in different order and in different
> > usb ports the (/dev/sd?) assignment is somewhat random
> > from a user standpoint.  

> I thought that device name persistence was one of the issues
> that udev addressed?

Well, sort of, but...  When I use hotplug USB devices (kernel 2.6.11, 
hotplug-0.50, udev-053), the primary device name is whatever the kernel 
feels like, e.g. /dev/sdb1.  However, the rules in /etc/udev/rules.d have 
the possibility of making a symlink with a fixed name, and removing it when 
the device is unplugged. e.g. /dev/ipod -> /dev/sd(whatever).  The hotplug 
machinery also mounts the device for you, and for me this happens reliably. 
In the SuSE distro the mount point is auto-created in the /media directory,
with a name associated with the particular device which seems to change at
every version upgrade, but which at one point included the device's product
ID in hex.  Thus you can make a symlink to the future mount point of the 
specific device.  

Unplugging is another matter -- it's recommended to use "eject" to unmount 
the device, but I've found that hotplug can usually unmount a truly 
non-busy device by itself -- but sometimes it messes up.

Autofs doesn't seem like the best way to handle USB devices, mainly because 
it dismounts on a timeout if the mount point has been unused for a 
(configurable) time, usually set to 5 minutes.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
