From: Ian Kent <raven@themaw.net>
Subject: Re: "no hosts available"
Date: Sat, 26 Jul 2008 14:59:13 +0800
Message-ID: <1217055554.3304.35.camel@raven.themaw.net>
References: <20080725224430.GL13495@u20m2mm.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080725224430.GL13495@u20m2mm.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org


On Fri, 2008-07-25 at 15:44 -0700, Mike Marion wrote:
> Google didn't help much, nothing I see in RH's bugzilla, and I don't understand 
> the code enough to figure out... what are a couple ideas of what could trigger the
> following error on an attempted mount:
> 
> automount[32110]: mount_mount: mount(nfs): no hosts available
> 
> Note, this is across a WAN connection to a filer at another site.. so
> could network issues do this?  Just trying to track down possible causes
> of periodic failures to mount.

Ahhh .. you've spotted a bug.

But it also depends on what patches are included in your autofs build.

Looking at the code I see there is a bug when setting the RPC ping
timeout for remote hosts. But there is a patch that eliminates the ping
check for map entries don't have multiple hosts. So it may be something
else.

Anyway, this patch should apply, give it a try.

autofs-5.0.3 - fix proximity other rpc ping timeout

From: Ian Kent <raven@themaw.net>

The timeout for the RCP ping for hosts that are on a network other
than the local subnet or network is mistakenly set quite short. This
can lead to unexplained intermittent failures for hosts on remote
networks.
---

 modules/replicated.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/modules/replicated.c b/modules/replicated.c
index efbe6b4..925f641 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -552,7 +552,7 @@ static int get_vers_and_cost(unsigned logopt, struct host *host,
 
 	if (host->proximity == PROXIMITY_NET)
 		timeout = RPC_TIMEOUT * 2;
-	else if (host->proximity == PROXIMITY_NET)
+	else if (host->proximity == PROXIMITY_OTHER)
 		timeout = RPC_TIMEOUT * 8;
 
 	rpc_info.host = host->name;
@@ -609,7 +609,7 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 
 	if (host->proximity == PROXIMITY_NET)
 		timeout = RPC_TIMEOUT * 2;
-	else if (host->proximity == PROXIMITY_NET)
+	else if (host->proximity == PROXIMITY_OTHER)
 		timeout = RPC_TIMEOUT * 8;
 
 	rpc_info.host = host->name;
