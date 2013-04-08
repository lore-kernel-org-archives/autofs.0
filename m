From: Ian Kent <raven@themaw.net>
Subject: Re: Mounts not expiring in setups with nested submounts
Date: Mon, 08 Apr 2013 15:48:40 +0800
Message-ID: <1365407320.2409.6.camel@perseus.fritz.box>
References: <CAEySpB6ZRVmtbFmPuL-k1fVxeHdtnKm8ncmXGt5R0ZTL2dXr1w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=YdcStNe9GxUrqWat6H+7iT5z+do=; b=CkCINaw+7yOXj85tMDjQ57nidiS+
	xv478iaHGFSV1myIGvB2mRGb/tX30vkswAU5QSTDsyu8STM/kCDkgRW0JmbHXNLt
	xNrK+PuhmcNKE9wdqr58QVlvoOz8LhvwEHg27L8KizKRmsQFDnbTZcvi1iuWtGCc
	vqgzpik4OUZDfz8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=YdcStNe9GxUrqWat6H+7iT
	5z+do=; b=W2GIvZ4nMT7M01hYemIM9gH0as6n3zJxqSKd40Alfart2bs8HT3Yrf
	Lsh81GZhvzxzlkqJj5n70AEpsDUw9Ts57Da6+WIM+cGWlHQMZ7/4v1/+ZDqNQmhr
	cXji2/9koShk84kDHffBCxiuVDyPi6mpEbqaoLedWibcUNRbfBYMk=
In-Reply-To: <CAEySpB6ZRVmtbFmPuL-k1fVxeHdtnKm8ncmXGt5R0ZTL2dXr1w@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs <autofs@vger.kernel.org>

On Fri, 2013-03-29 at 17:33 -0300, Leonardo Chiquitto wrote:
> 
> Ian: do you think the "occasional deadlocks" mentioned in the
> expire-specific-submount-only patch might have been addressed
> by other changes (so we can use the patch below)? Or do you
> see another way to fix the problem?

Think so.

> 
> diff --git a/lib/master.c b/lib/master.c
> index a0e62f2..99b1092 100644
> --- a/lib/master.c
> +++ b/lib/master.c
> @@ -906,8 +906,10 @@ int master_notify_submount(struct autofs_point
> *ap, const char *path, enum state
>  		p = p->prev;
> 
>  		if (!master_submount_list_empty(this)) {
> -			mounts_mutex_unlock(ap);
> -			return master_notify_submount(this, path, state);
> +			if (!master_notify_submount(this, path, state)) {
> +				ret = 0;
> +				break;
> +			}
>  		}
> 
>  		/* path not the same */

I think the mounts mutex needs to be re-taken and then check if the
submount has gone away.

The list curor for the next one to check (set to p->prev) should always
be ok because there's only one expire process for a given mount but the
one we are checking (this) could go away, in which case we're done.

This patch seems to work.

autofs-5.0.7 - fix submount tree not all expiring

From: Ian Kent <ikent@redhat.com>

Due to the change in the expire-specific-submount-only patch, sub-mounts
within an indirect mount that follow a submount (in the check order) won't
be expired if that submount is busy.
---
 lib/master.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/lib/master.c b/lib/master.c
index a0e62f2..64dbcb1 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -905,15 +905,24 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 		this = list_entry(p, struct autofs_point, mounts);
 		p = p->prev;
 
-		if (!master_submount_list_empty(this)) {
-			mounts_mutex_unlock(ap);
-			return master_notify_submount(this, path, state);
-		}
-
 		/* path not the same */
 		if (strcmp(this->path, path))
 			continue;
 
+		if (!master_submount_list_empty(this)) {
+			char *this_path = strdup(this->path);
+			if (this_path) {
+				mounts_mutex_unlock(ap);
+				master_notify_submount(this, path, state);
+				mounts_mutex_lock(ap);
+				if (!__master_find_submount(ap, this_path)) {
+					free(this_path);
+					continue;
+				}
+				free(this_path);
+			}
+		}
+
 		/* Now we have found the submount we want to expire */
 
 		st_mutex_lock();
@@ -959,10 +968,7 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 			st_mutex_lock();
 		}
 		st_mutex_unlock();
-		mounts_mutex_unlock(ap);
-
-		return ret;
-
+		break;
 	}
 
 	mounts_mutex_unlock(ap);


