From: raven@themaw.net
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 22:52:57 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502152250440.8175@donald.themaw.net>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no>
Mime-Version: 1.0
In-Reply-To: <20050215014857.GA26216@uio.no>
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
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Tue, 15 Feb 2005, Steinar H. Gunderson wrote:

> - 051_maps_without_trailing_newline.diff is not in, it seems; did you forget
>  it or just find a cleaner way?

I think you'll find that this handles the issue (if I understand it 
correctly).

Index: modules/lookup_file.c
===================================================================
RCS file: /home/cvs/root/autofs/modules/lookup_file.c,v
retrieving revision 1.13
retrieving revision 1.14
diff -u -r1.13 -r1.14
--- modules/lookup_file.c	26 Jan 2005 05:31:38 -0000	1.13
+++ modules/lookup_file.c	6 Feb 2005 10:05:55 -0000	1.14
@@ -1,4 +1,4 @@
-#ident "$Id: lookup_file.c,v 1.13 2005/01/26 05:31:38 raven Exp $"
+#ident "$Id: lookup_file.c,v 1.14 2005/02/06 10:05:55 raven Exp $"
  /* ----------------------------------------------------------------------- *
   *
   *  lookup_file.c - module for Linux automount to query a flat file map
@@ -202,6 +202,11 @@
  			} else if (mapent_len < MAPENT_MAX_LEN) {
  				mapent_len++;
  				*(p++) = ch;
+				nch = getc(f);
+				if (nch == EOF &&
+				   (gotten == got_real || gotten == getting))
+				   	goto got_it;
+				ungetc(nch, f);
  			}
  			break;
  		}
