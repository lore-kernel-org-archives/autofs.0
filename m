From: raven@themaw.net
Subject: RE: automounter failing with NetApp snapmirror
Date: Mon, 19 Jul 2004 20:40:27 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407192036070.1373@donald.themaw.net>
References: <482A3FA0050D21419C269D13989C611302B07D55@lavender-fe.eng.netapp.com>
	<Pine.LNX.4.58.0407180032510.11491@donald.themaw.net>
	<16635.48189.407955.179805@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16635.48189.407955.179805@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 19 Jul 2004, Jeff Moyer wrote:

> ==> Regarding RE: [autofs] automounter failing with NetApp snapmirror; raven@themaw.net adds:
> 
> raven> On Sat, 17 Jul 2004, Lever, Charles wrote:
> >> > > hi all-
> >> > > 
> >> > > i'm still learning about the Linux automounter, but we have > an
> >> issue > > that seems to come up a lot for our customers using Linux,
> >> it's > > automounter, and NetApp filers doing volume snapmirror (a >
> >> file system > > replication mechanism).
> >> > > 
> >> > > at the end of a replication event, the destination file system goes
> >> > > offline for 3-4 seconds while the new version replaces it.  > the
> >> filer > > used to return EACCES during this period, but we've changed it
> >> to > > simply ignore all RPC requests for that file system until the new
> >> > > version is online, as this seems to be more client-friendly >
> >> behavior.
> >> > > 
> >> > > so now, during that time period, an automounter request to > mount
> >> that > > file system will fail with "RPC: timed out" rather than getting
> >> > > EACCES. is there any way we can tell the automounter to > wait
> >> longer or > > retransmit another few times?
> >> > > 
> 
> I believe that error is produced by the mount command, itself.  Poking
> through the code for mount, it doesn't look like this timeout is
> configurable.  Autofs 4 actually checks to see if a host is alive before
> attempting a mount, so at least things should work there.  I'm not sure
> what the best approach is to solve this problem on 3.1.7.
>

But due to complaints, the check is only done against entries 
that use replicated server syntax. Also, the latest code is not yet 
included in a release.
 
> >> >
> >> > autofs version?  > kernel version?  > patched/not patched?  > if
> >> patched which revision?
> >> 
> >> the specific cases we're seeing right now are with RHEL AS 2.1, updates
> >> 2 and 3.  jeff moyer can provide you with the exact patch set used in
> >> that distribution.
> 
> raven> I expect that's autofs version 3 and the stock version 3 kernel
> raven> module.
> 
> AS2.1 Update 3 has autofs version 3.1.7-21.  The kernel module likely
> matches the code in vanilla 2.4.9, but I don't believe this code to be
> suspect.
> 
It's worth pointing out that the v3 code has not changed for a 
long time so perhaps the source of this is somewhere else.

Ian
