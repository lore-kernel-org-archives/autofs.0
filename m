From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: [PATCH] Remove master_mutex_unlock() leftover
Date: Mon, 13 Jun 2011 18:39:40 -0300
Message-ID: <20110613213940.GA4908@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:date:from:to:subject:message-id:mime-version
	:content-type:content-disposition:user-agent;
	bh=/7w5CKRht/V7zM+4SYBUkLyAtlMBZHWGllKfZ4SfrL4=;
	b=KHdL5W4XUtQz9L8Nz+3i4zZI8nnGhVKjppuSZRH+EkESXJJw2pqOhQIi5hehQOb3pa
	9KsJFDdE4AHGJOOzoQiX9DBy9Oq7BbOQjZB0NPRMoqDBj97zLFIcfe/cfus3Z2tLUYxu
	iNLf2nwKDSgDsnyFGatpbXtWz0nQo+4EetYKo=
Content-Disposition: inline
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
To: autofs@linux.kernel.org

Hello Ian, list

While trying to make some progress on the AB/BA locking issue, I
think I've found a bug introduced by commit dc0c3734.

Thanks,
Leonardo


Remove master_mutex_unlock() leftover

Commit dc0c3734 ("fix out of order locking in readmap") removes
the calls to master_mutex_lock() and master_mutex_unlock() from
master_find_mapent(), but leaves an unlock behind.

Signed-off-by: Leonardo Chiquitto <lchiquitto@novell.com>

---
 lib/master.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: autofs/lib/master.c
===================================================================
--- autofs.orig/lib/master.c
+++ autofs/lib/master.c
@@ -643,10 +643,8 @@ struct master_mapent *master_find_mapent
 
 		entry = list_entry(p, struct master_mapent, list);
 
-		if (!strcmp(entry->path, path)) {
-			master_mutex_unlock();
+		if (!strcmp(entry->path, path))
 			return entry;
-		}
 	}
 
 	return NULL;
