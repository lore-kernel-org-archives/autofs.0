From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Subject: Re: BUG: 2.6.14/2.6.15: USB storage/ext2fs uninterruptable sleep
Date: Thu, 05 Jan 2006 15:59:41 +0000
Message-ID: <87irsypswi.fsf@hardknott.home.whinlatter.ukfsn.org>
References: <87zmmbt1ce.fsf@hardknott.home.whinlatter.ukfsn.org>
	<20060105054106.2d4076bc.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060105054106.2d4076bc.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 5 Jan 2006 05:41:06 -0800")
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, autofs@linux.kernel.org, raven@themaw.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton <akpm@osdl.org> writes:

> Roger Leigh <rleigh@whinlatter.ukfsn.org> wrote:
>>
>> Hi folks,
>>
>> I use a USB storage device (Kingston 128 MiB keydrive) to hold GPG
>> keys, which is automounted with autofs4.  It's looking like a write
>> operation on the device (so far always involving an ext2_delete_inode
>> up to sync_buffer) causes the process to hang in an uninterruptable
>> sleep.
>>
>> The system is running stock kernel.org linux-2.6.15 and 2.6.14.5 on a
>> PowerPC 7447A system (Mac Mini) running Debian unstable.  The .config
>> is here: http://www.whinlatter.ukfsn.org/config-2.6.15-hardknott.bz2
>>
>> For example:
>> # cd /misc/pen-secure/.gnupg
>> # rm secring.gpg.lock pubring.gpg.lock pubring.gpg.tmp
>>
>> 7818 pts/1    D+     0:00 rm secring.gpg.lock pubring.gpg.lock pubring.gpg.tmp
>>
>> rm            D 0FF35634     0  7818   7196                   (NOTLB)
>> Call trace:
>>  [c0007524] __switch_to+0x54/0x6c
>>  [c0287c28] schedule+0x584/0x634
>>  [c0287d08] io_schedule+0x30/0x60
>>  [c006be78] sync_buffer+0x50/0x64
>>  [c0288854] __wait_on_bit_lock+0x60/0xc0
>>  [c0288928] out_of_line_wait_on_bit_lock+0x74/0x88
>>  [c006b33c] __lock_buffer+0x3c/0x4c
>>  [c006c570] sync_dirty_buffer+0x58/0x130
>>  [e2eef13c] ext2_xattr_delete_inode+0x1bc/0x278 [ext2]
>>  [e2ee8324] ext2_free_inode+0x38/0x27c [ext2]
>>  [e2eeb0a8] ext2_delete_inode+0x8c/0xac [ext2] [c00863b0] generic_delete_inode+0x104/0x17c
>>  [c0085450] iput+0x9c/0xb0
>>  [c007b09c] sys_unlink+0x124/0x180
>>  [c00046dc] ret_from_syscall+0x0/0x44
>>
>> I have had the same with the entry point being sys_rename:
>>
>> [gpg --recv-key ...]
>>
>> gpg           D 0F6D76B4     0 19099   3976 19103               (NOTLB)
>> Call trace:
>>  [c0007524] __switch_to+0x54/0x6c
>>  [c0287c28] schedule+0x584/0x634
>>  [c0287d08] io_schedule+0x30/0x60
>>  [c006be78] sync_buffer+0x50/0x64
>>  [c0288854] __wait_on_bit_lock+0x60/0xc0
>>  [c0288928] out_of_line_wait_on_bit_lock+0x74/0x88
>>  [c006b33c] __lock_buffer+0x3c/0x4c
>>  [c006c570] sync_dirty_buffer+0x58/0x130
>>  [e2eaf13c] ext2_xattr_delete_inode+0x1bc/0x278 [ext2]
>>  [e2ea8324] ext2_free_inode+0x38/0x27c [ext2]
>>  [e2eab0a8] ext2_delete_inode+0x8c/0xac [ext2] [c00863b0] generic_delete_inode+0x104/0x17c
>>  [c0085450] iput+0x9c/0xb0
>>  [c0083b14] dput+0x234/0x264
>>  [c007b908] sys_rename+0x168/0x1c4
>>
>> I can write other files to the device without trouble, but it's
>> clearly getting stuck somewhere inside the kernel.  In all the times
>> it's happened so far, eventually pdflush will subsequently go into D
>> state, and it's downhill from there (I can't unmount the filesystems
>> properly, and shutdown also hangs, so have to use Alt-SysRq to remount
>> readonly and reboot).
>>
>> The device is using usb-storage, rather than ub:
>> $ cat /proc/partitions |grep sda
>>    8     0     125952 sda
>>    8     1      97776 sda1
>>    8     2      28160 sda2
>>
>>
>> I'll be happy to provide any additional details or do any further
>> testing.

> I'd say that usb-storage is failing to send back I/O completions.

With some further testing with both usb-storage and ub, both show the
same behaviour when using autofs4 _or_ autofs.  When mounting by hand,
the problem does not occur.  While broken on 2.6.15 and 2.6.14, it
does appear to work on 2.6.13; I can't test earlier kernels at the
moment because of udev--I'll have to remove it first.

Using this simple test to exercise the device:
  while true; do cp /etc/fstab fstab; cat fstab; mv fstab t2; cat t2; rm t2; done
I quickly get a lockup with autofs4/autofs, with the device read/write
light lit up continuously.  When I run on a normal mount, the light
flashes once and then remains unlit (since there's nothing to write).
I'm not sure if this observation means autofs is doing something
wrong, but it does look like it's the main part of the problem.

I've CC'd the autofs list and maintainer, in case they can shed any
light on this.


Thanks,
Roger

- -- 
Roger Leigh
                Printing on GNU/Linux?  http://gimp-print.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your mail.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFDvUJkVcFcaSW/uEgRAgpKAKCVvBmabzCtIKLafQv0tw7qHymx+gCfee5L
eP3COOtKcAY+StFV203JsPQ=
=OztQ
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
