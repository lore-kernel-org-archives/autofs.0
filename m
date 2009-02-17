From: Ahmon Dancy <dancy@franz.com>
Subject: Two problems w/ autofs
Date: Tue, 17 Feb 2009 15:52:01 -0800
Message-ID: <5144.1234914721@dancy>
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

Hello Ian, et al.

Using autofs-5.0.3-36 (built from Fedora 10 updates source RPM) on
2.6.26.6-49.fc8 kernel.  We run w/ LOGGING=debug.

We use autofs extensively for NFS multimounts and there are a few
issues that we're trying to get resolved:

Problem #1:

We us a TIMEOUT of 300 but there are often mounts that are never
expired, even if lsof shows no process is using the mount points in
question.   kill -USR1 doesn't help.

Example: /net/bb2 isn't expiring.

Relevant portion of /proc/mounts:

bb2:/ /net/bb2 nfs rw,nosuid,nodev,relatime,vers=3,rsize=32768,wsize=32768,namlen=255,hard,nointr,proto=tcp,timeo=600,retrans=2,sec=sys,mountproto=udp,addr=192.168.95.79 0 0
-hosts /net/bb2/acl autofs rw,relatime,fd=12,pgrp=9397,timeout=300,minproto=5,maxproto=5,offset 0 0
-hosts /net/bb2/home autofs rw,relatime,fd=12,pgrp=9397,timeout=300,minproto=5,maxproto=5,offset 0 0
-hosts /net/bb2/opt autofs rw,relatime,fd=12,pgrp=9397,timeout=300,minproto=5,maxproto=5,offset 0 0
-hosts /net/bb2/tmp autofs rw,relatime,fd=12,pgrp=9397,timeout=300,minproto=5,maxproto=5,offset 0 0
-hosts /net/bb2/usr autofs rw,relatime,fd=12,pgrp=9397,timeout=300,minproto=5,maxproto=5,offset 0 0
-hosts /net/bb2/var autofs rw,relatime,fd=12,pgrp=9397,timeout=300,minproto=5,maxproto=5,offset 0 0
bb2:/opt /net/bb2/opt nfs rw,nosuid,nodev,relatime,vers=3,rsize=32768,wsize=32768,namlen=255,hard,nointr,proto=tcp,timeo=600,retrans=2,sec=sys,mountproto=udp,addr=192.168.95.79 0 0

Sample log entry:

Feb 17 15:31:40 gemini automount[9397]: handle_packet_expire_indirect: token 67811, name bb2
Feb 17 15:31:40 gemini automount[9397]: expiring path /net/bb2
Feb 17 15:31:40 gemini automount[9397]: umount_multi: path /net/bb2 incl 1
Feb 17 15:31:40 gemini automount[9397]: some offset mounts still present under /net/bb2
Feb 17 15:31:40 gemini automount[9397]: couldn't complete expire of /net/bb2
Feb 17 15:31:40 gemini automount[9397]: send_fail: token = 67811

Interestingly, there's no mention of /net/bb2/opt, which it would need
to umount first.


Problem #2:

One of the multimounts is misbehaving and not lazy-mounting.  The
problem seems to stem from a failure to do a lazy umount earlier:

Log entries for the umount attempt:

Feb 17 13:32:54 gemini automount[9397]: handle_packet: type = 4
Feb 17 13:32:54 gemini automount[9397]: handle_packet_expire_indirect: token 67564, name cobweb
Feb 17 13:32:54 gemini automount[9397]: expiring path /net/cobweb
Feb 17 13:32:54 gemini automount[9397]: umount_multi: path /net/cobweb incl 1
Feb 17 13:32:54 gemini automount[9397]: umount_multi_triggers: umount offset /net/cobweb/home/ftp
Feb 17 13:32:54 gemini automount[9397]: umount_autofs_offset: offset /net/cobweb/home/ftp not mounted
Feb 17 13:32:54 gemini automount[9397]: umount_multi_triggers: umount offset /net/cobweb/home/patches
Feb 17 13:32:54 gemini automount[9397]: umount_autofs_offset: offset /net/cobweb/home/patches not mounted
Feb 17 13:32:54 gemini automount[9397]: umount_multi_triggers: umount offset /net/cobweb/www/sites/franzdownload
Feb 17 13:32:54 gemini automount[9397]: umount_autofs_offset: offset /net/cobweb/www/sites/franzdownload not mounted
Feb 17 13:32:54 gemini automount[9397]: some offset mounts still present under /net/cobweb
Feb 17 13:32:54 gemini automount[9397]: couldn't complete expire of /net/cobweb
Feb 17 13:32:54 gemini automount[9397]: send_fail: token = 67564

After this happened, accesses to /net/cobweb/home/ftp did not result
in an automatic mount, just an empty directory.


This is a production system so I can only do so much, but I can try
reasonable tests and supply debugging output.   Unfortunately I
haven't yet found a way to explicitly cause the broken scenario to
happen.
