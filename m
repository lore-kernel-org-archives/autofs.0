From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Filesystem continuously remounts
Date: Mon, 05 Feb 2007 11:18:51 -0500
Message-ID: <x49mz3swpas.fsf@segfault.boston.devel.redhat.com>
References: <Pine.LNX.4.64.0702050929520.17633@rray.drdc.mstc.ms.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Richard> I just upgraded from FC4 to FC5. My kernel is 2.6.18 downloaded from 
Richard> kernel.org. Autofs is 4.1.4 from the FC5 package.

Which fc5 package?  rpm -q autofs

Richard> [ddm@dc2 ~]$ cat /etc/auto.master
Richard> #
Richard> # $Id: auto.master,v 1.4 2005/01/04 14:36:54 raven Exp $
Richard> #
Richard> # Sample auto.master file
Richard> # This is an automounter map and it has the following format
Richard> # key [ -mount-options-separated-by-comma ] location
Richard> # For details of the format look at autofs(5).
Richard> #/misc  /etc/auto.misc --timeout=60
Richard> /smb    /etc/auto.smb
Richard> /net    /etc/auto.net --timeout=60
Richard> /cache  /etc/auto.cache --timeout=60

Richard> [ddm@dc2 ~]$ cat /etc/auto.cache
Richard> 0       -fstype=ext3,rw      :/dev/cache0
Richard> 1       -fstype=ext3,rw      :/dev/cache1

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

http://people.redhat.com/jmoyer -- see the section on filing bug
reports and get back to us with more data.

-Jeff
