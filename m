From: "Dr. Harold K. Brown, P.E." <hbrown_usa@yahoo.com>
Subject: Using autofs with USB Devices
Date: Tue, 11 Oct 2005 06:53:19 -0700 (PDT)
Message-ID: <20051011135319.58411.qmail@web60016.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

I am working on the the following system.

OS:         Stable (Sarge) Debian with 2.6 Kernel.
CPU:        i386
Devices:    1) several usb-storage class devices.
            2) Palm m505 using ttyUSB* devices.
Subsystems: hotplug, scsi, autofs

I am trying to develop a procedure to associate a
specific USB device using the manufacture and
product-id with a mount point. Currently I have a
script that does a switch within the hotplug system
that determines which device has been plugged in the
system.  This part is working.

What is missing is how to determine which usb dev
mount point (i.e. /dev/sd?) the device is being
associated with within this same context.

The plan is within the context of the hotplug script
is to make a soft link to this dev mount point that is
associated with the device just being plugged into the
computer.  Once the hotplug script is complete then
autofs can mount to the dev through this link when the
user software needs a static mount point (i.e.
/mnt/camera-1 or /mnt/memcardreader-2).  This will
allow a fixed mount point to the user so that the user
software can find the correct device on demand once
the device has been plugged into the system.

The issues at play here is when there are several
usb-storage devices, (i.e. ipod, memory cards, and
cameras) mounted in different order and in different
usb ports the (/dev/sd?) assignment is somewhat random
from a user standpoint.  The goal is to resolve this
problem and document the solution.  Note also other
devices such as iPODS may also be plugged into the USB
ports during the same time period.

Let me know if anyone has any ideas or knows where
this is documented.

Thanks.

Hal



		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free.
http://music.yahoo.com/unlimited/
