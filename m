From: Richard Ray <rray@mstc.state.ms.us>
Subject: Filesystem continuously remounts
Date: Mon, 5 Feb 2007 09:41:04 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0702050929520.17633@rray.drdc.mstc.ms.gov>
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
To: autofs@linux.kernel.org

I just upgraded from FC4 to FC5. My kernel is 2.6.18 downloaded from 
kernel.org. Autofs is 4.1.4 from the FC5 package.

[ddm@dc2 ~]$ cat /etc/auto.master
#
# $Id: auto.master,v 1.4 2005/01/04 14:36:54 raven Exp $
#
# Sample auto.master file
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# For details of the format look at autofs(5).
#/misc  /etc/auto.misc --timeout=60
/smb    /etc/auto.smb
/net    /etc/auto.net --timeout=60
/cache  /etc/auto.cache --timeout=60



[ddm@dc2 ~]$ cat /etc/auto.cache
0       -fstype=ext3,rw      :/dev/cache0
1       -fstype=ext3,rw      :/dev/cache1



[ddm@dc2 ~]$ less /var/log/messages
...
Feb  5 09:25:22 dc2 kernel: EXT3 FS on sdb1, internal journal
Feb  5 09:25:22 dc2 kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Feb  5 09:26:22 dc2 kernel: EXT3 FS on sdb1, internal journal
Feb  5 09:26:22 dc2 kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Feb  5 09:27:22 dc2 kernel: EXT3 FS on sdb1, internal journal
Feb  5 09:27:22 dc2 kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Feb  5 09:28:23 dc2 kernel: EXT3 FS on sdb1, internal journal
Feb  5 09:28:23 dc2 kernel: EXT3-fs: mounted filesystem with ordered 
data mode.


As you can see the filesystem keeps remounting itself every 60 seconds.
What can I do to fix this?

Thanks
Richard
