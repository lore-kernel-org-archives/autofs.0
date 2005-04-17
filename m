From: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
Subject: Re: [daniel@vision.ime.usp.br: Bug#304245: patch - NFS
	mounts occasionally fail]
Date: Sun, 17 Apr 2005 15:18:27 -0300
Message-ID: <20050417181827.GA13101@vision.ime.usp.br>
References: <20050417154240.GA17232@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050417154240.GA17232@uio.no>
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
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org, 304245@bugs.debian.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

My editor broke the indentation style in the patch; I'm resending it as
an attached file.

Thanks,

Daniel

On Sun, Apr 17, 2005 at 05:42:40PM +0200, Steinar H. Gunderson wrote:
> Hi,
> 
> Thanks for the patch; sending upstream for evaluation.
> 
> /* Steinar */

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfs_mount_fail.diff"

--- autofs-4.1.4.orig/modules/mount_nfs.c	2005-04-05 09:42:42.000000000 -0300
+++ autofs-4.1.4/modules/mount_nfs.c	2005-04-16 22:59:05.000000000 -0300
@@ -251,33 +251,28 @@ int get_best_mount(char *what, const cha
 
 	debug(MODPREFIX "winner = %s local = %d", winner, local);
 
-	/*
-	 * We didn't find a weighted winner or local
-	 */
-	if (!local && winner_weight == INT_MAX) {
-		/* We had more than one contender and none responded in time */
-		if (winner_time != 0 && winner_time > 500) {
-			/* We've already tried a longer timeout */
-			if (!longtimeout) {
-				/* Reset string and try again */
-				strcpy(what, original);
-
-				debug(MODPREFIX 
-				      "all hosts timed out for '%s', "
-				      "retrying with longer timeout",
-				      original);
-
-				return get_best_mount(what, original, 1, 1);
-			}
+	/* No winner found */
+	if (!local && !winner) {
+		
+		/* Retry with a longer timeout */
+		if (!longtimeout) {
+			/* Reset string and try again */
+			strcpy(what, original);
+	    
+			debug(MODPREFIX 
+			      "all hosts timed out for '%s', "
+			      "retrying with longer timeout",
+			      original);
+			
+			return get_best_mount(what, original, 1, 1);
+		}
+		else {
+			/* No hosts responded, winner = first host */
+			winner = what;
 		}
+		
 	}
-
-	/* No winner found so bail */
-	if (!winner) {
-		*what = '\0';
-		return 0;
-	}
-
+	
 	/*
 	 * We now have our winner, copy it to the front of the string,
 	 * followed by the next :string<delim>

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--0F1p//8PRICkK4MW--

