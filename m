From: "Lever, Charles" <cel@netapp.com>
Subject: RE: automounter failing with NetApp snapmirror
Date: Sat, 17 Jul 2004 09:36:19 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <482A3FA0050D21419C269D13989C611302B07D55@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

> > hi all-
> > 
> > i'm still learning about the Linux automounter, but we have 
> an issue 
> > that seems to come up a lot for our customers using Linux, it's 
> > automounter, and NetApp filers doing volume snapmirror (a 
> file system 
> > replication mechanism).
> > 
> > at the end of a replication event, the destination file system goes 
> > offline for 3-4 seconds while the new version replaces it.  
> the filer 
> > used to return EACCES during this period, but we've changed it to 
> > simply ignore all RPC requests for that file system until the new 
> > version is online, as this seems to be more client-friendly 
> behavior.
> > 
> > so now, during that time period, an automounter request to 
> mount that 
> > file system will fail with "RPC: timed out" rather than getting 
> > EACCES. is there any way we can tell the automounter to 
> wait longer or 
> > retransmit another few times?
> > 
> 
> autofs version?
> kernel version?
> patched/not patched?
> if patched which revision?

the specific cases we're seeing right now are with RHEL AS 2.1, updates
2 and 3.  jeff moyer can provide you with the exact patch set used in
that distribution.

> Have you got any log output?

i thought maybe there was an easy configuration option that could tune
the automounter's mount behavior, so i don't have any log output.  but
i'll see what we can get.  i assume you mean /var/log/messages; let me
know if there is a log specific to the automounter that i should be
looking for.
