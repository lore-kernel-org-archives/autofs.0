From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Umount call getting stuck, hanging nfs?
Date: Thu, 04 May 2006 17:20:05 -0400
Message-ID: <x49wtd1wkqi.fsf@redhat.com>
References: <20060504204141.GO27751@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060504204141.GO27751@cornholio.qualcomm.com> (Mike Marion's
	message of "Thu, 4 May 2006 13:41:41 -0700")
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Umount call getting stuck, hanging nfs?; Mike Marion <mmarion@qualcomm.com> adds:

mmarion> Seeing some of our hosts in only one site having problems with
mmarion> hangs occurring.  Seems to be to same filer and even same paths,
mmarion> but what I see is odd.  The kernel rpciod thread is even stuck in
mmarion> state D, seemingly because the umount call is.

mmarion> i.e.  root 20302 1.2 0.0 2468 584 ?  D 12:01 2:39 /bin/umount
mmarion> //usr/local/projects/dsp/qdsp6

mmarion> root 6270 0.0 0.0 0 0 ?  D Apr28 3:17 [rpciod]

mmarion> unfortunately, once this happens, any new mounts will fail.  Can't
mmarion> even stat the path above via df.  Basically the whole NFS layer is
mmarion> stuck.

mmarion> Using autofs-4.1.4 with autofs-4.1.4-misc-fixes.patch
mmarion> autofs-4.1.4-multi-parse-fix.patch
mmarion> autofs-4.1.4-non-replicated-ping.patch patches (slight possibility
mmarion> one of the above is missing, but I'm pretty damn sure they're in
mmarion> there).

mmarion> Mounts are TCP based so I can't even use a spoofed interface to
mmarion> force a umount.

mmarion> Wondering why the extra / in the path on the umount call as well.
mmarion> Also wondering if there's something in the filer (netapp) wrong
mmarion> that's giving some kind of response to the umount that's tickling
mmarion> a bug there.  Not much I've found online yet though.

mmarion> Oh, and umount call shows socks in fd list that don't appear to
mmarion> exist anymore: :~# ls -l /proc/20302/fd total 3 dr-x------ 2 root
mmarion> root 0 May 4 15:26 .  dr-xr-xr-x 3 root root 0 May 4 12:01 ..
mmarion> lrwx------ 1 root root 64 May 4 15:26 0 -> /dev/null l-wx------ 1
mmarion> root root 64 May 4 15:26 1 -> pipe:[4528730] l-wx------ 1 root
mmarion> root 64 May 4 15:26 2 -> pipe:[4528730] :~ # socklist | grep
mmarion> 4528730 :~ #

mmarion> Problem happens on hosts using same autofs daemons with or without
mmarion> direct maps enabled.  Not really sure if it's technically an
mmarion> autofs issue (unless there's a glitch in how it's calling umount
mmarion> and it's timing there) or an NFS layer issue.

mmarion> SLES9-SP1, kernel 2.6.5-7.147-smp (from suse-9.2 updates) on
mmarion> x86_64 hosts.

Really sounds like an NFS problem.  I'd post to the NFS list, and they'll
likely ask for over-the-wire messages.

-Jeff
