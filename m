From: raven@themaw.net
Subject: RE: automounter failing with NetApp snapmirror
Date: Sun, 18 Jul 2004 00:36:06 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407180032510.11491@donald.themaw.net>
References: <482A3FA0050D21419C269D13989C611302B07D55@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482A3FA0050D21419C269D13989C611302B07D55@lavender-fe.eng.netapp.com>
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
To: "Lever, Charles" <cel@netapp.com>
Cc: autofs@linux.kernel.org

On Sat, 17 Jul 2004, Lever, Charles wrote:

> > > hi all-
> > > 
> > > i'm still learning about the Linux automounter, but we have 
> > an issue 
> > > that seems to come up a lot for our customers using Linux, it's 
> > > automounter, and NetApp filers doing volume snapmirror (a 
> > file system 
> > > replication mechanism).
> > > 
> > > at the end of a replication event, the destination file system goes 
> > > offline for 3-4 seconds while the new version replaces it.  
> > the filer 
> > > used to return EACCES during this period, but we've changed it to 
> > > simply ignore all RPC requests for that file system until the new 
> > > version is online, as this seems to be more client-friendly 
> > behavior.
> > > 
> > > so now, during that time period, an automounter request to 
> > mount that 
> > > file system will fail with "RPC: timed out" rather than getting 
> > > EACCES. is there any way we can tell the automounter to 
> > wait longer or 
> > > retransmit another few times?
> > > 
> > 
> > autofs version?
> > kernel version?
> > patched/not patched?
> > if patched which revision?
> 
> the specific cases we're seeing right now are with RHEL AS 2.1, updates
> 2 and 3.  jeff moyer can provide you with the exact patch set used in
> that distribution.

I expect that's autofs version 3
and the stock version 3 kernel module.

> 
> > Have you got any log output?
> 
> i thought maybe there was an easy configuration option that could tune
> the automounter's mount behavior, so i don't have any log output.  but
> i'll see what we can get.  i assume you mean /var/log/messages; let me
> know if there is a log specific to the automounter that i should be
> looking for.

It will log errors to syslog.

I don't track changes to v3.
Hopefully we can get Peters attention?

But check the logs anyway.

Jeff, can you help with versions?

Ian
