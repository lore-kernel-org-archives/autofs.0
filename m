From: Tom Georgoulias <tom.georgoulias@freescale.com>
Subject: mount point created if automount map is empty during daemon startup?
Date: Tue, 04 May 2004 09:37:51 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4097AABF.5050709@freescale.com>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<Pine.LNX.4.58.0405032046130.3257@donald.themaw.net>
	<20040503175506.GA14889@sun.com> <20040504003214.GA31852@neu.nirvana>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504010928.GL14889@sun.com> <20040504122536.GK5041@neu.nirvana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040504122536.GK5041@neu.nirvana>
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
To: autofs mailing list <autofs@linux.kernel.org>

Ran into an issue today where many of my systems running autofs4 do not 
have a mount point for one my automount maps.  The map in question, 
auto.sync, has existed since mid-March but remained empty until last 
week when an entry was added to create the /sync/caches mount.  Is this 
expected behavior or do I have a misconfiguration or bug on my hands?

hatfield12:tomg$ ypcat -k auto.sync
cache duncan:/vol/vol02/sync_caches/&
hatfield12:tomg$ ls -ld /sync
ls: /sync: No such file or directory
hatfield12:tomg$ /sbin/service autofs status | grep sync
/usr/sbin/automount /sync yp auto.sync -rw,hard,intr rsize=32768,wsize=32768

I am running an RPM of autofs-4.1.1 with several patches from the 
mailing list and from Red Hat.  From the changelog:

* Wed Mar 31 2004 Tom Georgoulias <tom.georgoulias@motorola.com> - 
1:4.1.1-3t
- patch to send HUP during reload (from autofs list)
- patch to clarify direct map doc (from autofs list)
- comment out creation of /net & /misc dirs

* Thu Mar 18 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.1-3

- Fix bug in get_best_mount, whereby if there is only one option, we
   choose nothing.  This is primarily due to the fact that we pass 0 in to
   the get_best_mount function for the long timeout parameter.  So, we
   timeout trying to contact our first and only server, and never retry.

* Thu Mar 18 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.1-2

- Prevent startup if a mountpoint is already mounted.

Thanks for any help.

Tom
-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Freescale Semiconductor Internal Use
[] Freescale Semiconductor Confidential Proprietary
