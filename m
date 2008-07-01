From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Subject: Re: More autofs problems
Date: Tue, 01 Jul 2008 07:49:04 +0200
Message-ID: <4869C550.6040708@aei.mpg.de>
References: <4868946B.7050801@aei.mpg.de>	
	<1214815665.3008.11.camel@raven.themaw.net>
	<4868B0BA.9040208@aei.mpg.de>	
	<1214822142.3008.18.camel@raven.themaw.net>
	<4868DD3C.5020706@aei.mpg.de>	
	<1214832384.3008.27.camel@raven.themaw.net>
	<4868EA97.4000103@aei.mpg.de>	
	<1214835616.3008.35.camel@raven.themaw.net>
	<4868EE71.7070607@aei.mpg.de>
	<1214836889.3008.45.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214836889.3008.45.camel@raven.themaw.net>
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

Hi again,

Ian Kent wrote:
> But then it's been included in RHEL-5 from initial release and it's
> holding up fine.

We'll try autofs5 on at leat one node possibly later today, either Jan,
Steffen or I should succeed in backporting it (and getting around the
LDAP problem).

However I still have v4 related question.

We're merciless and run this on one of the nodes:

$ cat test_mount
#!/bin/sh

n_node=1000

for i in `seq 1 $n_node`;do
        n=`echo $RANDOM%1342+10001 | bc| sed -e "s/1/n/"`
        $HOME/bin/mount.sh $n&
        echo -n .
done

$ cat mount.sh
#!/bin/sh

dir="/distributed/spray/data/EatH/S5R1"

ping -c1 -w1 $1 > /dev/null&& file="/atlas/node/$1$dir/"`ls -f
/atlas/node/$1$dir/|head -n 50 | tail -n 1`
md5sum ${file}


Running this gives this in syslog:
Jul  1 07:37:19 n1312 rpc.idmapd[2309]: nfsopen:
open(/var/lib/nfs/rpc_pipefs/nfs/clntaa58/idmap): Too many open files
Jul  1 07:37:19 n1312 rpc.idmapd[2309]: nfsopen:
open(/var/lib/nfs/rpc_pipefs/nfs/clntaa58/idmap): Too many open files
Jul  1 07:37:19 n1312 rpc.idmapd[2309]: nfsopen:
open(/var/lib/nfs/rpc_pipefs/nfs/clntaa5e/idmap): Too many open files
Jul  1 07:37:19 n1312 rpc.idmapd[2309]: nfsopen:
open(/var/lib/nfs/rpc_pipefs/nfs/clntaa5e/idmap): Too many open files
Jul  1 07:37:19 n1312 rpc.idmapd[2309]: nfsopen:
open(/var/lib/nfs/rpc_pipefs/nfs/clntaa9c/idmap): Too many open files

Which is not surprising to me. However, there are a few things I'm
wondering about.

(1) Shall I try the nfs list at sourceforge or is that list only full of
spam?
(2) All our mounts use nfsvers=3 why is rpc.idmapd involved at all?
(3) Why is this daemon growing so extremely large?
# ps aux|grep rpc.idmapd
root      2309  0.1 16.2 2037152 1326944 ?     Ss   Jun30   1:24
/usr/sbin/rpc.idmapd
(4) The script maxes out at about 340 concurrent mounts, any idea how to
increase this number?
(5) Finally autofs related again: After running the script, /proc/mounts
has these leftovers:

n0765:/local /atlas/node/n0765 nfs
rw,vers=3,rsize=32768,wsize=32768,soft,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=10.10.7.65
0 0
n1058:/local /atlas/node/n1058 nfs
rw,vers=3,rsize=32768,wsize=32768,soft,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=10.10.10.58
0 0
n0232:/local /atlas/node/n0232 nfs
rw,vers=3,rsize=32768,wsize=32768,soft,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=10.10.2.32
0 0
n0409:/local /atlas/node/n0409 nfs
rw,vers=3,rsize=32768,wsize=32768,soft,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=10.10.4.9
0 0
n0022:/local /atlas/node/n0022 nfs
rw,vers=3,rsize=32768,wsize=32768,soft,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=10.10.0.22
0 0
n0549:/local /atlas/node/n0549 nfs
rw,vers=3,rsize=32768,wsize=32768,soft,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=10.10.5.49
0 0
n0016:/local /atlas/node/n0016 nfs
rw,vers=3,rsize=32768,wsize=32768,soft,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=10.10.0.16
0 0
n0975:/local /atlas/node/n0975 nfs
rw,vers=3,rsize=32768,wsize=32768,soft,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=10.10.9.75
0 0


Which I need to umount manually now, remove the empty directories under
/atlas/node before I could restart autofs.

Any idea or did we set-up our systems somewhat flawed?

Cheers

Carsten
