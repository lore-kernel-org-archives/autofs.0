From: mmarion@qualcomm.com
Subject: Re: /net with program map problem on x86_64
Date: Mon, 8 Mar 2004 14:06:25 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403082206.i28M6PgQ016051@miguelito.qualcomm.com>
References: <Pine.LNX.4.44.0402020117160.266-100000@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402020117160.266-100000@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On  2 Feb, Ian Kent wrote:


> Would be except for the 64 bit compile problem as Micheals problem is
> clearly in the kernel module.
> 
> Kernel module version?

It's not syslogging properly since the change to the stdarg stuff, but it's
the same patch in the autofs4-2.4-module-20031201.tar.bz2 file... 4.04?

> This looks very similar to the problem Micheal reported.
> 
> Can you provide a example of the map so I can duplicate it.

Sure... putting script at bottom.. results are identical to what I get on the
32bit systems.  

> Your going to haye me for this but a debug trace of the kernel module
> would be good.

Not a problem.. got a dev box I've been doing "suse autoyast -> our company
image via pxe boot" right here.

> You can do this by setting the DEBUG define in the kernel module source
> file autofs_i.h.

=====
mmarion @ rs-blade 80 [fs]% cat /etc/auto.net
#!/bin/bash

# $Id: auto.net.or,v 1.1 2003/11/05 21:05:44 mmarion Exp $

# Look at what a host is exporting to determine what we can mount.
# This is very simple, but it appears to work surprisingly well

key="$1"

# add "nosymlink" here if you want to suppress symlinking local filesystems
# add "nonstrict" to make it OK for some filesystems to not mount
/usr/sbin/rpcinfo -t $key nfs 3 > /dev/null 2>&1
if [[ $? -eq 0 ]] 
then
  opts="-fstype=nfs,tcp,rsize=32768,wsize=32768,hard,intr,nodev,nosuid"
else
  opts="-fstype=nfs,hard,intr,nodev,nosuid"
fi

# Showmount comes in a number of names and varieties.  "showmount" is
# typically an older version which accepts the '--no-headers' flag
# but ignores it.  "kshowmount" is the newer version installed with knfsd,
# which both accepts and acts on the '--no-headers' flag.
#SHOWMOUNT="kshowmount --no-headers -e $key"
#SHOWMOUNT="showmount -e $key | tail +2"

# Newer distributions get this right
SHOWMOUNT="showmount --no-headers -e $key"

hostname=`hostname`
{
$SHOWMOUNT | sed 's/*/(everyone)/g' | while read line
do
  perm=`echo $line | awk '{print $2}'`
  for item in `echo $perm | sed 's/,/ /g'`
  do
    item=`echo $item | sed 's/@//'`
    if [ "$item" = "(everyone)" ]
    then
      #MOUNTS="${MOUNTS}_$line"
      echo $line
    elif [ "$item" = "$hostname" ] || [ "$item" = "${hostname}.qualcomm.com" ]
    then
      #MOUNTS="${MOUNTS}_$line"
      echo $line
    elif [ -n "`ypmatch $item netgroup 2>/dev/null`" ] 
    then
      if [ -n "`getent netgroup $item 2>/dev/null| grep
"${hostname}.qualcomm.com" |awk '{print $1}'`" ]
      then
       echo $line
      fi
    fi
  done
done
} | sort +0 | \
	awk -v key="$key" -v opts="$opts" -- '
	BEGIN		{ ORS=""; first=1 }
			{ if (first) { print opts; first=0 }; print " \\\n\t"
$1, key ":" $1 }
	END		{ if (!first) print "\n"; else exit 1 }

=====
Please ignore the funky netgrouping bits I added in there... I did that awhile
back so that it doesn't try to mount stuff the client has no access too,
before I heard about the -nostrict (or whatever) flag it was.  BTW, I tried
that flag and it didn't seem to help with a program map.  I will try to play
with the built-in /net bits too to see if that works.  If it does, then I can
probably stick with that, but will give debug info too.

Output like so:
mmarion @ rs-blade 81 [fs]% /etc/auto.net mig
-fstype=nfs,tcp,rsize=32768,wsize=32768,hard,intr,nodev,nosuid \
	/local/mnt mig:/local/mnt
mmarion @ rs-blade 82 [fs]% /etc/auto.net nowin
-fstype=nfs,hard,intr,nodev,nosuid \
	/local/mnt nowin:/local/mnt\
mmarion @ rs-blade 84 [fs]% /etc/auto.net bridgman
-fstype=nfs,hard,intr,nodev,nosuid \
	/local/mnt bridgman:/local/mnt \
	/local/scratch bridgman:/local/scratch


Now that I have different flags when the server supports tcp mode.. but mounts
fail to all hosts, tcp or no tcp support.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
President Grant: "Mr. West, not every situation requires your patented approach
of shoot first, shoot later, shoot some more and then when everybody's dead try
to ask a question or two." -- Wild Wild West 
