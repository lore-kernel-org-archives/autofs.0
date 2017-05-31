From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Fix usage of uninitialized pointer
Date: Wed, 31 May 2017 09:37:44 +0800
Message-ID: <1496194664.3804.3.camel@themaw.net>
References: <1496151337-21367-1-git-send-email-buczek@molgen.mpg.de>
         <1496190434.3804.1.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=oAKFBtdtt35J3c0Xpw
        B1XNIxdOGF7JKGPSK7nrwBOUI=; b=UkQhCBV2F1s2JrCCyvyHSNNVllKOHbIBUd
        e+qN3QYo8187aRdzUuDJgnJaHe/Z2IyzGpkEv0Miq5dg4IeozlTE9Yy2ukhCFHAY
        nj++O8Uwuh+F9TYWOaRFdKyJRJzX87na5hxdTWSGPw55W6tuHepWqA7g8lZ1Bn7L
        VHmdSSXmVkdLWcXSZF5334nLIj6vTcaFG0lOJ8YT89UC+aeUCEz9bfS+CgT+DCa5
        KID3zK8ERv9BMnotrz4lmcq9e22NmXq7BIFffu+PuEuUbytFjCx+IhsP6+aJx7oU
        5BL0p68USfHhPXgQvgoMI2Uj1gp1Q7+dCS38KGKB0tRsz9OWW+gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=oAKFBtdtt35J3c0XpwB1XNIxdOGF7JKGPSK7nrwBOUI=; b=iIW80oet
        w9P/ZUSALMCYBqyBehpwysmnQ8yx56diJ+EUUvX0MNYgFLVhCBgYyIJglVFvAISF
        MTRN/y298iwMFqkBgljxQmjwApBPqI3OaDyLVeeM3CGXXZWjLN7+HiR+Sk08lXKg
        Paly2PlYlAqrTDBDQRRtVv7IEFIuDCkIvgz7bJMRmS82919DaqC0ikG4HkAVA0Uu
        1L9gc8bmA4wgxjvrWzxHx7dldgouOIOWlu5Rc7UTMYw5985sv2JnF/UZ2pZACz90
        CQOy0X7s0bRzNtK4pqgB6Y/zACZS2s+xPN5wbBXAiBUyWp1wBW8Qy0yq5a4XH1cd
        YLx0zRr0ZmKOdg==
In-Reply-To: <1496190434.3804.1.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs@vger.kernel.org

On Wed, 2017-05-31 at 08:27 +0800, Ian Kent wrote:
> On Tue, 2017-05-30 at 15:35 +0200, Donald Buczek wrote:
> > In the error path after a getgrgid_r failure (e.g. when a unnamed gid
> > was used), the pointer tsv->group was left unitialized. Still the tsv
> > was given to pthread_setspecific(key_thread_stdenv_vars,...) and the
> > consumers used and freed the uninitialized pointer.
> 
> Umm ... ok, I'll check ... good catch.

I think this bug will warrant another release.

> 
> > 
> >     2017-05-29T18:16:11+02:00 rofl automount[14749]: attempting to mount
> > entry
> > /package/twiki
> >     2017-05-29T18:16:11+02:00 rofl automount[14749]: set_tsd_user_vars:
> > failed
> > to get group info from getgrgid_r
> >     2017-05-29T18:16:11+02:00 rofl automount[14749]: mounted /package/twiki
> >     2017-05-29T18:16:11+02:00 rofl systemd[1]: automount.service: main
> > process
> > exited, code=dumped, status=6
> >     2017-05-29T18:16:12+02:00 rofl systemd[1]: automount.service holdoff
> > time
> > over, scheduling restart.
> >     2017-05-29T18:16:12+02:00 rofl systemd[1]: Unit automount.service
> > entered
> > failed state.
> >     2017-05-29T18:16:12+02:00 rofl automount[17936]: Starting automounter
> > version 5.1.3, master map auto.master
> > 
> >     [May29 18:16] traps: automount[18234] general protection ip:7f8b025c324a
> > sp:7f8b0049a508 error:0 in libc-2.19.so[7f8b02541000+1a2000]
> > 
> > Handle the error by not calling pthread_setspecific. Clean up
> > and return instead.
> > ---
> >  lib/mounts.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/lib/mounts.c b/lib/mounts.c
> > index ce6a60a..fe1a6cd 100644
> > --- a/lib/mounts.c
> > +++ b/lib/mounts.c
> > @@ -1552,28 +1552,31 @@ void set_tsd_user_vars(unsigned int logopt, uid_t
> > uid,
> > gid_t gid)
> >  	}
> >  
> >  no_group:
> > -	if (status || !pgr)
> > +	if (status || !pgr) {
> >  		error(logopt, "failed to get group info from getgrgid_r");
> > -	else {
> 
> Extra braces, I leave these out (when I can) on single statement clauses
> deliberately and always try to put the single statement as the first branch of
> the if.
> 
> > +		goto free_gr_tmp;
> > +	} else {
> >  		tsv->group = strdup(gr.gr_name);
> > -		if (!tsv->group)
> > +		if (!tsv->group) {
> >  			error(logopt, "failed to malloc buffer for group");
> > +			goto free_gr_tmp;
> > +		}
> >  	}
> >  
> > -	if (gr_tmp)
> > -		free(gr_tmp);
> > -
> >  	status = pthread_setspecific(key_thread_stdenv_vars, tsv);
> >  	if (status) {
> >  		error(logopt, "failed to set stdenv thread var");
> >  		goto free_tsv_group;
> >  	}
> > -
> > +	if (gr_tmp)
> > +		free(gr_tmp);
> 
> But this doesn't do what I intended.
> 
> What I want to do is set the thread specific standard variables even if the
> group name can't be obtained.
> 
> It looks like I've made an assumption elsewhere that if the tsd is set then
> all
> the variables have valid values, I'd rather fix that than do this.

I would prefer to do this instead.

Could you check this resolves the problem you have seen please.

autofs-5.1.3 - fix unset tsd group name handling

From: Ian Kent <raven@themaw.net>

Commit 1a64a6bbc5 changed set_tsd_user_vars() to set the thread specific
values even if the group name could not be obtained.

But the structure holding the values was not initialized on allocation
so the group field might not be NULL when no group name is available.

Also the macro addition and removal functions didn't handle setting a
macro name with a NULL value.

Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: Donald Buczek <buczek@molgen.mpg.de>
---
 lib/macros.c |   27 +++++++++++++--------------
 lib/mounts.c |    1 +
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/macros.c b/lib/macros.c
index ff9ba89..30dbcdb 100644
--- a/lib/macros.c
+++ b/lib/macros.c
@@ -281,19 +281,21 @@ macro_addvar(struct substvar *table, const char *str, int
len, const char *value
 	}
 
 	if (lv) {
-		char *this = malloc(strlen(value) + 1);
-		if (!this) {
-			lv = table;
-			goto done;
+		char *this = NULL;
+
+		if (value) {
+			this = malloc(strlen(value) + 1);
+			if (this)
+				strcpy(this, value);
 		}
-		strcpy(this, value);
-		free(lv->val);
+		if (lv->val)
+			free(lv->val);
 		lv->val = this;
 		if (lv != table)
 			lv = table;
 	} else {
 		struct substvar *new;
-		char *def, *val;
+		char *def, *val = NULL;
 
 		def = strdup(str);
 		if (!def) {
@@ -302,18 +304,15 @@ macro_addvar(struct substvar *table, const char *str, int
len, const char *value
 		}
 		def[len] = '\0';
 
-		val = strdup(value);
-		if (!val) {
-			lv = table;
-			free(def);
-			goto done;
-		}
+		if (value)
+			val = strdup(value);
 
 		new = malloc(sizeof(struct substvar));
 		if (!new) {
 			lv = table;
 			free(def);
-			free(val);
+			if (val)
+				free(val);
 			goto done;
 		}
 		new->def = def;
diff --git a/lib/mounts.c b/lib/mounts.c
index ce6a60a..0b38bd8 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1463,6 +1463,7 @@ void set_tsd_user_vars(unsigned int logopt, uid_t uid,
gid_t gid)
 		error(logopt, "failed alloc tsv storage");
 		return;
 	}
+	memset(tsv, 0, sizeof(struct thread_stdenv_vars));
 
 	tsv->uid = uid;
 	tsv->gid = gid;
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
