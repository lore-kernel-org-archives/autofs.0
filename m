From: raven@themaw.net
Subject: Re: mount point created if automount map is empty during
 daemon startup?
Date: Tue, 4 May 2004 22:53:14 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405042248180.17014@donald.themaw.net>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<20040503175506.GA14889@sun.com>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504010928.GL14889@sun.com> <20040504122536.GK5041@neu.nirvana>
	<4097AABF.5050709@freescale.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4097AABF.5050709@freescale.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Georgoulias <tom.georgoulias@freescale.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 4 May 2004, Tom Georgoulias wrote:

> Ran into an issue today where many of my systems running autofs4 do not 
> have a mount point for one my automount maps.  The map in question, 
> auto.sync, has existed since mid-March but remained empty until last 
> week when an entry was added to create the /sync/caches mount.  Is this 
> expected behavior or do I have a misconfiguration or bug on my hands?
> 
> hatfield12:tomg$ ypcat -k auto.sync
> cache duncan:/vol/vol02/sync_caches/&
> hatfield12:tomg$ ls -ld /sync
> ls: /sync: No such file or directory
> hatfield12:tomg$ /sbin/service autofs status | grep sync
> /usr/sbin/automount /sync yp auto.sync -rw,hard,intr rsize=32768,wsize=32768
>

Bit odd.

I'll try to duplicate this using an empty map.

Can you try killing and then starting that automount process by hand.

Just send a normal (TERM) kill and see if it exits normally.

I would be interested in seeing anything in the log.

Ian
