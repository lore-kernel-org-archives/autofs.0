From: raven@themaw.net
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Mon, 17 Jan 2005 22:01:31 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501172156170.1801@donald.themaw.net>
References: <200501130037.j0D0bNDj012842@jetcar.spd.analog.com>
	<Pine.LNX.4.61.0501142225200.2519@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501142225200.2519@donald.themaw.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@sun.com>

On Fri, 14 Jan 2005 raven@themaw.net wrote:

>
> I have attached a patch I'd like you to try please.
>

Hi David,

I've found a small problem with the patch.
Please update your rpms with the extra patch below or get the version I 
have uploaded to the autofs v4 directory on kernel.org.

If you look at the code around the second hunk it should be fairly 
clear how important this could be.

Jeff I've called the patch autofs-4.1.3-multi-over.patch if you would like 
to have a look and perhaps add it to your rpms.

Regards
Ian

--- autofs-4.1.3/modules/parse_sun.c.multi-over-2	2005-01-17 21:50:18.000000000 +0800
+++ autofs-4.1.3/modules/parse_sun.c	2005-01-17 21:51:06.000000000 +0800
@@ -750,7 +750,6 @@
  		do {
  			char *myoptions = strdup(options);
  			char *path, *loc;
-			int pathlen, loclen;

  			if (myoptions == NULL) {
  				error(MODPREFIX "multi strdup: %m");
@@ -813,7 +812,7 @@
  				free(path);
  				free(options);
  				free(myoptions);
-				multi_free_list(head);
+				multi_free_list(list);
  				return 1;
  			}
  		} while (*p == '/');
