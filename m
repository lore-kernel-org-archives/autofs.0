From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Subject: Re: [linux-usb-devel] Re: BUG: 2.6.14/2.6.15: USB storage/ext2fs uninterruptable sleep
Date: Thu, 05 Jan 2006 19:28:09 +0000
Message-ID: <87lkxupj92.fsf@hardknott.home.whinlatter.ukfsn.org>
References: <Pine.LNX.4.44L0.0601051355090.6460-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752166AbWAET2j@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0601051355090.6460-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Thu, 5 Jan 2006 14:00:08 -0500 (EST)")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, autofs@linux.kernel.org, raven@themaw.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Stern <stern@rowland.harvard.edu> writes:

> On Thu, 5 Jan 2006, Roger Leigh wrote:
>
>> > By any chance, does autofs or autofs4 mount your device with -o sync?  
>> > Doing that with flash memory devices is a grave mistake -- although it 
>> > shouldn't cause the sort of lock-up you described.
>> 
>> Yes.  I have
>> 
>> pen-secure  -fstype=ext2,sync,nodev,nosuid,noatime  :/dev/sda2
>> 
>> in /etc/auto.misc.  Removing the sync option does prevent the lockups.
>> I just added it back and it locked up immediately.
>
> Sync for flash devices is generally a bad idea.  Especially with vfat 
> filesystems but to some extent with all of them, it causes constant 
> rewriting of sectors containing metadata.  Flash memory behaves poorly 
> when the same sector gets written over and over again; it tends to slow 
> down and eventually wear out completely.

ACK.  The device is generally only used for reading, and I wanted it
to be safe for accidental unplugging soon after a write (hence the
reason I didn't spot it in 2.6.14: I hadn't written to it for six
months!).  It's also supposed to do write-levelling, though I don't
know how good it is.

>> The usb/usb-storage logs are attached (device mount + command which
>> broke it).  Would you like any more information?
>
> The log you provided shows only two commands, both of which completed 
> successfully.  Is that really the place where things got hung?

Yes.  I confirmed this with the kern.log timestamps.  The log might
exclude the mount (it might be a chdir instead), but definitely
includes the failure, since there were no further writes to the log
for at least five minutes after the hang, with no further USB
messages.  BTW, after the hangs I could still copy the file in
question, and also create/delete other files on the same filesystem,
so it was not entirely dead, just wedged on that one thing.

> If it is then the problem isn't in the USB stack but someplace
> higher up: the SCSI stack, the block layer, or the filesystem layer.

Yikes.


Regards,
Roger

- -- 
Roger Leigh
                Printing on GNU/Linux?  http://gimp-print.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your mail.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFDvXM9VcFcaSW/uEgRAjJuAKDsfJtTwOhyuzopsR+M8yxU+3lgjgCfS1jb
CabRaCer49elckXQmrKDKVY=
=9891
-----END PGP SIGNATURE-----
