From: Heinrich Rebehn <rebehn@ant.uni-bremen.de>
Subject: autofs4 on readonly root fs
Date: Tue, 03 May 2005 13:59:59 +0200
Message-ID: <427767BF.9050103@ant.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi list,

I have been using autofs V3 for some years now and it always worked fine. It even worked on diskless clients witch had the root fs
mounted ro, you just had to create the mount directory beforehand.

With V4, this does not seem to work anymore. Trying to start automount results in: (Sorry for the long lines :-))

####### snippet from an "strace -f -e trace=file automount /misc ldap o=ant,c=de ############

[pid  2041] readlink("/tmp", 0xbfffcf50, 4096) = -1 EINVAL (Invalid argument)
[pid  2041] readlink("/tmp/autowCYzgd", 0xbfffcf50, 4096) = -1 EINVAL (Invalid argument)
[pid  2041] open("/etc/mtab", O_RDONLY|O_LARGEFILE) = 3
[pid  2041] fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
[pid  2041] oldumount("/tmp/autowCYzgd") = 0
Process 2041 detached
--- SIGCHLD (Child exited) @ 0 (0) ---
rmdir("/tmp/autowCYzgd")                = 0
rmdir("/tmp/autoZeRPyG")                = 0
open("/etc/mtab", O_RDONLY)             = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mkdir("/misc", 0555)                    = -1 EROFS (Read-only file system)    # In fact, the dir is already exists
open("/var/lock/autofs.2039", O_WRONLY|O_CREAT, 0) = 7
link("/var/lock/autofs.2039", "/var/lock/autofs") = 0
unlink("/var/lock/autofs.2039")         = 0
open("/var/lock/autofs", O_RDWR)        = 7
Process 2042 attached
[pid  2042] execve("/bin/mount", ["/bin/mount", "-t", "autofs", "-o", "fd=4,pgrp=2039,minproto=2,maxpro"..., "automount(pid2039)",
"/misc"], [/* 20 vars */]) = 0
[pid  2042] access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
[pid  2042] open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
[pid  2042] open("/etc/ld.so.cache", O_RDONLY) = 7
[pid  2042] fstat64(7, {st_mode=S_IFREG|0644, st_size=21348, ...}) = 0
[pid  2042] access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
[pid  2042] open("/lib/tls/libc.so.6", O_RDONLY) = 7
[pid  2042] fstat64(7, {st_mode=S_IFREG|0644, st_size=1254468, ...}) = 0
[pid  2042] open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 7
[pid  2042] fstat64(7, {st_mode=S_IFREG|0644, st_size=290576, ...}) = 0
[pid  2042] open("/dev/null", O_RDWR|O_LARGEFILE) = 7
[pid  2042] lstat64("/etc/mtab", {st_mode=S_IFLNK|0777, st_size=12, ...}) = 0
[pid  2042] stat64("/sbin/mount.autofs", 0xbfffdcd0) = -1 ENOENT (No such file or directory)
[pid  2042] mount("automount(pid2039)", "/misc", "autofs", 0xc0ed0000, 0x805cb08) = -1 ENOENT (No such file or directory)

##################### End of snippet #############################

root@debian [~] # ls -ld /misc
drwxr-xr-x  2 root root 512 2005-05-03 13:00 /misc
root@debian [~] # automount -V
Linux automount version 4.1.4_beta2
root@debian [~] # uname -a
Linux debian 2.6.8-2-686-smp #1 SMP Mon Jan 24 02:32:52 EST 2005 i686 GNU/Linux

This is the original Debian sarge kernel.

Is there any way to make this work?

Thanks for any help, and sorry again for the long lines,
but i thought the strace output might be easier to read.

-- 

Heinrich Rebehn

University of Bremen
Physics / Electrical and Electronics Engineering
- Department of Telecommunications -

Phone : +49/421/218-4664
Fax   :            -3341
