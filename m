From: Keith Owens <kaos@ocs.com.au>
Subject: Limit on return string from program map
Date: Thu, 16 Dec 2004 17:27:04 +1100
Message-ID: <21502.1103178424@kao2.melbourne.sgi.com>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Kernel 2.6.9, autofs v4 as a module, autofs-4.1.3-28 (FC3).  I added
"/net /etc/auto.net" to /etc/auto.master and it works fine, up to a
point.  ps shows

/usr/sbin/automount --timeout=60 /net program /etc/auto.net

If the target server has a lot of mounted filesystems then automount
will only mount the first few entries on the list.  Then it tries to
run mount with invalid input.  It looks like there is a hard coded
limit on the string that automount expects from a program map.  My
virtual CD server has lots of CD images mounted over loopback, each
with its own export entry, so the return string from auto.net is quite
long.

"/etc/auto.net virtcd" returns a long string, over 20K.  The start of
this string is below, some of the names have been sanitized without
changing their length.  irix-6.5.21-overlays-4 mounts correctly,
irix-6.5.22-applications-1 does not.  Instead of issuing

  /bin/mount -t nfs -s -o hard,intr,nodev,nosuid virtcd:/virtcd/mnt/irix-6.5.22-applications-1 /net/virtcd/virtcd/mnt/irix-6.5.22-applications-1

it issues

  /bin/mount -t nfs -s -o hard,intr,nodev,nosuid virtcd:/virtcd/mnt /net/virtcd/virtcd/mnt/irix-6.5.22-applications-1

The NFS directory string has been truncated.  Interesting that the
failure point is around the 4K mark on the input string.

-fstype=nfs,hard,intr,nodev,nosuid \
	/ virtcd:/ \
	/virtcd virtcd:/virtcd \
	/virtcd/mnt/xxxxxxxxxxxxxxxxxxxxxxxx-009.iso virtcd:/virtcd/mnt/xxxxxxxxxxxxxxxxxxxxxxxx-009.iso \
	/virtcd/mnt/xxxxxxxxxxxxxxxxxxxxxxxx-1162-xxx.iso virtcd:/virtcd/mnt/xxxxxxxxxxxxxxxxxxxxxxxx-1162-xxx.iso \
	/virtcd/mnt/xxxxxxxxxxxxxxxxxxxxxxxx-004.iso virtcd:/virtcd/mnt/xxxxxxxxxxxxxxxxxxxxxxxx-004.iso \
	/virtcd/mnt/xxxxxxxxxxxxxxxx-MR-1 virtcd:/virtcd/mnt/xxxxxxxxxxxxxxxx-MR-1 \
	/virtcd/mnt/xxxxxxxxxxxxxxxx-RC1-1 virtcd:/virtcd/mnt/xxxxxxxxxxxxxxxx-RC1-1 \
	/virtcd/mnt/xxxxxxxxxxxxxxxx-RC2-1 virtcd:/virtcd/mnt/xxxxxxxxxxxxxxxx-RC2-1 \
	/virtcd/mnt/xxxxxxxxxxxxxx_28_05_02-1 virtcd:/virtcd/mnt/xxxxxxxxxxxxxx_28_05_02-1 \
	/virtcd/mnt/xxxxx-xxxxx-1 virtcd:/virtcd/mnt/xxxxx-xxxxx-1 \
	/virtcd/mnt/FC2-i386-disc1.iso virtcd:/virtcd/mnt/FC2-i386-disc1.iso \
	/virtcd/mnt/FC2-i386-disc2.iso virtcd:/virtcd/mnt/FC2-i386-disc2.iso \
	/virtcd/mnt/FC2-i386-disc3.iso virtcd:/virtcd/mnt/FC2-i386-disc3.iso \
	/virtcd/mnt/FC2-i386-disc4.iso virtcd:/virtcd/mnt/FC2-i386-disc4.iso \
	/virtcd/mnt/FC2-i386-rescuecd.iso virtcd:/virtcd/mnt/FC2-i386-rescuecd.iso \
	/virtcd/mnt/FC2-i386-SRPMS-disc1.iso virtcd:/virtcd/mnt/FC2-i386-SRPMS-disc1.iso \
	/virtcd/mnt/FC2-i386-SRPMS-disc2.iso virtcd:/virtcd/mnt/FC2-i386-SRPMS-disc2.iso \
	/virtcd/mnt/FC2-i386-SRPMS-disc3.iso virtcd:/virtcd/mnt/FC2-i386-SRPMS-disc3.iso \
	/virtcd/mnt/FC2-i386-SRPMS-disc4.iso virtcd:/virtcd/mnt/FC2-i386-SRPMS-disc4.iso \
	/virtcd/mnt/FC3-i386-disc1.iso virtcd:/virtcd/mnt/FC3-i386-disc1.iso \
	/virtcd/mnt/FC3-i386-disc2.iso virtcd:/virtcd/mnt/FC3-i386-disc2.iso \
	/virtcd/mnt/FC3-i386-disc3.iso virtcd:/virtcd/mnt/FC3-i386-disc3.iso \
	/virtcd/mnt/FC3-i386-disc4.iso virtcd:/virtcd/mnt/FC3-i386-disc4.iso \
	/virtcd/mnt/FC3-i386-rescuecd.iso virtcd:/virtcd/mnt/FC3-i386-rescuecd.iso \
	/virtcd/mnt/FC3-i386-SRPMS-disc1.iso virtcd:/virtcd/mnt/FC3-i386-SRPMS-disc1.iso \
	/virtcd/mnt/FC3-i386-SRPMS-disc2.iso virtcd:/virtcd/mnt/FC3-i386-SRPMS-disc2.iso \
	/virtcd/mnt/FC3-i386-SRPMS-disc3.iso virtcd:/virtcd/mnt/FC3-i386-SRPMS-disc3.iso \
	/virtcd/mnt/FC3-i386-SRPMS-disc4.iso virtcd:/virtcd/mnt/FC3-i386-SRPMS-disc4.iso \
	/virtcd/mnt/xxxxxxxx-xxxxxx-1 virtcd:/virtcd/mnt/xxxxxxxx-xxxxxx-1 \
	/virtcd/mnt/xxxxxxxx-xxxxxx-2 virtcd:/virtcd/mnt/xxxxxxxx-xxxxxx-2 \
	/virtcd/mnt/xxxxxxxx-xxxxxx-3 virtcd:/virtcd/mnt/xxxxxxxx-xxxxxx-3 \
	/virtcd/mnt/xxxxxxxx-xxxxxx-4 virtcd:/virtcd/mnt/xxxxxxxx-xxxxxx-4 \
	/virtcd/mnt/irix-6.5.18-applications-1 virtcd:/virtcd/mnt/irix-6.5.18-applications-1 \
	/virtcd/mnt/irix-6.5.18-overlays-1 virtcd:/virtcd/mnt/irix-6.5.18-overlays-1 \
	/virtcd/mnt/irix-6.5.18-overlays-2 virtcd:/virtcd/mnt/irix-6.5.18-overlays-2 \
	/virtcd/mnt/irix-6.5.18-overlays-3 virtcd:/virtcd/mnt/irix-6.5.18-overlays-3 \
	/virtcd/mnt/irix-6.5.18-overlays-4 virtcd:/virtcd/mnt/irix-6.5.18-overlays-4 \
	/virtcd/mnt/irix-6.5.19-applications-1 virtcd:/virtcd/mnt/irix-6.5.19-applications-1 \
	/virtcd/mnt/irix-6.5.19-overlays-1 virtcd:/virtcd/mnt/irix-6.5.19-overlays-1 \
	/virtcd/mnt/irix-6.5.19-overlays-2 virtcd:/virtcd/mnt/irix-6.5.19-overlays-2 \
	/virtcd/mnt/irix-6.5.19-overlays-3 virtcd:/virtcd/mnt/irix-6.5.19-overlays-3 \
	/virtcd/mnt/irix-6.5.19-overlays-4 virtcd:/virtcd/mnt/irix-6.5.19-overlays-4 \
	/virtcd/mnt/irix-6.5.20-applications-1 virtcd:/virtcd/mnt/irix-6.5.20-applications-1 \
	/virtcd/mnt/irix-6.5.20-overlays-1 virtcd:/virtcd/mnt/irix-6.5.20-overlays-1 \
	/virtcd/mnt/irix-6.5.20-overlays-2 virtcd:/virtcd/mnt/irix-6.5.20-overlays-2 \
	/virtcd/mnt/irix-6.5.20-overlays-3 virtcd:/virtcd/mnt/irix-6.5.20-overlays-3 \
	/virtcd/mnt/irix-6.5.20-overlays-4 virtcd:/virtcd/mnt/irix-6.5.20-overlays-4 \
	/virtcd/mnt/irix-6.5.21-applications-1 virtcd:/virtcd/mnt/irix-6.5.21-applications-1 \
	/virtcd/mnt/irix-6.5.21-overlays-1 virtcd:/virtcd/mnt/irix-6.5.21-overlays-1 \
	/virtcd/mnt/irix-6.5.21-overlays-2 virtcd:/virtcd/mnt/irix-6.5.21-overlays-2 \
	/virtcd/mnt/irix-6.5.21-overlays-3 virtcd:/virtcd/mnt/irix-6.5.21-overlays-3 \
	/virtcd/mnt/irix-6.5.21-overlays-4 virtcd:/virtcd/mnt/irix-6.5.21-overlays-4 \
	/virtcd/mnt/irix-6.5.22-applications-1 virtcd:/virtcd/mnt/irix-6.5.22-applications-1 \
	/virtcd/mnt/irix-6.5.22-applications-2 virtcd:/virtcd/mnt/irix-6.5.22-applications-2 \
	/virtcd/mnt/irix-6.5.22-overlays-1 virtcd:/virtcd/mnt/irix-6.5.22-overlays-1 \
	/virtcd/mnt/irix-6.5.22-overlays-2 virtcd:/virtcd/mnt/irix-6.5.22-overlays-2 \
	/virtcd/mnt/irix-6.5.22-overlays-3 virtcd:/virtcd/mnt/irix-6.5.22-overlays-3 \

	Another 16K of entries suppressed.
