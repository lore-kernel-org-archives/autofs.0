From: "Cyril B." <cbay@excellency.fr>
Subject: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Sun, 13 Sep 2015 15:56:21 +0200
Message-ID: <55F58085.4090509@excellency.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050909000509030408000501"
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Type:Subject:To:MIME-Version:From:Date:Message-ID; bh=WPyOUom2BJkVXej4FMgyLimLbmtaM1oTQwSJgNb4RUo=;
	b=vQub77+1STAq+KcpoWcl79NzFt5kv/R3kVFt+kOwtOCwxQ/j/pQ+3XeC5JsTTHRxIWukvDAGxLt8nzK+P4D5hagb5A+rW9Qe1okNNNuNUlAGOx21ddrDKy6hLlzgeyJDNVDNPi1y3dMWCJ/RovcabcNsHB+lFWOV5ARWqBVTEIUhM2It4+4RXHtT4vcxQZWVibj81iXdhJ/lA9tbtVc1fBwdwkp++SeXCtr2/WM97zNK+kyNEkruhTG44OVqS2n3liLpOtqmeveF9467SQ2682qjDnSo550Iztr/+YOqYa2Tgh7X5x/lt9zCS7EjiJLzTENtZh5chateFsLSXVS3wg==;
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050909000509030408000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

It looks like the mount point of the maps have fixed permissions, 755. I 
need to have different permissions: in my use case, I want /home (which 
is handled by autofs) to be set to 751.

The initial permissions of /home are overwritten when autofs is started, 
so changing those doesn't help.

I can change the permissions of /home after autofs has started, but it's 
really not convenient: there's no easy way to do that automatically with 
either sysvinit or systemd.

For instance, with systemd, I could create a new service that depends on 
autofs and does the chmod, but it will be started once automount has 
been started, and there's guarantee it's already mounted the maps. And 
if it's started after the mounts, there's a small period of time when 
the permissions would be incorrect.

My solution was to add a --mode option to autofs, with the included 
patch. I'm not familiar with autofs's code or even Lex and Yacc, so my 
code is probably more of a proof of concept. It seems to work fine in my 
use case, though.

-- 
Cyril B.

--------------050909000509030408000501
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="add_mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="add_mode.patch"

diff --git a/daemon/direct.c b/daemon/direct.c
index 5569299..0ddd4be 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -433,6 +433,10 @@ int do_mount_autofs_direct(struct autofs_point *ap,
 		goto out_umount;
 	}
 
+	if (ap->mode != -1) {
+		chmod(me->key, ap->mode);
+	}
+
 	ops->open(ap->logopt, &ioctlfd, st.st_dev, me->key);
 	if (ioctlfd < 0) {
 		crit(ap->logopt, "failed to create ioctl fd for %s", me->key);
diff --git a/daemon/indirect.c b/daemon/indirect.c
index a04a624..3fa0659 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -163,6 +163,10 @@ static int do_mount_autofs_indirect(struct autofs_point *ap, const char *root)
 		goto out_umount;
 	}
 
+	if (ap->mode != -1) {
+		chmod(root, ap->mode);
+	}
+
 	if (ops->open(ap->logopt, &ap->ioctlfd, st.st_dev, root)) {
 		crit(ap->logopt,
 		     "failed to create ioctl fd for autofs path %s", ap->path);
diff --git a/include/automount.h b/include/automount.h
index 447aba1..15cd436 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -492,6 +492,7 @@ struct kernel_mod_version {
 struct autofs_point {
 	pthread_t thid;
 	char *path;			/* Mount point name */
+	mode_t mode;			/* Mount point mode */
 	char *pref;			/* amd prefix */
 	int pipefd;			/* File descriptor for pipe */
 	int kpipefd;			/* Kernel end descriptor for pipe */
diff --git a/lib/master.c b/lib/master.c
index 6c38b1c..67b25f2 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -129,6 +129,7 @@ int master_add_autofs_point(struct master_mapent *entry, unsigned logopt,
 		free(ap);
 		return 0;
 	}
+	ap->mode = -1;
 
 	entry->ap = ap;
 
diff --git a/lib/master_parse.y b/lib/master_parse.y
index 9da78fc..71d84d8 100644
--- a/lib/master_parse.y
+++ b/lib/master_parse.y
@@ -63,6 +63,7 @@ static unsigned ghost;
 extern unsigned global_selection_options;
 static unsigned random_selection;
 static unsigned use_weight;
+static mode_t mode;
 static char **tmp_argv;
 static int tmp_argc;
 static char **local_argv;
@@ -101,7 +102,7 @@ static int master_fprintf(FILE *, char *, ...);
 %token COMMENT
 %token MAP
 %token OPT_TIMEOUT OPT_NTIMEOUT OPT_NOBIND OPT_NOGHOST OPT_GHOST OPT_VERBOSE
-%token OPT_DEBUG OPT_RANDOM OPT_USE_WEIGHT OPT_SYMLINK
+%token OPT_DEBUG OPT_RANDOM OPT_USE_WEIGHT OPT_SYMLINK OPT_MODE
 %token COLON COMMA NL DDASH
 %type <strtype> map
 %type <strtype> options
@@ -126,6 +127,7 @@ static int master_fprintf(FILE *, char *, ...);
 %token <strtype> MAPXFN
 %token <strtype> MAPNAME
 %token <longtype> NUMBER
+%token <longtype> OCTALNUMBER
 %token <strtype> OPTION
 
 %start file
@@ -192,6 +194,7 @@ line:
 	| PATH OPT_GHOST { master_notify($1); YYABORT; }
 	| PATH OPT_NOGHOST { master_notify($1); YYABORT; }
 	| PATH OPT_VERBOSE { master_notify($1); YYABORT; }
+	| PATH OPT_MODE { master_notify($1); YYABORT; }
 	| PATH { master_notify($1); YYABORT; }
 	| QUOTE { master_notify($1); YYABORT; }
 	| OPTION { master_notify($1); YYABORT; }
@@ -576,6 +579,7 @@ daemon_option: OPT_TIMEOUT NUMBER { timeout = $2; }
 	| OPT_DEBUG	{ debug = 1; }
 	| OPT_RANDOM	{ random_selection = 1; }
 	| OPT_USE_WEIGHT { use_weight = 1; }
+	| OPT_MODE OCTALNUMBER { mode = $2; }
 	;
 
 mount_option: OPTION
@@ -644,6 +648,7 @@ static void local_init_vars(void)
 	ghost = defaults_get_browse_mode();
 	random_selection = global_selection_options & MOUNT_FLAG_RANDOM_SELECT;
 	use_weight = 0;
+	mode = -1;
 	tmp_argv = NULL;
 	tmp_argc = 0;
 	local_argv = NULL;
@@ -847,6 +852,9 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 		entry->ap->flags |= MOUNT_FLAG_SYMLINK;
 	if (negative_timeout)
 		entry->ap->negative_timeout = negative_timeout;
+	if (mode != -1) {
+		entry->ap->mode = mode;
+	}
 
 /*
 	source = master_find_map_source(entry, type, format,
diff --git a/lib/master_tok.l b/lib/master_tok.l
index c692e14..ff1c347 100644
--- a/lib/master_tok.l
+++ b/lib/master_tok.l
@@ -84,7 +84,7 @@ unsigned int tlen;
 
 %option nounput
 
-%x PATHSTR MAPSTR DNSTR OPTSTR
+%x PATHSTR MAPSTR DNSTR OPTSTR OCTAL
 
 WS		[[:blank:]]+
 OPTWS		[[:blank:]]*
@@ -95,6 +95,7 @@ OPTIONSTR	([\-]?([[:alpha:]_]([[:alnum:]_\-])*(=(\"?([[:alnum:]_\-\:])+\"?))?)+)
 MACROSTR	(-D{OPTWS}([[:alpha:]_]([[:alnum:]_\-\.])*)=([[:alnum:]_\-\.])+)
 SLASHIFYSTR	(--(no-)?slashify-colons)
 NUMBER		[0-9]+
+OCTALNUMBER	[0-7]+
 
 DNSERVSTR1	([[:alpha:]][[:alnum:]\-.]*(:[0-9]+)?:)
 DNSERVSTR2	(\[([[:xdigit:]]:.)+\](:[0-9]+)?:)
@@ -125,6 +126,8 @@ MTYPE		((file|program|exec|sss|yp|nis|nisplus|ldap|ldaps|hesiod|userdir)(,(sun|h
 OPTTOUT		(-t{OPTWS}|-t{OPTWS}={OPTWS}|--timeout{OPTWS}|--timeout{OPTWS}={OPTWS})
 OPTNTOUT	(-n{OPTWS}|-n{OPTWS}={OPTWS}|--negative-timeout{OPTWS}|--negative-timeout{OPTWS}={OPTWS})
 
+MODE		(--mode{OPTWS}|--mode{OPTWS}={OPTWS})
+
 %%
 
 <INITIAL>{
@@ -392,6 +395,11 @@ OPTNTOUT	(-n{OPTWS}|-n{OPTWS}={OPTWS}|--negative-timeout{OPTWS}|--negative-timeo
 	-w|--use-weight-only	{ return(OPT_USE_WEIGHT); }
 	-r|--random-multimount-selection { return(OPT_RANDOM); }
 
+	{MODE}/{OCTALNUMBER} {
+		BEGIN(OCTAL);
+		return(OPT_MODE);
+	}
+
 	{OPTWS}","{OPTWS}	{ return(COMMA); }
 
 	{OPTWS} {}
@@ -423,6 +431,16 @@ OPTNTOUT	(-n{OPTWS}|-n{OPTWS}={OPTWS}|--negative-timeout{OPTWS}|--negative-timeo
 	<<EOF>> { BEGIN(INITIAL); }
 }
 
+<OCTAL>{
+
+	{OCTALNUMBER} {
+		master_lval.longtype = strtol(master_text, NULL, 8);
+		return(OCTALNUMBER);
+	}
+
+	.	{ BEGIN(OPTSTR); yyless(0); }
+}
+
 %%
 
 #include "automount.h"

--------------050909000509030408000501--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
