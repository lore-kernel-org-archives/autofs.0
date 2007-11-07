From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS / SASL support
Date: Wed, 07 Nov 2007 16:57:38 +0900
Message-ID: <1194422258.13416.1.camel@raven.themaw.net>
References: <E5F741E838FC2043A0B843E48181813806AB752A@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E5F741E838FC2043A0B843E48181813806AB752A@MLNYC730MB.amrs.win.ml.com>
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
To: "Newman, Edward (GTI)" <edward_newman@ml.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-11-06 at 09:30 -0500, Newman, Edward (GTI) wrote:
> Ian
> 
> FYI - The supplied patch appears to break ldap maps with --ghost at the
> end. Seems to be considered part of the search DN.
> 

Yep, I see that now.
That was the result of another recent patch though.

This additional patch should resolve it.

--
diff --git a/lib/master_tok.l b/lib/master_tok.l
index 5450753..36aa785 100644
--- a/lib/master_tok.l
+++ b/lib/master_tok.l
@@ -108,8 +108,8 @@ AT_DC		([dD][[cC])
 AT_O		([oO])
 AT_C		([cC])
 DNATTRSTR	{AT_CN}|{AT_NMN}|{AT_AMN}|{AT_OU}|{AT_DC}|{AT_O}|{AT_C}
-DNNAMESTR	([[:alnum:]_.\- ]+)
-DNNAMETRM	(,|{OPTWS}{NL}|{OPTWS}#.*|{OPTWS}\x00)
+DNNAMESTR1	([[:alnum:]_.\- ]+)
+DNNAMESTR2	([[:alnum:]_.\-]+)
 
 INTMAP		(-hosts|-null)
 MULTI		((multi)(,(sun|hesiod))?(:{OPTWS}|{WS}))
@@ -282,7 +282,12 @@ OPTTOUT		(-t{OPTWS}|-t{OPTWS}={OPTWS}|--timeout{OPTWS}|--timeout{OPTWS}={OPTWS})
 		return EQUAL;
 	}
 
-	{DNNAMESTR}/{DNNAMETRM} {
+	{DNNAMESTR1}/"," {
+		strcpy(master_lval.strtype, master_text);
+		return DNNAME;
+	}
+
+	{DNNAMESTR2} {
 		strcpy(master_lval.strtype, master_text);
 		return DNNAME;
 	}
