From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Filesystem continuously remounts
Date: Mon, 05 Feb 2007 11:26:39 -0500
Message-ID: <x49iregwoxs.fsf@segfault.boston.devel.redhat.com>
References: <Pine.LNX.4.64.0702050929520.17633@rray.drdc.mstc.ms.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0702050929520.17633@rray.drdc.mstc.ms.gov>
	(Richard Ray's message of "Mon, 5 Feb 2007 09:41:04 -0600 (CST)")
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
To: Richard Ray <rray@mstc.state.ms.us>
Cc: autofs@linux.kernel.org

==> On Mon, 5 Feb 2007 09:41:04 -0600 (CST), Richard Ray <rray@mstc.state.ms.us> said:

Richard> [ddm@dc2 ~]$ less /var/log/messages
Richard> ...
Richard> Feb  5 09:25:22 dc2 kernel: EXT3 FS on sdb1, internal journal
Richard> Feb  5 09:25:22 dc2 kernel: EXT3-fs: mounted filesystem with ordered 
Richard> data mode.
Richard> Feb  5 09:26:22 dc2 kernel: EXT3 FS on sdb1, internal journal
Richard> Feb  5 09:26:22 dc2 kernel: EXT3-fs: mounted filesystem with ordered 
Richard> data mode.
Richard> Feb  5 09:27:22 dc2 kernel: EXT3 FS on sdb1, internal journal
Richard> Feb  5 09:27:22 dc2 kernel: EXT3-fs: mounted filesystem with ordered 
Richard> data mode.
Richard> Feb  5 09:28:23 dc2 kernel: EXT3 FS on sdb1, internal journal
Richard> Feb  5 09:28:23 dc2 kernel: EXT3-fs: mounted filesystem with ordered 
Richard> data mode.

Richard> As you can see the filesystem keeps remounting itself every 60 seconds.
Richard> What can I do to fix this?

And Ian just reminded me that some tools (like udev/hal) used to
trigger a remount after each unmount.  This actually sounds like it
may be your problem.  Make sure your desktop environment is up to date.

Also, see this thread from the past:
  http://linux.kernel.org/pipermail/autofs/2006-October/003350.html

-Jeff
