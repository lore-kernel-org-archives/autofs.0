From: Michael Marion <mmarion@qualcomm.com>
Subject: Strange new /net behavior
Date: Thu, 2 Jun 2005 14:04:33 -0700 (PDT)
Message-ID: <200506022104.j52L4X8B014371@magus.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: INLINE
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

I just noticed an improper behavior with 4.1.4 (and patches) regarding /net
that I've not seen yet.

I just upgraded a host to 4.1.4 with the latest patches from kernel.org:
autofs-4.1.4-misc-fixes.patch
autofs-4.1.4-multi-parse-fix.patch
autofs-4.1.4-non-replicated-ping.patch

/net is mounting the paths improperly if there's only one export from a host..

i.e.
kydland SOURCES {504}$ /etc/auto.net cornholio
-fstype=nfs,hard,intr,nodev,nosuid \
        /local/mnt cornholio:/local/mnt
kydland SOURCES {505}$ ls /net/cornholio
suse-9.2  workspace  x86_64
kydland SOURCES {506}$ mount | grep cornholio
cornholio:/local/mnt on /net/cornholio type nfs
(rw,nosuid,nodev,hard,intr,addr=129.46.234.38)


vs:
kydland SOURCES {507}$ /etc/auto.net uranium
-fstype=nfs,hard,intr,nodev,nosuid \
        /local/mnt uranium:/local/mnt \
        /local/scratch uranium:/local/scratch
kydland SOURCES {508}$ ls /net/uranium
local
kydland SOURCES {509}$ mount | grep uranium
uranium:/local/mnt on /net/uranium/local/mnt type nfs
(rw,nosuid,nodev,hard,intr,addr=129.46.26.26)
uranium:/local/scratch on /net/uranium/local/scratch type nfs
(rw,nosuid,nodev,hard,intr,addr=129.46.26.26)

I'm still using a program map for /net.. had issues with mounts to something
where as soon as one path failed to mount, the rest were ignored.  I remember
someone mentioning an option to automount that would fix that, but when I
tried it (a long time ago) it didn't work, at least not for me.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
[Talking about web page "design"] 
"I think my standards have lowered enough that now I think ``good design'' is 
when the page doesn't irritate the living #$*% out of me." 
==>jwz (http://www.jwz.org/gruntle/design.html)
