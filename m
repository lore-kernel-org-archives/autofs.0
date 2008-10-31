From: Ian Kent <raven@themaw.net>
Subject: Re: a couple of bugs in autofs
Date: Fri, 31 Oct 2008 17:35:50 +0900
Message-ID: <1225442150.2946.105.camel@zeus.themaw.net>
References: <510ca9b40810302235v6ab05c8bk117d4991bb70f198@mail.gmail.com>
	<1225436514.2946.74.camel@zeus.themaw.net>
	<510ca9b40810310011o458ff36ftbcce12c850ae172e@mail.gmail.com>
	<1225438359.2946.82.camel@zeus.themaw.net>
	<510ca9b40810310052o2c418ec5sd47c9d3b056a894d@mail.gmail.com>
	<1225440162.2946.93.camel@zeus.themaw.net>
	<510ca9b40810310110s34cfab9cie464a259d9dd92a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40810310110s34cfab9cie464a259d9dd92a0@mail.gmail.com>
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
To: Paul Wankadia <junyer@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 2008-10-31 at 19:10 +1100, Paul Wankadia wrote:
> On Fri, Oct 31, 2008 at 7:02 PM, Ian Kent <raven@themaw.net> wrote:
> 
> > But I don't get a syntax error for the input that your mail specifies.
> 
> If you make with flex --debug, what output do you see when automount starts?
> 
> Honestly, I have no idea why it scans a DNSTR for me, but as I
> mentioned, I have to work around it by escaping 'c' and 'o' with
> backslashes. When were those lex rules last modified?

Just a stab in the dark but what happens if you apply this patch, just
adding the brackets?

---
--- lib/master_tok.l.orig	2008-10-31 17:33:04.000000000 +0900
+++ lib/master_tok.l	2008-10-31 17:33:34.000000000 +0900
@@ -99,7 +99,7 @@
 DNSERVSTR2	(\/\/[[:alpha:]][[:alnum:]\-.]*(:[0-9]+)?\/)
 DNSERVSTR3	(([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}(:[0-9]+)?:)
 DNSERVSTR4	(\/\/([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}(:[0-9]+)?\/)
-DNSERVERSTR	{DNSERVSTR1}|{DNSERVSTR2}|{DNSERVSTR3}|{DNSERVSTR4}
+DNSERVERSTR	({DNSERVSTR1}|{DNSERVSTR2}|{DNSERVSTR3}|{DNSERVSTR4})
 
 AT_CN		([cC][[nN])
 AT_NMN		([nN][iI][sS][Mm][aA][pP][Nn][aA][mM][eE])
@@ -108,7 +108,7 @@
 AT_DC		([dD][[cC])
 AT_O		([oO])
 AT_C		([cC])
-DNATTRSTR	{AT_CN}|{AT_NMN}|{AT_AMN}|{AT_OU}|{AT_DC}|{AT_O}|{AT_C}
+DNATTRSTR	({AT_CN}|{AT_NMN}|{AT_AMN}|{AT_OU}|{AT_DC}|{AT_O}|{AT_C})
 DNNAMESTR1	([[:alnum:]_.\- ]+)
 DNNAMESTR2	([[:alnum:]_.\-]+)
