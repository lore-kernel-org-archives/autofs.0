From: Ian Kent <raven@themaw.net>
Subject: Re: automount core's on strdup(NULL)
Date: Mon, 13 Apr 2009 17:09:40 +0800 (WST)
Message-ID: <alpine.LFD.2.00.0904131707320.6684@zeus.themaw.net>
References: <996924.92996.qm@web50610.mail.re2.yahoo.com>
	<49E2D66D.4010401@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49E2D66D.4010401@themaw.net>
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
To: marty <martyleisner@yahoo.com>
Cc: autofs@linux.kernel.org, Marty Leisner <leisner@rochester.rr.com>

On Mon, 13 Apr 2009, Ian Kent wrote:

> marty wrote:
> > Before I dig into the code, this causes a definite problem with my patch and the unpatched
> > git version:
> > 
> > At the end of the file, this works:
> > /net    /etc/auto.net
> > #
> > 
> > /-  /etc/auto.direct
> > 
> > 
> > This doesn't work
> > net   /etc/auto.net
> > 
> > /- /etc/auto.direct
> > 
> > Note the "success" depended on whether the "bad line" was at the end of the file or not...
> 
> Don't understand what your saying.
> Looks to me the syntax error of no leading "/" causes the master map
> read to stop and exit with a fail.
> 
> I thought I fixed that ages ago.
> I'll have a look again.
> 

So, the seemingly never ending story of working out haw to "really" reset 
the flex scanner may ahve come to and end, at last (but somehow I doubt 
that will be the end of it).

This patch may help.
It might apply cleanly to the source your using but will reject the 
CHANGLOG hunk (as there are patches prior to this in my working tree that 
aren't yet available).

Ian

autofs-5.0.4 - reset flex scanner when setting buffer

From: Ian Kent <raven@themaw.net>

We still have problems resetting the flex scan buffer after an error
is detected. This appears to fix the problem.
---

 CHANGELOG        |    1 +
 lib/master_tok.l |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)


diff --git a/CHANGELOG b/CHANGELOG
index 9c3c472..50bfca8 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -37,6 +37,7 @@
 - clear rpc client on lookup fail.
 - fix memory leak reading master map.
 - fix st_remove_tasks() locking.
+- reset flex scanner when setting buffer.
 
 4/11/2008 autofs-5.0.4
 -----------------------
diff --git a/lib/master_tok.l b/lib/master_tok.l
index b6cc8be..373248b 100644
--- a/lib/master_tok.l
+++ b/lib/master_tok.l
@@ -130,7 +130,6 @@ OPTNTOUT	(-n{OPTWS}|-n{OPTWS}={OPTWS}|--negative-timeout{OPTWS}|--negative-timeo
 	\x00 {
 		if (optr != buff) {
 			*optr = '\0';
-			optr = buff;
 			strcpy(master_lval.strtype, buff);
 			return NILL;
 		}
@@ -139,6 +138,11 @@ OPTNTOUT	(-n{OPTWS}|-n{OPTWS}={OPTWS}|--negative-timeout{OPTWS}|--negative-timeo
 	#.*  { return COMMENT; }
 
 	"/" {
+		if (optr != buff) {
+			*optr = '\0';
+			strcpy(master_lval.strtype, buff);
+			return NILL;
+		}
 		BEGIN(PATHSTR);
 		bptr = buff;
 		yyless(0);
@@ -410,6 +414,9 @@ static void master_echo(void)
 
 void master_set_scan_buffer(const char *buffer)
 {
+	master_lex_destroy();
+	optr = buff;
+
 	line = buffer;
 	line_pos = &line[0];
 	/*
