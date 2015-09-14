From: "Cyril B." <cbay@excellency.fr>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 13:31:32 +0200
Message-ID: <55F6B014.70503@excellency.fr>
References: <55F58085.4090509@excellency.fr> <1442199959.3030.40.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=cyqhUNbQbBninTHtiYVEgP8KwFR4BlVtqSZ0pEvz5iw=;
	b=gNbn+S0OrfrShPI+fLiRa6kctH4uiiAbx3hmCo4sDT0+lRSKuUii53MT3Jl23MhzezEngcv7ho9r+pHh6cte7FrRoHbnQT7mQhnaV6G6/RqM9xlK9EZ2jRebXWiACmG8RW7E8NWf5xVumziflFofg7kvcfJiACJi03S7CrCEcMcfheD4w/ihP7lvDhH3YlnZ7vKQmYJ50GrD37iulj2Ha5FalxmCXK1+zK/3nJQKK/5GGEkWkQut94ng6t5SnSU27lj0joRTcvTlHQnFJXC7iXXUSbZyPBGoAWieL28eZ6/aZvitkiXa4uXu8fijGZaw4VQc2XlTj5iDxhSunkMkog==;
In-Reply-To: <1442199959.3030.40.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

Ian Kent wrote:
> If you want to contribute patches then post then in-line as text without
> any additional change (eg. ensure the mailer doesn't split lines therby
> corrupting the patch).
>
> I can't properly comment on the patch, even if I wanted too, because it
> isn't in-line.
>
> Anyway, what about updating the man pages with your new option?
> Should text modes be considered, perhaps octal modes are sufficient, and
> should be all that's allowed, to keep the change as simple (generally a
> good idea) ...

My bad, sorry. Here's a second try, including a commit message and an updated man page:

add map option --mode

Add a --mode map option to change the mode for the base location mount
point. If this option is given, autofs will chmod the mount point right
after mounting it (as the kernel autofs filesystem doesn't support a
'mode' option).

Changing the mode of the base location mount point is normally not needed,
but if one wants to do that, it's much better to do it inside autofs rather
than outside to avoid race conditions and making sure the correct permissions
are always set.
---
  daemon/direct.c      |  4 ++++
  daemon/indirect.c    |  4 ++++
  include/automount.h  |  1 +
  lib/master.c         |  1 +
  lib/master_parse.y   | 10 +++++++++-
  lib/master_tok.l     | 20 +++++++++++++++++++-
  man/auto.master.5.in |  5 +++++
  7 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/daemon/direct.c b/daemon/direct.c
index 5569299..55c4aa6 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -433,6 +433,10 @@ int do_mount_autofs_direct(struct autofs_point *ap,
  		goto out_umount;
  	}

+       if (ap->mode != -1) {
+               chmod(me->key, ap->mode);
+       }
+
  	ops->open(ap->logopt, &ioctlfd, st.st_dev, me->key);
  	if (ioctlfd < 0) {
  		crit(ap->logopt, "failed to create ioctl fd for %s", me->key);
diff --git a/daemon/indirect.c b/daemon/indirect.c
index a04a624..e071f12 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -163,6 +163,10 @@ static int do_mount_autofs_indirect(struct autofs_point *ap, const char *root)
  		goto out_umount;
  	}

+       if (ap->mode != -1) {
+               chmod(root, ap->mode);
+       }
+
  	if (ops->open(ap->logopt, &ap->ioctlfd, st.st_dev, root)) {
  		crit(ap->logopt,
  		     "failed to create ioctl fd for autofs path %s", ap->path);
diff --git a/include/automount.h b/include/automount.h
index 447aba1..0b37c32 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -492,6 +492,7 @@ struct kernel_mod_version {
  struct autofs_point {
  	pthread_t thid;
  	char *path;			/* Mount point name */
+       mode_t mode;                    /* Mount point mode */
  	char *pref;			/* amd prefix */
  	int pipefd;			/* File descriptor for pipe */
  	int kpipefd;			/* Kernel end descriptor for pipe */
diff --git a/lib/master.c b/lib/master.c
index 6c38b1c..8d4c864 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -129,6 +129,7 @@ int master_add_autofs_point(struct master_mapent *entry, unsigned logopt,
  		free(ap);
  		return 0;
  	}
+       ap->mode = -1;

  	entry->ap = ap;

diff --git a/lib/master_parse.y b/lib/master_parse.y
index 9da78fc..825c565 100644
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
+       | PATH OPT_MODE { master_notify($1); YYABORT; }
  	| PATH { master_notify($1); YYABORT; }
  	| QUOTE { master_notify($1); YYABORT; }
  	| OPTION { master_notify($1); YYABORT; }
@@ -576,6 +579,7 @@ daemon_option: OPT_TIMEOUT NUMBER { timeout = $2; }
  	| OPT_DEBUG	{ debug = 1; }
  	| OPT_RANDOM	{ random_selection = 1; }
  	| OPT_USE_WEIGHT { use_weight = 1; }
+       | OPT_MODE OCTALNUMBER { mode = $2; }
  	;

  mount_option: OPTION
@@ -644,6 +648,7 @@ static void local_init_vars(void)
  	ghost = defaults_get_browse_mode();
  	random_selection = global_selection_options & MOUNT_FLAG_RANDOM_SELECT;
  	use_weight = 0;
+       mode = -1;
  	tmp_argv = NULL;
  	tmp_argc = 0;
  	local_argv = NULL;
@@ -847,6 +852,9 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
  		entry->ap->flags |= MOUNT_FLAG_SYMLINK;
  	if (negative_timeout)
  		entry->ap->negative_timeout = negative_timeout;
+       if (mode != -1) {
+               entry->ap->mode = mode;
+       }

  /*
  	source = master_find_map_source(entry, type, format,
diff --git a/lib/master_tok.l b/lib/master_tok.l
index c692e14..6433448 100644
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
+OCTALNUMBER    [0-7]+

  DNSERVSTR1	([[:alpha:]][[:alnum:]\-.]*(:[0-9]+)?:)
  DNSERVSTR2	(\[([[:xdigit:]]:.)+\](:[0-9]+)?:)
@@ -125,6 +126,8 @@ MTYPE		((file|program|exec|sss|yp|nis|nisplus|ldap|ldaps|hesiod|userdir)(,(sun|h
  OPTTOUT		(-t{OPTWS}|-t{OPTWS}={OPTWS}|--timeout{OPTWS}|--timeout{OPTWS}={OPTWS})
  OPTNTOUT	(-n{OPTWS}|-n{OPTWS}={OPTWS}|--negative-timeout{OPTWS}|--negative-timeout{OPTWS}={OPTWS})

+MODE           (--mode{OPTWS}|--mode{OPTWS}={OPTWS})
+
  %%

  <INITIAL>{
@@ -392,6 +395,11 @@ OPTNTOUT	(-n{OPTWS}|-n{OPTWS}={OPTWS}|--negative-timeout{OPTWS}|--negative-timeo
  	-w|--use-weight-only	{ return(OPT_USE_WEIGHT); }
  	-r|--random-multimount-selection { return(OPT_RANDOM); }

+       {MODE}/{OCTALNUMBER} {
+               BEGIN(OCTAL);
+               return(OPT_MODE);
+       }
+
  	{OPTWS}","{OPTWS}	{ return(COMMA); }

  	{OPTWS} {}
@@ -423,6 +431,16 @@ OPTNTOUT	(-n{OPTWS}|-n{OPTWS}={OPTWS}|--negative-timeout{OPTWS}|--negative-timeo
  	<<EOF>> { BEGIN(INITIAL); }
  }

+<OCTAL>{
+
+       {OCTALNUMBER} {
+               master_lval.longtype = strtol(master_text, NULL, 8);
+               return(OCTALNUMBER);
+       }
+
+       .       { BEGIN(OPTSTR); yyless(0); }
+}
+
  %%

  #include "automount.h"
diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index 2e475dc..ba28494 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -211,6 +211,11 @@ or in the configuration.
  Set the timeout for caching failed key lookups. This option can be
  used to override the global default given either on the command line
  or in the configuration.
+.TP
+.I "\-\-mode <octal_mode>"
+Set the directory mode for the base location of the \fBautofs\fP mount point.
+If this option is given, \fBautofs\fP will chmod that directory with this
+mode.
  .SH BUILTIN MAP \-hosts
  If "\-hosts" is given as the map then accessing a key under the mount point
  which corresponds to a hostname will allow access to the exports of that
--
2.1.4


-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
