From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [BUG] 5.0.0_beta1: does not auto-unmount
Date: Wed, 26 Sep 2007 11:23:41 +0100
Message-ID: <200709261123.41401.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tMj+GsTAyJBhMeI"
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--Boundary-00=_tMj+GsTAyJBhMeI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ian,

I run automount like this:

# automount -f -s -v --timeout 15 /.local/var/service/automount/master.file

My master.file is one-liner:

/mnt/auto program:/.local/var/service/automount/mapper.sh

mapper.sh is attached.

This setup (with this exact mapper.sh) worked flawlessly
with 4.1.4, but with 5.0.0_beta1 I have a problem:

# automount -f -s -v --timeout 15 /.local/var/service/automount/master
Starting automounter version 5.0.0_beta1, master map /.local/var/service/automount/master
using kernel protocol version 5.00
using timeout 15 seconds; freq 4 secs

I do "cd /mnt/auto/vfat.sdb1" (sdb1 is my USB memory stick)
and automount says:

attempting to mount entry /.local/mnt/auto/vfat.sdb1
mounted /mnt/auto/vfat.sdb1

So far so good, mount shows:
/dev/sdb1 on /mnt/auto/vfat.sdb1 type vfat (rw,nosuid,noexec,fmask=0000,dmask=0000,codepage=cp866,iocharset=koi8-r,shortname=win95,quiet,uni_xlate)

But it never auto-unmounts. I am 100% sure nothing
is keeping files or directories busy on /dev/sdb1 (I cd'ed away
from the directory). Automount is not saying anything,
strace -p <PID> shows one line:

rt_sigtimedwait(~[CHLD CONT RTMIN RT_1],

I killed 4 hours of my time making automount 5.0.0 even start on my machine,
and it's 4:00 am here, so at this time I am a rather unhappy panda and
probably I'll go back to 4.1.4 instead of chasing down yet another bug.

# size autofs*/sbin/*
   text    data     bss     dec     hex filename
  35143     916   10084   46143    b43f autofs-4.1.4_beta1/sbin/automount
 118494    1344     884  120722   1d792 autofs-5.0.0_beta1/sbin/automount

During 4.1.4 -> 5.0.0 size has *tripled*. Uncool. :(
--
vda

--Boundary-00=_tMj+GsTAyJBhMeI
Content-Type: application/x-shellscript;
  name="mapper.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mapper.sh"

#!/bin/sh

#
# Mountpoint mapper for automounter
#

#
#smbfs ignores all options when it sees 'noatime'
#
STD="" #STD=",noatime"

OPT=""
# Replace @ by / in mount
MOUNT=`echo $1 | sed 's/@/\//g'`

# Separate mount and options: mount%options
if test "${MOUNT/*%*/exists}" = "exists"; then # there is a '%'
    OPT=,`echo ${MOUNT/*%/}`
    SZ=$(( ${#MOUNT} - ${#OPT} ))
    MOUNT=`echo ${MOUNT:0:$SZ}`
fi

OPT="$OPT$STD"

while true; do
    case "$MOUNT" in
    ro.*)
        OPT=",ro$OPT"
        MOUNT="${MOUNT:3:9999}"
        ;;
    dev.*) # format is: dev.name[%options]
        OPT=",fstype=auto$OPT"
        echo "-${OPT:1:9999} :/dev/${MOUNT:4:9999}"
        exit 0
        ;;
    vfat.*) # format is: vfat.name[%options]
        OPT=",fstype=vfat,umask=000,quiet,nocase,nosuid,noexec,uni_xlate=1,codepage=866,iocharset=koi8-r$OPT"
        echo "-${OPT:1:9999} :/dev/${MOUNT:5:9999}"
        exit 0
        ;;
    ntfs.*) # format is: ntfs.name[%options]
        OPT=",fstype=ntfs,iocharset=koi8-r,ro$OPT"
        echo "-${OPT:1:9999} :/dev/${MOUNT:5:9999}"
        exit 0
        ;;
    smb.*) # format is: smb.host@share[%options]
        OPT=",fstype=smbfs,fmask=644,dmask=755,codepage=cp866,iocharset=koi8-r,$OPT"
        echo "-${OPT:1:9999} ://${MOUNT:4:9999}"
        exit 0
        ;;
    nfs.*) # format is: nfs.host:@dir[@dir]...[%options]
        OPT=",fstype=nfs$OPT"
        echo "-${OPT:1:9999} ${MOUNT:4:9999}"
        exit 0
        ;;
    *) # format is: name[%options]
        OPT=",fstype=auto$OPT"
        echo "-${OPT:1:9999} :/dev/$MOUNT"
        exit 0
        ;;
    esac
done

--Boundary-00=_tMj+GsTAyJBhMeI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_tMj+GsTAyJBhMeI--

