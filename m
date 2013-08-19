From: Ian Kent <raven@themaw.net>
Subject: [PATCH 25/25] autofs-5.0.7 - setup program map env from macro table
Date: Mon, 19 Aug 2013 09:14:43 +0800
Message-ID: <20130819011442.6472.28853.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=GdveK3I8X0wO+EnWqSwFT0TKgVo=; b=AJvQqvO0LSFeqInjYxZAO4CNpHcg
	0+eFbAUSxrYL6Ou4yqrTyYLUiIuiGOUE5a++mjg4oi6y5/e6qiffkZTM9uFVY0v4
	2AmIc5v3Q3i35uCQawVW7npvP7cxdxrlimLcst9qcLtntIo8RxkituOvqhYEcVqD
	Ud5DGRU70Sf4eds=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=GdveK3I8X0wO+EnWqSwFT0
	TKgVo=; b=UwxZsRXtd852GZPhxf5KjP2N1JSfhtK32LYptWebfDCzM7jbbTn+3N
	yoEVEqRTLaeqvAz4zDZqOZKoNyInTIiPm3w996ObEmAxlaP1u8HQP0KrK0Tc4JxY
	cLvi9Ns1KNUMqoCvE4Y66/Qj2FuhRRWD+H1rSimK3wTluGGkV8ZnU=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

The ability to pass parameters to program maps, in some way, is needed.
Standard autofs specifies that program maps have one argument so passing
parameters as arguments shouldn't be done.

This patch sets the existing macro table definitions (for both global and
local table) as environment variables before calling the map. The values
are not checked after return so, at this stage, program maps can't change
macro definitions.
---
 include/macros.h         |    1 +
 lib/macros.c             |   28 ++++++++++++++++++++++++++++
 modules/lookup_program.c |   20 ++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/macros.h b/include/macros.h
index a73a4a7..5077b5d 100644
--- a/include/macros.h
+++ b/include/macros.h
@@ -40,5 +40,6 @@ void macro_free_global_table(void);
 void macro_free_table(struct substvar *table);
 const struct substvar *
 macro_findvar(const struct substvar *table, const char *str, int len);
+void macro_setenv(const struct substvar *table);
 
 #endif
diff --git a/lib/macros.c b/lib/macros.c
index 32b70bf..33c2ada 100644
--- a/lib/macros.c
+++ b/lib/macros.c
@@ -421,3 +421,31 @@ macro_findvar(const struct substvar *table, const char *str, int len)
 	return NULL;
 }
 
+/* Set environment from macro variable table */
+void macro_setenv(const struct substvar *table)
+{
+	const struct substvar *sv = system_table;
+	const struct substvar *lv = table;
+
+	/*
+	 * First set environment from global table, matching local
+	 * variables will overwrite these.
+	 */
+	while (sv) {
+		if (sv->def)
+			setenv(sv->def, sv->val, 1);
+		sv = sv->next;
+	}
+
+	error(LOGOPT_ANY, "table %p", table);
+	dump_table(table);
+
+	/* Next set environment from the local table */
+	while (lv) {
+		if (lv->def)
+			setenv(lv->def, lv->val, 1);
+		lv = lv->next;
+	}
+
+	return;
+}
diff --git a/modules/lookup_program.c b/modules/lookup_program.c
index 2457108..7e22b38 100644
--- a/modules/lookup_program.c
+++ b/modules/lookup_program.c
@@ -36,9 +36,17 @@
 
 struct lookup_context {
 	const char *mapname;
+	char *mapfmt;
 	struct parse_mod *parse;
 };
 
+struct parse_context {
+	char *optstr;		/* Mount options */
+	char *macros;		/* Map wide macro defines */
+	struct substvar *subst;	/* $-substitutions */
+	int slashify_colons;	/* Change colons to slashes? */
+};
+
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
 
 int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **context)
@@ -79,6 +87,8 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 	if (!mapfmt)
 		mapfmt = MAPFMT_DEFAULT;
 
+	ctxt->mapfmt = strdup(mapfmt);
+
 	ctxt->parse = open_parse(mapfmt, MODPREFIX, argc - 1, argv + 1);
 	if (!ctxt->parse) {
 		logmsg(MODPREFIX "failed to open parse context");
@@ -255,6 +265,14 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 			warn(ap->logopt,
 			     MODPREFIX "failed to set PWD to %s for map %s",
 			     ap->path, ctxt->mapname);
+		/*
+		 * MAPFMT_DEFAULT must be "sun" for ->parse_init() to have setup
+		 * the macro table.
+		 */
+		if (ctxt->mapfmt && strcmp(ctxt->mapfmt, "MAPFMT_DEFAULT")) {
+			struct parse_context *pctxt = (struct parse_context *) ctxt->parse->context;
+			macro_setenv(pctxt->subst);
+		}
 		execl(ctxt->mapname, ctxt->mapname, name, NULL);
 		_exit(255);	/* execl() failed */
 	}
@@ -448,6 +466,8 @@ int lookup_done(void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	int rv = close_parse(ctxt->parse);
+	if (ctxt->mapfmt)
+		free(ctxt->mapfmt);
 	free(ctxt);
 	return rv;
 }

