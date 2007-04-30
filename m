From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Mounting a usb flash drive on /mnt
Date: Sun, 29 Apr 2007 17:24:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704291704410.4227@xena.cft.ca.us>
References: <20070419181221.73C51160C1@l0ca1h0st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070419181221.73C51160C1@l0ca1h0st.com>
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
To: Derek Reid <autofs-ml@l0ca1h0st.com>
Cc: autofs@linux.kernel.org

On Thu, 19 Apr 2007, Derek Reid wrote:

> I'd like to mount my usb flash drive exclusively on /mnt but I'm not
> sure if this is possible...

Understood that the autofs issue is mounting on an immediate subdirectory 
of the root, but...  The USB drive can be mounted when you first refer to 
it (using autofs), or when it's hotplugged.  This latter way is what 
mainstream distro integrators are doing.  If you're running KDE or Gnome, 
then gnome-volume-manager should be started.  It monitors hotplug messages 
and should take care of telling haldaemon to mount a newly inserted device 
or media (on /media/whatever; probably you can influence this mount point 
choice).  But I assume you're using neither Desktop Environment.

I have some notes on gotcha's, including this one.  Search for "Gnome"
in this document, about halfway through.
    http://www.math.ucla.edu/~jimc/documents/bugfix.html
The only thing I haven't figured out is, how do you unmount the USB drive, 
short of yanking it out while still mounted, which seems like a recipe for 
disaster.  On a CD drive you can press the eject button and the appropriate 
hot(un)plug message will be sent, but not for USB storage.

Hope this is useful!

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
