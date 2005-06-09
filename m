From: "Peter C. Norton" <spacey-autofs@lenin.net>
Subject: Re: Autofs and NIS+ bug
Date: Thu, 9 Jun 2005 09:26:56 -0700
Message-ID: <20050609162656.GD18045@lenin.net>
References: <20050603141451.GJ18045@lenin.net>
	<Pine.LNX.4.62.0506041318490.1619@donald.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/WwmFnJnmDyWGHa4"
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506041318490.1619@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 04, 2005 at 01:24:21PM +0800, raven@themaw.net wrote:
> 
> Off course you can submit the code.
> Unforetuneatly, I don't have a test environment and I'm not familiar with 
> the nis+ api so I'll have to rely on you to test the result.

I thought I'd sent the patch to the list, but I think I may only have
sent it to Jeff Moyer
 
> > So let me know if in principle this kind of patch could be reviewed,
> > and I'll pass it along, with a minimal description of how to reproduce
> > a test case... if anyone is interested.
> 
> I'm happy to include anything that helps.
> Of course if it is hard to merge or gets out of date (for whatever 
> reason) before I can look at it then it gets harder.
> 
> Generally I expect people to maintain there patches for as long as it 
> might take to get them merged.

It should be timeless, because NIS+ is going away.  I am maintaining
the patch internally, so that's not a big deal.

I'm attaching the patch again with this message.

-Peter

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lookup_nisplus.patch"

--- autofs-4.1.3/modules/lookup_nisplus.c	2005-05-13 12:35:29.000000000 -0400
+++ /home/pn18117/tmp/lookup_nisplus-4.c	2005-05-13 12:38:51.000000000 -0400
@@ -1,4 +1,4 @@
-#ident "$Id: lookup_nisplus.c,v 1.3 2004/01/29 16:01:22 raven Exp $"
+#ident "$Id: lookup_nisplus.c,v 1.2 1998/03/29 02:03:06 hpa Exp $"
 /*
  * lookup_nisplus.c
  *
@@ -24,88 +24,279 @@
 
 #define MODPREFIX "lookup(nisplus): "
 
-struct lookup_context {
+struct lookup_context
+{
 	const char *domainname;
 	const char *mapname;
 	struct parse_mod *parse;
 };
 
+#define STORAGE_BUF_LEN 2048
+static char storage_buf[STORAGE_BUF_LEN] = "";
+
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
 
-int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **context)
+int
+lookup_init (const char *mapfmt, int argc, const char *const *argv,
+	     void **context)
 {
 	struct lookup_context *ctxt;
 
-	if (!(*context = ctxt = malloc(sizeof(struct lookup_context)))) {
-		crit(MODPREFIX "%m");
+	if (!(*context = ctxt = malloc (sizeof (struct lookup_context)))) {
+		syslog (LOG_CRIT, MODPREFIX "%m");
 		return 1;
 	}
 
 	if (argc < 1) {
-		crit(MODPREFIX "No map name");
+		syslog (LOG_CRIT, MODPREFIX "No map name");
 		return 1;
 	}
 	ctxt->mapname = argv[0];
 
-	/* 
-	 * nis_local_directory () returns a pointer to a static buffer.
-	 * We don't need to copy or free it.
-	 */
-	ctxt->domainname = nis_local_directory();
+	/* nis_local_directory () returns a pointer to a static buffer.
+	   We don't need to copy or free it. */
+	ctxt->domainname = nis_local_directory ();
 
 	if (!mapfmt)
 		mapfmt = MAPFMT_DEFAULT;
 
-	return !(ctxt->parse = open_parse(mapfmt, MODPREFIX, argc - 1, argv + 1));
+	return !(ctxt->parse =
+		 open_parse (mapfmt, MODPREFIX, argc - 1, argv + 1));
+}
+
+static int
+insert_to_buffer (const_nis_name name __attribute__ ((unused)),
+		  const nis_object * obj, const void *udata)
+{
+	const char *separator = udata;
+	u_int j;
+	char *buf = storage_buf;
+	int raw_binary = 0;
+	int buf_len = 0;
+
+	syslog (LOG_NOTICE, MODPREFIX "inserting to buffer, whatever");
+
+	for (j = 1; j < obj->EN_data.en_cols.en_cols_len; ++j) {
+		if (ENTRY_VAL (obj, j) != NULL) {
+			if ((obj->EN_data.en_cols.en_cols_val->
+			     ec_flags & EN_BINARY)
+			    && !raw_binary)
+				fputs ("*BINARY*", stdout);
+			else {
+				if ((buf_len + (int) ENTRY_LEN (obj, j)) >
+				    STORAGE_BUF_LEN) {
+					syslog (LOG_NOTICE,
+						MODPREFIX
+						"Trying to grow storage_buf beyond the limit of %d bytes while looking up an entry. Giving up",
+						STORAGE_BUF_LEN);
+					return -1;
+				}
+				sprintf (buf, "%.*s",
+					 (int) ENTRY_LEN (obj, j),
+					 ENTRY_VAL (obj, j));
+				if ((strlen (buf) +
+				     ((int) ENTRY_LEN (obj, j)) >
+				     STORAGE_BUF_LEN)) {
+					return -1;	/* XXX I don't know what the callback
+							 * should return to indicate an error, so
+							 * I'm going to punt here. -PN
+							 * <me@my_big_company>
+							 */
+				}
+				buf += ((int) ENTRY_LEN (obj, j) - 1);
+				buf_len += ((int) ENTRY_LEN (obj, j) - 1);
+			}
+		}
+		if (j + 1 < obj->EN_data.en_cols.en_cols_len) {
+			sprintf (buf, "%c", *separator);
+			buf++;
+		}
+	}
+	syslog (LOG_NOTICE, MODPREFIX "buf is %s", storage_buf);
+	// fputs ("\n", stdout);
+	return 0;
 }
 
-int lookup_ghost(const char *root, int ghost, time_t age, void *context)
+
+
+int
+lookup_mount (const char *root, const char *name, int name_len, void *context)
 {
-	return LKP_NOTSUP;
+	struct lookup_context *ctxt = (struct lookup_context *) context;
+	nis_result *res = NULL;
+	char separator = '\t';
+	int display_header = 0;
+	int print_object = 0;
+	int new_sep = 0;
+	int flags = EXPAND_NAME;
+	int i, result = 0;
+	char *mapname;
+	char my_tblname[2048];
+	char *tablename;
+
+	flags |= FOLLOW_LINKS;
+	flags |= FOLLOW_PATH;
+
+	syslog (LOG_NOTICE, MODPREFIX "looking up %s", name);
+
+	// sprintf(my_tblname, "[key=%s],%s.org_dir.%s", name, ctxt->mapname, ctxt->domainname);
+	sprintf (my_tblname, "[key=%s],%s.org_dir", name, ctxt->mapname);
+	tablename = strchr (my_tblname, ']');
+
+
+	syslog (LOG_NOTICE, MODPREFIX "looking up %s", my_tblname);
+
+
+	// syslog(LOG_NOTICE, MODPREFIX "tablename is: %s", tablename);
+	// syslog("tablename is %s\n", tablename);
+	if (tablename != NULL)
+		tablename += 2;
+	else
+		tablename = my_tblname;
+
+
+	syslog (LOG_NOTICE, MODPREFIX "now tablename is %s", tablename);
+	// printf("now tablename is %s\n", tablename);
+	result = 0;
+	res = nis_lookup (tablename, flags);
+	// syslog(LOG_NOTICE, MODPREFIX "resolved, buf is %s", storage_buf);
+
+	if (res == NULL ||
+	    (res->status != NIS_SUCCESS && res->status != NIS_S_SUCCESS)) {
+		// syslog(LOG_NOTICE, MODPREFIX "part 1: Storage buf ends up being: %s", storage_buf); 
+		if (res == NULL) {
+			fputs ("Out of memory!\n", stderr);
+			return -1;
+		}
+		else {
+			syslog (LOG_NOTICE,
+				MODPREFIX "lookup for %s failed: %s", name,
+				nis_sperrno (res->status));
+			// nis_perror (res->status, tablename);
+		}
+		nis_freeresult (res);
+		result = 1;
+		return -1;
+	}
+
+	/* If we have an TABLE_OBJ and don't print the object structure, get
+	   the table contents. */
+	if (__type_of (NIS_RES_OBJECT (res)) == NIS_TABLE_OBJ &&
+	    (!print_object || my_tblname[0] == '['))
+	{
+		char *buf = alloca (strlen (my_tblname) + 5);
+
+		if (buf == NULL) {
+			syslog (LOG_NOTICE, MODPREFIX "Out of memory!\n",
+				stderr);
+			return -1;
+		}
+
+		if (!new_sep && !print_object) {
+			/* Get the separator character */
+			separator = NIS_RES_OBJECT (res)->TA_data.ta_sep;
+		}
+		/* Get the contents of the table */
+		if (my_tblname[0] == '[')	/* Indexed names! */
+			strcpy (buf, my_tblname);
+		else
+			sprintf (buf, "[],%s", my_tblname);
+
+		res = nis_list (buf, flags, insert_to_buffer,
+				(void *) &separator);
+
+		// If there's nothing in the storage_buf (starts with a null char), then
+		// we need to do the lookup one more time for the "*" entry.
+		// -PN
+		syslog (LOG_NOTICE, MODPREFIX "buf is: %x", *storage_buf);
+		if (storage_buf[0] == '\0') {
+			// sprintf(my_tblname, "[key=*],%s.org_dir.%s", ctxt->mapname, ctxt->domainname);
+			sprintf (my_tblname, "[key=*],%s.org_dir",
+				 ctxt->mapname);
+			syslog (LOG_NOTICE,
+				MODPREFIX
+				"Got a fall-through, looking for %s",
+				my_tblname);
+			strcpy (buf, my_tblname);
+			res = nis_list (buf, flags, insert_to_buffer,
+					(void *) &separator);
+		}
+
+		if (res == NULL ||
+		    (res->status != NIS_SUCCESS
+		     && res->status != NIS_CBRESULTS)) {
+			if (res == NULL)
+				syslog (LOG_NOTICE,
+					MODPREFIX "Out of memory!");
+			else {
+				if (res->status == NIS_PARTIAL)
+					return -1;
+				nis_perror (res->status, my_tblname);
+			}
+			nis_freeresult (res);
+			result = 1;
+			return -1;
+		}
+	}
+
+	syslog (LOG_NOTICE,
+		MODPREFIX "part 2: Storage buf ends up being: %s\n",
+		storage_buf);
+	result = ctxt->parse->parse_mount (root, name, name_len, storage_buf,
+					   ctxt->parse->context);
+
+	syslog (LOG_NOTICE, MODPREFIX "%s -> %s", name, storage_buf);
+
+	return result;
 }
 
-int lookup_mount(const char *root, const char *name, int name_len, void *context)
+
+int
+lookup_mount_dist (const char *root, const char *name, int name_len,
+		   void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
-	char tablename[strlen(name) + strlen(ctxt->mapname) +
-		       strlen(ctxt->domainname) + 20];
+	char tablename[strlen (name) + strlen (ctxt->mapname) +
+		       strlen (ctxt->domainname) + 20];
 	nis_result *result;
 	int rv;
 
-	debug(MODPREFIX "looking up %s", name);
+	syslog (LOG_DEBUG, MODPREFIX "looking up %s", name);
 
-	sprintf(tablename, "[key=%s],%s.org_dir.%s", name, ctxt->mapname,
-		ctxt->domainname);
+	sprintf (tablename, "[key=%s],%s.org_dir.%s", name, ctxt->mapname,
+		 ctxt->domainname);
 
-	result = nis_list(tablename, FOLLOW_PATH | FOLLOW_LINKS, NULL, NULL);
+	result = nis_list (tablename, FOLLOW_PATH | FOLLOW_LINKS, NULL, NULL);
 	if (result->status != NIS_SUCCESS && result->status != NIS_S_SUCCESS) {
 		/* Try to get the "*" entry if there is one - note that we *don't*
 		   modify "name" so & -> the name we used, not "*" */
-		sprintf(tablename, "[key=*],%s.org_dir.%s", ctxt->mapname,
-			ctxt->domainname);
-		result = nis_list(tablename, FOLLOW_PATH | FOLLOW_LINKS, NULL, NULL);
+		sprintf (tablename, "[key=*],%s.org_dir.%s", ctxt->mapname,
+			 ctxt->domainname);
+		result = nis_list (tablename, FOLLOW_PATH | FOLLOW_LINKS,
+				   NULL, NULL);
 	}
 	if (result->status != NIS_SUCCESS && result->status != NIS_S_SUCCESS) {
-		crit(MODPREFIX "lookup for %s failed: %s", name,
-		       nis_sperrno(result->status));
+		syslog (LOG_NOTICE, MODPREFIX "lookup for %s failed: %s",
+			name, nis_sperrno (result->status));
 		return 1;
 	}
 
-	debug(MODPREFIX "%s -> %s", name,
-	       NIS_RES_OBJECT(result)->EN_data.en_cols.en_cols_val[1].ec_value.
-	       ec_value_val);
-
-	rv = ctxt->parse->parse_mount(root, name, name_len,
-				      NIS_RES_OBJECT(result)->EN_data.en_cols.
-				      en_cols_val[1].ec_value.ec_value_val,
-				      ctxt->parse->context);
+	syslog (LOG_DEBUG, MODPREFIX "%s -> %s", name,
+		NIS_RES_OBJECT (result)->EN_data.en_cols.en_cols_val[1].
+		ec_value.ec_value_val);
+
+	rv = ctxt->parse->parse_mount (root, name, name_len,
+				       NIS_RES_OBJECT (result)->EN_data.
+				       en_cols.en_cols_val[1].ec_value.
+				       ec_value_val, ctxt->parse->context);
 	return rv;
 }
 
-int lookup_done(void *context)
+int
+lookup_done (void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
-	int rv = close_parse(ctxt->parse);
-	free(ctxt);
+	int rv = close_parse (ctxt->parse);
+	free (ctxt);
 	return rv;
 }

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--/WwmFnJnmDyWGHa4--

