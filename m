Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1947430B53C
	for <autofs@vger.kernel.org>; Mon, 15 Sep 2025 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940201; cv=none; b=Gn7YefW/8Ycn/fqIlv/G/C111INUUmQ8Biskz7bqHwVFGXh4uwvJDqKNQ7rv+lYblNjNy9vGgZXHzeqksu1I7/TU2gZiCeENMhX3fJ+6tkTuvKrbdmbEoA1yPcvT4fBdPnQugCMCD3hjKuoDcOnOOwcAtnZfF/NUWtWl/twye0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940201; c=relaxed/simple;
	bh=dUJ+z2UkhQMhB+v4L5azRnBk/i0Vn4o7QahQeI+NvSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaA7OnaLTHe3cMYalhpCHUyf2ZuqtrGcPA3tyK1a+vdMuclcB9QsLDiWVTLiSmTQ2i6tClKbAXMP3+gLhcY2cSuFbhmlnPc1vZD1k3a2GvYPm64G65A7o8a/87KszNo4KITOJcjJfVNp3sMi1KQ1ASPcT2nWvwdFUC2KiPAMbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=f8meu0Er; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="f8meu0Er"
From: Jun Eeo <jeeo@janestreet.com>
To: raven@themaw.net
Cc: autofs@vger.kernel.org,
 	jeeo@janestreet.com
Subject: [PATCH] autofs-5.1.9 - use execle instead of calling out to setenv.
Date: Mon, 15 Sep 2025 13:43:07 +0100
Message-ID: <20250915124306.3102807-2-jeeo@janestreet.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <922abdb7-659a-4663-af65-15e8415b87c8@themaw.net>
References: <922abdb7-659a-4663-af65-15e8415b87c8@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1757940199;
  bh=GHvvFswMiemlUqbJfQy+63yXmlwq9TJ5hdRJ128F8E0=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References;
  b=f8meu0Er3OfEqKnQ1Ruz5JLQe/HTnDNPkpCiuUuHvZh7wqywguMWViv0pTRDHu6z7
  gWe13lp7T8MhwID2geHYuf214mhEreM/Hw9AKIOYhCfmY76vEcWSfejZkIIaGPjYmh
  mOE4t7vWT+cBNEGKK+ZxxtYuq1eFKZb26Ci5cx/lnyOKobgkGvl/OPrUMkpEvQxWeO
  MToUwPMsdrwNO+Txqv/8DdeAs39kcRSmkbSFvB+RX6yIf1fLYkfr50ZDe6xohplhNy
  b2eRo7HNHgivILvctKTeAaFnJAc98nNb6PS+1jAykzB/YYTGMsARvMuMTSZsjrlNKC
  N2L7G/D/Uvs7A==

---
 include/macros.h         |  4 +-
 lib/macros.c             | 91 ++++++++++++++++++++++++++++++++++++++--
 modules/lookup_program.c | 14 +++++--
 3 files changed, 101 insertions(+), 8 deletions(-)

diff --git a/include/macros.h b/include/macros.h
index 5a5486e..5584719 100644
--- a/include/macros.h
+++ b/include/macros.h
@@ -40,6 +40,8 @@ void macro_free_global_table(void);
 void macro_free_table(struct substvar *table);
 const struct substvar *
 macro_findvar(const struct substvar *table, const char *str, int len);
-void macro_setenv(struct substvar *table);
+
+int clone_environ(char** envp, char*** envp_ptr);
+int macro_setenv(char*** envp, struct substvar *table);
 
 #endif
diff --git a/lib/macros.c b/lib/macros.c
index 5def26d..684d155 100644
--- a/lib/macros.c
+++ b/lib/macros.c
@@ -495,11 +495,92 @@ macro_findvar(const struct substvar *table, const char *str, int len)
 	return NULL;
 }
 
+/* Just to be on the safe side. */
+int clone_environ(char **const envp, char ***new_envp_ptr)
+{
+	if (envp == NULL) {
+		*new_envp_ptr = NULL;
+		return 0;
+	}
+
+	size_t envp_length = 0;
+	// How big is the existing envp?
+	for (char **ep = envp; *ep != NULL; ep++)
+		envp_length++;
+
+	char **copy = calloc(envp_length + 1, sizeof(char*));
+	if (copy == NULL)
+		return -ENOMEM;
+
+	size_t num_copied = 0;
+
+	// Copy the individual entries.
+	for (num_copied = 0; num_copied < envp_length; num_copied++) {
+		if (!(copy[num_copied] = strdup(envp[num_copied])))
+			goto error;
+	}
+
+	copy[envp_length] = NULL;
+	*new_envp_ptr = copy;
+	return 0;
+
+error:
+	for (size_t i = 0; i < num_copied; i++)
+		free(copy[i]);
+	free(copy);
+	return -ENOMEM;
+}
+
+int safe_setenv(char ***envp_ptr, const char *key, const char *val)
+{
+	char **envp = *envp_ptr;
+	size_t envp_length = 0;
+	if (envp != NULL) {
+		for (char **ep = envp; *ep != NULL; ep++)
+			envp_length++;
+	}
+
+	size_t key_len = strlen(key);
+	size_t val_len = strlen(val);
+	// include the '=' and terminating \0.
+	char *str = malloc(key_len + 1 + val_len + 1);
+	if (str == NULL)
+		return -ENOMEM;
+
+	memcpy(str, key, key_len);
+	str[key_len] = '=';
+	memcpy(str + key_len + 1, val, val_len);
+	str[key_len + 1 + val_len] = 0;
+
+	for (size_t i = 0; i < envp_length; i++) {
+		// Checking for [key]= in envp[i].
+		if (strncmp(str, envp[i], key_len + 1) == 0) {
+			free(envp[i]);
+			envp[i] = str;
+			return 0;
+		}
+	}
+
+	// Allocate and add to the end of envp.
+	// + 1 for the new entry, + 1 for NULL.
+	envp = reallocarray(envp, envp_length + 1 + 1, sizeof(char*));
+	if (envp == NULL) {
+		free(str);
+		return -ENOMEM;
+	}
+
+	envp[envp_length] = str;
+	envp[envp_length + 1] = NULL;
+	*envp_ptr = envp;
+	return 0;
+}
+
 /* Set environment from macro variable table */
-void macro_setenv(struct substvar *table)
+int macro_setenv(char*** envp, struct substvar *table)
 {
 	const struct substvar *sv = system_table;
 	const struct substvar *lv = table;
+	int rv;
 
 	/*
 	 * First set environment from global table, matching local
@@ -507,16 +588,18 @@ void macro_setenv(struct substvar *table)
 	 */
 	while (sv) {
 		if (sv->def)
-			setenv(sv->def, sv->val, 1);
+			if ((rv = safe_setenv(envp, sv->def, sv->val)))
+				return rv;
 		sv = sv->next;
 	}
 
 	/* Next set environment from the local table */
 	while (lv) {
 		if (lv->def)
-			setenv(lv->def, lv->val, 1);
+			if ((rv = safe_setenv(envp, lv->def, lv->val)))
+				return rv;
 		lv = lv->next;
 	}
 
-	return;
+	return 0;
 }
diff --git a/modules/lookup_program.c b/modules/lookup_program.c
index fd90fb8..d8b0657 100644
--- a/modules/lookup_program.c
+++ b/modules/lookup_program.c
@@ -247,14 +247,22 @@ static char *lookup_one(struct autofs_point *ap,
 		 * MAPFMT_DEFAULT must be "sun" for ->parse_init() to have setup
 		 * the macro table.
 		 */
+		char** envp;
+		if (clone_environ(environ, &envp)) {
+			fprintf(stderr, "clone_environ failed.\n");
+			_exit(255);
+		}
 		if (ctxt->mapfmt && !strcmp(ctxt->mapfmt, MAPFMT_DEFAULT)) {
 			struct parse_context *pctxt = (struct parse_context *) ctxt->parse->context;
 			/* Add standard environment as seen by sun map parser */
 			pctxt->subst = addstdenv(pctxt->subst, prefix);
-			macro_setenv(pctxt->subst);
+			if (macro_setenv(&envp, pctxt->subst)) {
+				fprintf(stderr, "macro_setenv failed.\n");
+				_exit(255);
+			}
 		}
-		execl(ctxt->mapname, ctxt->mapname, name, NULL);
-		_exit(255);	/* execl() failed */
+		execle(ctxt->mapname, ctxt->mapname, name, NULL, envp);
+		_exit(255);	/* execle() failed */
 	}
 	close(pipefd[1]);
 	close(epipefd[1]);
-- 
2.43.7

