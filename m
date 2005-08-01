From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs-4.1.4/samples/rc.autofs.in bad use of grep \B
Date: Mon, 1 Aug 2005 09:17:05 -0400
Message-ID: <17134.8401.961227.160675@segfault.boston.redhat.com>
References: <17127.59627.203496.547988@fig.ICSI.Berkeley.EDU>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17127.59627.203496.547988@fig.ICSI.Berkeley.EDU>
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
To: David Johnson <davidj@ICSI.Berkeley.EDU>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] autofs-4.1.4/samples/rc.autofs.in bad use of grep \B; David Johnson <davidj@ICSI.Berkeley.EDU> adds:

davidj> autofs-4.1.4/samples/rc.autofs.in uses \B incorrectly in grep
davidj> commands.  \B actually means "not edge of word", but the script
davidj> uses it to mean "beginning of word".  Fortunately, due to the
davidj> script writer assuming "-" is part of a word, but this not being
davidj> the case when LANG==C, it works under most common circumstances
davidj> (but breaks with e.g. --no--verbose in /etc/sysconfig/autofs).
davidj> However, it may cease to work if more command-line args get added
davidj> to automount.

davidj> I've posted a tested patch against RHEL3 in bugzilla.redhat.com for
davidj> Fedora Devel.  I've also forward-ported the patch to autofs-4.1.4
davidj> and included it here.  Note that although this is very similar to
davidj> the RHEL3 patch and may well work, unfortunately I have no
davidj> reasonable way of testing it.

Why don't you have a reasonable way of testing it?  It doesn't work
entirely correctly, by the way:

--- rc.autofs.in.sav	2005-04-11 04:30:54.000000000 -0700
+++ rc.autofs.in	2005-07-27 12:48:33.000000000 -0700
@@ -248,11 +248,13 @@
 		# those particular options out.
 		: echo DAEMONOPTIONS OPTIONS $daemonoptions $options
 		startupoptions=
-		if echo "$options" | grep -qE -- '\B-(t\b|-timeout\b=)' ;
+		if echo " $options " | \
+		    grep -qE -- '[[:space:]]-(t[[:space:][:digit:]]|-timeout=)';
 		then
 		    startupoptions="--timeout=$(echo $options |\
 			sed 's/.*-\(t[^0-9]*\|-timeout\)[ \t=]*\([0-9][0-9]*\).*$/\2/g')"
-		elif echo "$daemonoptions" | grep -q -- '-t' ;
+		elif echo " $daemonoptions " | \
+		    grep -qE -- '[[:space:]]-(t[[:space:][:digit:]]|-timeout=)' ;
 		then
 		    # It's okay to be sloppy with DAEMONOPTIONS as there is no
 		    # possibility of conflicting with mount or map options.

If --timeout=60 is the first thing that appears in DAEMONOPTIONS, there
will be no space before it, so the grep will fail.  It's easy to test.

-Jeff
