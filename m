From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.4 and 5.0.5 do not remove ghost entries
 upon SIGHUP
Date: Thu, 13 Jan 2011 17:16:42 +0800
Message-ID: <1294910202.2757.46.camel@perseus>
References: <20110111183424.7f0f7ad4@cs.bgu.ac.il>
	<1294905042.2757.42.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=+lPwJNK0Sb9b4zShNabxwDZclBA=;
	b=Cad7IYVSzbTyncjFjCKYujZzVfDgPqILTwO6UzQeG8TRUgn83sffUwKI8mTnt5YxfWjWdPFfDRKV85NZB7kchHKFz6nPNgTEWJ1wbdz2fyjwB8PB7t36tTVKyoZTwkFjzJGwbHYX0cQfPDENpxLgQX1dwhK1VaXLIggeURBI1zU=
In-Reply-To: <1294905042.2757.42.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Michael Orlov <orlovm@cs.bgu.ac.il>
Cc: autofs@linux.kernel.org

On Thu, 2011-01-13 at 15:50 +0800, Ian Kent wrote:
> On Tue, 2011-01-11 at 18:34 +0200, Michael Orlov wrote:
> > Hi,
> > 
> > (I have sent this message on Oct 27, but nothing appears in the
> > archives for that month - hopefully it's not a duplicate message.)
> > 
> > I think this is a bug - if it is not, I will be glad if someone
> > corrects me. I am using autofs on Gentoo.
> 
> You will need to duplicate this with all the current 5.0.5 patches on
> kernel.org applied to get serious interest in this here.

So I've done that and this patch seems to resolve the problem but I
doubt it will apply to the source you are using without some other
dependent patches from kernel.org.

autofs-5.0.5 - fix prune cache valid check

From: Ian Kent <raven@themaw.net>

During a map reload, when pruning the cache we look for a valid map entry
in another map. In lookup_prune_one_cache() There is a missing check for
the entry being in the current map which causes the directory cleanup code
from doing its job.
---

 daemon/lookup.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)


diff --git a/daemon/lookup.c b/daemon/lookup.c
index a9a1f4d..36e60c9 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -1060,6 +1060,14 @@ void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, ti
 		 * cache entry.
 		 */
 		valid = lookup_source_valid_mapent(ap, key, LKP_DISTINCT);
+		if (valid && valid->mc == mc) {
+			 /*
+			  * We've found a map entry that has been removed from
+			  * the current cache so it isn't really valid.
+			  */
+			cache_unlock(valid->mc);
+			valid = NULL;
+		}
 		if (!valid &&
 		    is_mounted(_PATH_MOUNTED, path, MNTS_REAL)) {
 			debug(ap->logopt,
