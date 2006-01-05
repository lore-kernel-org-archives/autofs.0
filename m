From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: BUG: 2.6.14/2.6.15: USB storage/ext2fs
 uninterruptable sleep
Date: Thu, 5 Jan 2006 14:00:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601051355090.6460-100000@iolanthe.rowland.org>
References: <87fyo2k1zr.fsf@hardknott.home.whinlatter.ukfsn.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752019AbWAETAM@vger.kernel.org>
In-Reply-To: <87fyo2k1zr.fsf@hardknott.home.whinlatter.ukfsn.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Cc: Andrew Morton <akpm@osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, autofs@linux.kernel.org, raven@themaw.net

On Thu, 5 Jan 2006, Roger Leigh wrote:

> > By any chance, does autofs or autofs4 mount your device with -o sync?  
> > Doing that with flash memory devices is a grave mistake -- although it 
> > shouldn't cause the sort of lock-up you described.
> 
> Yes.  I have
> 
> pen-secure  -fstype=ext2,sync,nodev,nosuid,noatime  :/dev/sda2
> 
> in /etc/auto.misc.  Removing the sync option does prevent the lockups.
> I just added it back and it locked up immediately.

Sync for flash devices is generally a bad idea.  Especially with vfat 
filesystems but to some extent with all of them, it causes constant 
rewriting of sectors containing metadata.  Flash memory behaves poorly 
when the same sector gets written over and over again; it tends to slow 
down and eventually wear out completely.

> The usb/usb-storage logs are attached (device mount + command which
> broke it).  Would you like any more information?

The log you provided shows only two commands, both of which completed 
successfully.  Is that really the place where things got hung?  If it is 
then the problem isn't in the USB stack but someplace higher up: the SCSI 
stack, the block layer, or the filesystem layer.

Alan Stern
