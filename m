From: mack <jmack@wm7d.net>
Subject: automount doesn't expire nested nfs mounts for certain kernel
	configs
Date: Sun, 09 May 2004 15:13:57 +0000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <409E4AB5.6A3CCEB1@wm7d.net>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: jmack@wm7d.net, autofs@linux.kernel.org

I have 6 similar systems, which automount and auto-expire floppy, zipdisk, cdrom
and nfs 
mounts just fine.

Except 2 of the systems won't umount nested nfs mounts on timeout.
These nfs mounts stay mounted forever. No messages appear the logs
not even messages to indicate that automount has timed out the 
mounts and is trying to umount them.

If I umount the lower dependant nfs mounts, leaving only the top
autofs nfs mount, the top level autofs nfs mount will expire normally.

here is a sample line from the auto.nfs file

routera         -fstype=nfs,soft        / routera:/ /usr routera:/usr /src
routera:/src

Google didn't have any answers when looking through the mailing list
with "autofs expire nested"

The systems are near identical (cloned progressively from each other,
so there will be some differences and some machines get updated more
often, but the differences should be small).

Comparing the kernels of a pair of machines, one of which auto expires
OK and one which doesn't, I find in the file system section

machine that does autoexpire nested nfs mounts

  < > Kernel automounter support
  <M> Kernel automounter version 4 support (also supports v3)

machine that doesn't autoexpire nested nfs mounts

  <M> Kernel automounter support
  <M> Kernel automounter version 4 support (also supports v3)

Re-compiling the kernel/modules on the machine that doesn't work
with the .config for the machine that does work, fixes the problem.
I assume having the first line turned on kills the auto expiration
for nested nfs mounts, but I don't know why.

I guess this is a bug report.

I'm using kernel 2.4.26, libc-2.3.2, gcc 2.95.3, autofs-4.0.0pre10

I can't get the automount from autofs-4.1.2 to load on the machine which 
doesn't autoexpire. automount runs and exits with no process in the ps table, 
no errors in the logs. Running with -d gives a few lines in the log files 
as it fires up, but no error messages. firing up the demon under strace,
looks the same in both cases, as I don't see anything after the fork().

autofs-4.1.2 works fine on the machine without the first module.

Request: Can the install script not overwrite any existing /etc/auto.* 
files please? You can install new ones as auto.*.NEW if you like.

Request: Can automount be loaded without going into demon mode, so that I can 
watch the logs on stdout?

Thanks Joe

-- 
Joseph Mack NA3T EME(B,D), FM05lw North Carolina
jmack (at) wm7d (dot) net - azimuthal equidistant map
generator at http://www.wm7d.net/azproj.shtml
Homepage http://www.austintek.com/ It's GNU/Linux!
