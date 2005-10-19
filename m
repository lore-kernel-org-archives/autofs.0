From: Thomas Jahns <Thomas.Jahns@gmx.net>
Subject: Re: Using autofs with USB Devices
Date: Wed, 19 Oct 2005 21:43:26 +0000
Message-ID: <1129758211l.8921l.2l@mercury>
References: <20051011135319.58411.qmail@web60016.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20051011135319.58411.qmail@web60016.mail.yahoo.com> (from
	hbrown_usa@yahoo.com on Tue Oct 11 15:53:19 2005)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="Flowed"
To: "Dr. Harold K. Brown, P.E." <hbrown_usa@yahoo.com>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 10/11/05 15:53:19, Dr. Harold K. Brown, P.E. wrote:
> I am trying to develop a procedure to associate a
> specific USB device using the manufacture and
> product-id with a mount point. Currently I have a
> script that does a switch within the hotplug system
> that determines which device has been plugged in the
> system.  This part is working.
> 
> What is missing is how to determine which usb dev
> mount point (i.e. /dev/sd?) the device is being
> associated with within this same context.

I do have a script that can be used to create such automount map  
entries. It does currently use the volume label in preference to device  
type, name or vendor, but that could be hacked easily.

The current "release" version is at

http://ccomb.free.fr/wiki/wakka.php?wiki=UsbMassStorageEnglish
http://ccomb.free.fr/usbstorage/hotplug-mount.pl
http://ccomb.free.fr/usbstorage/hotplug-mount.README

The release is mostly a 1:1 port of Christophe's Shell-Script to Perl.  
A much more recent, more featureful and highly streamlined version can  
be obtained from me => send email.

Ciao,
Thomas Jahns
- -- 
"Computers are good at following instructions,
  but not at reading your mind."
D. E. Knuth, The TeXbook, Addison-Wesley 1984, 1986, 1996, p. 9
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDVr4DoKHaAfEZMbkRAj6XAJ47SY4ua71gdc58kvU5sKz/5kS1FQCfavIE
ExkwOdaVjsNBK5oMd+13yd4=
=/koV
-----END PGP SIGNATURE-----
