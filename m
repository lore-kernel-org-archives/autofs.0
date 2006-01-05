From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: BUG: 2.6.14/2.6.15: USB storage/ext2fs
 uninterruptable sleep
Date: Thu, 5 Jan 2006 11:45:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601051143480.5520-100000@iolanthe.rowland.org>
References: <87irsypswi.fsf@hardknott.home.whinlatter.ukfsn.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751778AbWAEQpd@vger.kernel.org>
In-Reply-To: <87irsypswi.fsf@hardknott.home.whinlatter.ukfsn.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Cc: Andrew Morton <akpm@osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, autofs@linux.kernel.org, raven@themaw.net

On Thu, 5 Jan 2006, Roger Leigh wrote:

> With some further testing with both usb-storage and ub, both show the
> same behaviour when using autofs4 _or_ autofs.  When mounting by hand,
> the problem does not occur.  While broken on 2.6.15 and 2.6.14, it
> does appear to work on 2.6.13; I can't test earlier kernels at the
> moment because of udev--I'll have to remove it first.

By any chance, does autofs or autofs4 mount your device with -o sync?  
Doing that with flash memory devices is a grave mistake -- although it 
shouldn't cause the sort of lock-up you described.

Alan Stern

