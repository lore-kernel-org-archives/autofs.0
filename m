From: Hans Deragon <hans@deragon.biz>
Subject: Re: auto.net gets a key with a path under SLES9.
Date: Wed, 30 Nov 2005 14:46:40 -0500
Message-ID: <438E01A0.8060205@deragon.biz>
References: <4378ED9A.6090903@deragon.biz> <43877F6F.5000708@deragon.biz>
	<Pine.LNX.4.63.0511272135350.2462@donald.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_HqwqLViYyGtG/tMWYhjYVQ)"
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.63.0511272135350.2462@donald.themaw.net>
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_HqwqLViYyGtG/tMWYhjYVQ)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Resending this email since it seams not to have made it to the mailing list.

-Hans

-------------------------->

Ian Kent wrote:
> On Fri, 25 Nov 2005, Hans Deragon wrote:
> 
> 
>>Greetings.
>>
>>
>>  Well, I successfully reproduced the problem of a path sent to auto.net (see
>>below for full description).  Attached, the debug output on syslogd.  From
>>what I understand of the syslogd logs, the problem occurs before sun_mount()
>>is called.
>>
>>  What I did was:
>>
>>  cd /net/asterix  # Everything is ok.  $key=asterix
>>  cd asteris-07    # Bug:  $key=asterix/asterix-07
> 
> 
> Yes. Undoubtably the problem and that will be in the kernel module.
> 
> 
>>  What was passed to auto.net was asterix/asterix-07 at the second 'cd'.
> 
> 
> I would like to see the output of auto.net run manually and with the 
> incorrect key please.
> 
> Do you have access to the source for for the kernel you are using so that 
> we may check the patch levels?
> 
> Ian

Greetings Ian.


    Here is the output of auto.net.

[root@mysystem etc] auto.net asterix/asterix-07
/usr/sbin/showmount: can't get address for asterix/asterix-07
[root@mysystem etc] auto.net asterix
-fstype=nfs,hard,intr,nodev,nosuid \
          /asterix-00 asterix:/asterix-00 \
          /asterix-01 asterix:/asterix-01 \
          /asterix-02 asterix:/asterix-02 \
          /asterix-03 asterix:/asterix-03 \
          /asterix-04 asterix:/asterix-04 \
          /asterix-05 asterix:/asterix-05 \
          /asterix-06 asterix:/asterix-06

    Please note that in my previous email, when I reproduced
    the problem, I used a patched auto.net which would remove
    the path.  This is not the case above, since I wanted to
    reproduce the problem for you.

    This said, I just realized that the recursive path problem
    occurs when I try to 'cd' to an NFS share that does not
    exist (I have not realized this earlier; my bad).  For
    instance, with my patched auto.net,
    /net/asterix/asterix-07 mounts with the content of
    /net/asterix, which is wrong.  It should not mount.

    So I am starting to realize that maybe there is no bug...
    If I leave auto.net untouched, I do get the proper error,
    i.e.:

    [root@mysystem /net/asterix] cd asterix-07
    -bash: cd: asterix-07: No such file or directory

    Yet... I think that auto.net should not receive a path.
    So there might be a bug, but a minor one?

    I would need to find a case where a path is sent to
    auto.net when trying to access a valid NFS share.

    Attached, the auto.net, unpatched (actually, my patch is
    commented out).

    Also, I do have the kernel's source.


Best regards,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.
http://www.deragon.biz        Open source (contribution):
mailto://hans@deragon.biz     http://autopoweroff.deragon.biz


--Boundary_(ID_HqwqLViYyGtG/tMWYhjYVQ)
Content-type: text/plain; CHARSET=US-ASCII; name=auto.net
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=auto.net

#!/bin/bash

# $Id: auto.net,v 1.8 2005/04/05 13:02:09 raven Exp $

# This file must be executable to work! chmod 755!

# Look at what a host is exporting to determine what we can mount.
# This is very simple, but it appears to work surprisingly well

# Modified by Hans Deragon, 2005/10/26, 12:57 EDT
# key should be only the hostname, but for some reason, this
# script sometimes receives an NFS share in the form <hostname>/<path>,
# which is wrong.
#echo $1 >>/tmp/auto.net.out
#key=`echo $1 | perl -wp -e 's%^(\w+)(\/?.+)*$%$1%;'`
key=$1  # Original code

# add "nosymlink" here if you want to suppress symlinking local filesystems
# add "nonstrict" to make it OK for some filesystems to not mount
opts="-fstype=nfs,hard,intr,nodev,nosuid"

# Showmount comes in a number of names and varieties.  "showmount" is
# typically an older version which accepts the '--no-headers' flag
# but ignores it.  "kshowmount" is the newer version installed with knfsd,
# which both accepts and acts on the '--no-headers' flag.
#SHOWMOUNT="kshowmount --no-headers -e $key"
#SHOWMOUNT="showmount -e $key | tail -n +2"

for P in /bin /sbin /usr/bin /usr/sbin
do
	for M in showmount kshowmount
	do
		if [ -x $P/$M ]
		then
			SMNT=$P/$M
			break
		fi
	done
done

[ -x $SMNT ] || exit 1

# Newer distributions get this right
SHOWMOUNT="$SMNT --no-headers -e $key"

$SHOWMOUNT | LC_ALL=C sort +0 | \
	awk -v key="$key" -v opts="$opts" -- '
	BEGIN	{ ORS=""; first=1 }
		{ if (first) { print opts; first=0 }; print " \\\n\t" $1, key ":" $1 }
	END	{ if (!first) print "\n"; else exit 1 }
	'


--Boundary_(ID_HqwqLViYyGtG/tMWYhjYVQ)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary_(ID_HqwqLViYyGtG/tMWYhjYVQ)--

