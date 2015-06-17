From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] autofs: handle old configuration format
Date: Wed, 17 Jun 2015 09:29:46 -0700
Message-ID: <1434558586-9442-1-git-send-email-jbacik@fb.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : subject : date
 : message-id : mime-version : content-type; s=facebook;
 bh=g5cllsQjaSXM71oDAYn21KDasdT7+5x7bwwpjLuOj78=;
 b=aLT/OqCqHP9lhGYwWk8dO9UDhgzPlmmVqMx86d736Psb+PGFWyK2Wri1mN+BOxk2jDgM
 eDQ4hYEa+hOM0es8bXjPDWZiH42llqaOYr3Cr1r4d2RdSmO9KQJBFZ62udnVC/ogGa/j
 KdmFRsIrfFlGIIBshhf+AyRJDKN1SZXV7QA= 
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ikent@redhat.com, autofs@vger.kernel.org

This is a patch to fix

http://bugzilla.centos.org/view.php?id=8614

The configuration stuff was redone and it broke backwards compatiblity.
Unfortunately this was backported to Centos/RHEL, so configurations that were
working in 6.4 suddenly broke in 6.6, which is not helpful.  Fix this by
noticing if we are looking at the old configuration file, strip out the DEFAULT_
bit of the variable if it is there and tolower the rest of the string.  This
makes it so our old configuration works properly and now people get their home
dirs automounted properly with either versions of autofs.  Thanks,

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 lib/defaults.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/defaults.c b/lib/defaults.c
index 5711e65..cd43a60 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -776,6 +776,27 @@ static int check_set_config_value(const char *section,
 	return ret;
 }
 
+static int check_set_old_config_value(const char *section, const char *key,
+				      const char *value)
+{
+	const char *pkey = key;
+	char lkey[PATH_MAX+1];
+	char *plkey = &lkey[0];
+
+	/*
+	 * The old format was DEFAULT_whatever, so just trim the DEFAULT_ bit if
+	 * it's there.
+	 */
+	if (strstr(key, "DEFAULT_"))
+		pkey += strlen("DEFAULT_");
+
+	/* Lower case everything */
+	while (*pkey)
+		*plkey++ = tolower(*pkey++);
+	*plkey = '\0';
+	return check_set_config_value(section, lkey, value);
+}
+
 static int parse_line(char *line, char **sec, char **res, char **value)
 {
 	char *key, *val, *trailer;
@@ -924,7 +945,10 @@ static int read_config(unsigned int to_syslog, FILE *f, const char *name)
 				"%s is not used by autofs, ignored", res);
 			continue;
 		}
-		check_set_config_value(new_sec, key, value);
+		if (name == OLD_CONFIG_FILE)
+			check_set_old_config_value(new_sec, key, value);
+		else
+			check_set_config_value(new_sec, key, value);
 	}
 
 	if (!feof(f) || ferror(f)) {
-- 
2.1.0

