From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: Test autofs versions first on sb initialization
Date: Thu, 07 Jul 2016 13:42:33 +0800
Message-ID: <1467870153.3206.20.camel@themaw.net>
References: <1467466183-7058-1-git-send-email-kusumi.tomohiro@gmail.com>
	 <1467598729.3317.6.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=94NK2InhCxCpUGS3diYtmCb8n/w=; b=rCptbM
	+CMSxH5iuGBRFLPKxmy6hfDCHGoaSgEbEAt4lK7JlWXQXs+Lm7tdbBNPgYqK5zW6
	Oj8IuhXp3rkR7nB08pCtCOrurPx8naYAqzz5laDEkQt/3pN8wp5ZDhrUq7w4nGfi
	Dog4hWbJ7MYt2SpeRAr7yg/u/NOb2lYQwx42c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=94NK2InhCxCpUGS
	3diYtmCb8n/w=; b=pZ6SVBFBcNgO5mD2Iq+adEfKKVfCWqmNB6vab3Zergw5eEz
	YF/4mDhWsN5KyCa/ACzQodA8oPSfjC6BZQyoB/FLhNPw1e45F6tz3s6L1TqM0sR5
	/u4QK3iFIAqKAVUMJLtCCZ0zIKHel5e9dDj3ntAjIS8OD9y2L/TNgHVBZfOo=
In-Reply-To: <1467598729.3317.6.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2016-07-04 at 10:18 +0800, Ian Kent wrote:
> On Sat, 2016-07-02 at 22:29 +0900, Tomohiro Kusumi wrote:
> > This patch does what the below comment says.
> > It could be and it's considered better to do this first
> > before various functions get called during initialization.
> 
> I don't really see the importance of this but ok.
> 
> Though looking at it I think a problem with the error handling gotos has crept
> in (I think prior to your patch).
> 
> I'll need to look more closely at that when I get time.

I've added this to the list as well, along with a patch I think resolves the
error handling exit gotos, could you have a look in case I've made any stupid
mistakes.

autofs - fix autofs4_fill_super() error exit handling

From: Ian Kent <raven@themaw.net>

Somewhere along the line the error handling gotos have become incorrect
and a little more complicated than need be.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/inode.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 8357544..2b3b54b 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -313,7 +313,7 @@ int autofs4_fill_super(struct super_block *s, void *data,
int silent)
 
 	if (!pipe) {
 		pr_err("could not open pipe file descriptor\n");
-		goto fail_dput;
+		goto fail_put_pid;
 	}
 	ret = autofs_prepare_pipe(pipe);
 	if (ret < 0)
@@ -334,14 +334,13 @@ int autofs4_fill_super(struct super_block *s, void *data,
int silent)
 fail_fput:
 	pr_err("pipe file descriptor does not contain proper ops\n");
 	fput(pipe);
-	/* fall through */
+fail_put_pid:
+	put_pid(sbi->oz_pgrp);
 fail_dput:
 	dput(root);
-	goto fail_free;
 fail_ino:
 	kfree(ino);
 fail_free:
-	put_pid(sbi->oz_pgrp);
 	kfree(sbi);
 	s->s_fs_info = NULL;
 	return ret;



> > 
> > /* Couldn't this be tested earlier? */
> > ---
> >  fs/autofs4/inode.c | 34 +++++++++++++++++-----------------
> >  1 file changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> > index 61b2105..8357544 100644
> > --- a/fs/autofs4/inode.c
> > +++ b/fs/autofs4/inode.c
> > @@ -274,6 +274,23 @@ int autofs4_fill_super(struct super_block *s, void
> > *data,
> > int silent)
> >  		goto fail_dput;
> >  	}
> >  
> > +	/* Test versions first */
> > +	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
> > +	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
> > +		pr_err("kernel does not match daemon version "
> > +		       "daemon (%d, %d) kernel (%d, %d)\n",
> > +		       sbi->min_proto, sbi->max_proto,
> > +		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
> > +		goto fail_dput;
> > +	}
> > +
> > +	/* Establish highest kernel protocol version */
> > +	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
> > +		sbi->version = AUTOFS_MAX_PROTO_VERSION;
> > +	else
> > +		sbi->version = sbi->max_proto;
> > +	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
> > +
> >  	if (pgrp_set) {
> >  		sbi->oz_pgrp = find_get_pid(pgrp);
> >  		if (!sbi->oz_pgrp) {
> > @@ -291,23 +308,6 @@ int autofs4_fill_super(struct super_block *s, void
> > *data,
> > int silent)
> >  	root_inode->i_fop = &autofs4_root_operations;
> >  	root_inode->i_op = &autofs4_dir_inode_operations;
> >  
> > -	/* Couldn't this be tested earlier? */
> > -	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
> > -	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
> > -		pr_err("kernel does not match daemon version "
> > -		       "daemon (%d, %d) kernel (%d, %d)\n",
> > -		       sbi->min_proto, sbi->max_proto,
> > -		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
> > -		goto fail_dput;
> > -	}
> > -
> > -	/* Establish highest kernel protocol version */
> > -	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
> > -		sbi->version = AUTOFS_MAX_PROTO_VERSION;
> > -	else
> > -		sbi->version = sbi->max_proto;
> > -	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
> > -
> >  	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi
> > ->oz_pgrp));
> >  	pipe = fget(pipefd);
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
