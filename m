From: Tom Georgoulias <tom.georgoulias@freescale.com>
Subject: Re: mount point created if automount map is empty during
 daemon startup?
Date: Tue, 04 May 2004 10:26:08 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4097B610.6090405@freescale.com>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<Pine.LNX.4.58.0405032046130.3257@donald.themaw.net>
	<20040503175506.GA14889@sun.com> <20040504003214.GA31852@neu.nirvana>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504010928.GL14889@sun.com> <20040504122536.GK5041@neu.nirvana>
	<4097AABF.5050709@freescale.com>
	<Pine.LNX.4.58.0405042248180.17014@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405042248180.17014@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

raven@themaw.net wrote:

> Can you try killing and then starting that automount process by hand.

There wasn't any daemon running for that mount, so I started it by hand 
and the mount is now functional.

I'm really confused as to why there wasn't a daemon running in the first 
place.  There should've been, right?  I just checked a second system 
where this was an issue and it is the same, not automount running for 
/sync.  Starting it manually also gets the mount working.

[root@hatfield12 init.d]# ps -ef | grep sync
root      1952 30817  0 09:57 pts/1    00:00:00 grep sync
[root@hatfield12 init.d]# /usr/sbin/automount /sync yp auto.sync 
-rw,hard,intr rsize=32768,wsize=32768
[root@hatfield12 init.d]# ls /
bin     designs  eng     home    lost+found  proc  sbin  sync     usr
boot    dev      etc     initrd  mnt         proj  sea   tmp      var
design  docs     extern  lib     opt         root  soc   _TOOLS_
[root@hatfield12 init.d]# cd /sync
[root@hatfield12 sync]# ls
[root@hatfield12 sync]# cd cache/tx30/tec/moccasin/s9a/
[root@hatfield12 s9a]# ls
s9a003a358100a3fb-1.1-1066343169-0    s9a8254af9c23b915-1.21-1079127946-0
s9a01243cb66ae420-1.5-1077918456-0    s9a8254af9c23b915-1.22-1082349030-0
s9a01d98600756aeb-1.1-1078525174-dir  s9a8254af9c23b915-1.23-1083337330-0
s9a020e8a919ca408-1.1-1061176253-0    s9a82a9998c51e8c9-1.1-1058813656-0
s9a021d52f809fdbc-1.2-1078845514-0    s9a83027946cc8cd7-1.2-1046231817-0

> 
> Just send a normal (TERM) kill and see if it exits normally.
> 
> I would be interested in seeing anything in the log.

There doesn't seem to be anything related to this map, save for the 
event when I ran a script that sends a HUP to the daemon responsible for 
this map and noticed this problem all together.

Is there a particular string you'd like for me to search against?

[root@hatfield12 log]# grep auto.sync messages
Feb 20 09:57:34 hatfield12 automount[1597]: starting automounter version 
4.1.0, path = /sync, maptype = yp, mapname = auto.sync
Feb 20 15:33:42 hatfield12 automount[25801]: starting automounter 
version 4.1.0, path = /sync, maptype = yp, mapname = auto.sync
Feb 20 15:59:47 hatfield12 automount[1609]: starting automounter version 
4.1.0, path = /sync, maptype = yp, mapname = auto.sync
Feb 20 16:35:52 hatfield12 automount[1605]: starting automounter version 
4.1.0, path = /sync, maptype = yp, mapname = auto.sync
Mar 20 08:50:41 hatfield12 automount[1257]: starting automounter version 
4.1.0, path = /sync, maptype = yp, mapname = auto.sync
Mar 21 11:38:57 hatfield12 automount[1273]: starting automounter version 
4.1.0, path = /sync, maptype = yp, mapname = auto.sync
May  4 08:26:51 hatfield12 in.rshd[23849]: root@bender as root: 
cmd='pkill -HUP -f auto.sync'

-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Freescale Semiconductor Internal Use
[] Freescale Semiconductor Confidential Proprietary
