From: Chris Fanning <christopher.fanning@gmail.com>
Subject: autofs and terminal networks woes.
Date: Thu, 17 Feb 2005 11:33:25 +0100
Message-ID: <215ff441050217023378003e72@mail.gmail.com>
Reply-To: Chris Fanning <christopher.fanning@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello all,

I am working with terminal networks. I have been using PXES
(http://pxes.sourceforge.net/) as the thinclient and freeNX
(http://developer.berlios.de/projects/freenx/) as the X protocol.

All users run their session on the central terminal server. Each pc,
where the users sits, is running X (PXES). Problems start when the
user wants to access the floppy because /mnt/floppy is the floppy
drive on the server, when in reality, the user is not phisically at
the server. By clicking on his floppy icon, the user expects to access
the drive on his thinclient.

PXES (the thinclient) runs a samba server just for this reason.
Therefore, the user can browse smb://thinclient/fd or
smb://thinclient/cdrom to access his local drives because he is
physically @thinclient.
I have managed to setup floppy and cdrom icons on the desktop at
login. By using the freeNX code, we can know the ip of the thinclient.

So, we have varios users running individual sessions on the server
simultaneously. Each user is sitting at a client with its own ip. Each
user can access their floppy via smb://thinclient_ip/fd

I feel this is a limited solution. When the user goes to konqueror o
nautilus and accesses /mnt/floppy, he reads the floppy on the server
(bad becaue he is not physically there). All system-wide references to
the floppy or cdrom or usb are wrong. Only the icons
(smb://thinclient/..) made explicitly are correct.

Considering this limitation, I thought something might be able to be
done with autofs 

It does seem possible to do something like this.
/var/autofs/terminales/a_thinclient_ip/floppy
/var/autofs/terminales/a_thinclientl_ip/cdrom

So I setup the samba server on the thinclient to accept guest without password
(I read somewhere that this was necessary for autofs).

more /etc/auto.terminals
floppy  -fstype=smbfs,guest,fmask=666,dmask=777        ://a_thinclient_ip/fd
and it works!

However, I think I need to use an external script (you call that a
map?) that produces this output
a_thinclient_ip   -fstype=smbfs,guest,fmask=666,dmask=777      
/floppy thinclient_ip:/fd

I have manually added this to auto.smb to test it and it doesn't work.

So my question here is why?
floppy  -fstype=smbfs,guest,fmask=666,dmask=777       
://a_thinclient_ip/fd  (this mounts)
a_thinclient_ip   -fstype=smbfs,guest,fmask=666,dmask=777      
/floppy thinclient_ip:/fd   (this doesn't)

What am I overlooking?

Thanks in advance
Chris.
