From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] More autofs cleanup
Date: Mon, 14 Aug 2006 08:17:03 -0400
Message-ID: <x4964gv7br4.fsf@segfault.boston.devel.redhat.com>
References: <20060811023733.GC26249@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060811023733.GC26249@mail.iSKUNK.ORG> (Daniel Richard G.'s
	message of "Thu, 10 Aug 2006 22:37:33 -0400")
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
To: "Daniel Richard G." <skunk@iskunk.org>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] [PATCH] More autofs cleanup; "Daniel Richard G." <skunk@iskunk.org> adds:

skunk> Hello list, Finally built and semi-figured-out git. A few more
skunk> wrinkles ironed out in this patch.

skunk> modules/lookup_hosts.c:

skunk> * Fixed more weirdness of using sprintf()'s return value.

@@ -170,10 +172,10 @@ int lookup_mount(struct autofs_point *ap
 	 */
 	if (*name == '/') {
 		pthread_cleanup_push(cache_lock_cleanup, mc);
-		mapent = alloca(strlen(me->mapent) + 1);
-		mapent_len = sprintf(mapent, me->mapent);
+		mapent_len = strlen(me->mapent);
+		mapent = alloca(mapent_len + 1);
+		strcpy(mapent, me->mapent);
 		pthread_cleanup_pop(0);
-		mapent[mapent_len] = '\0';
 	}
 done:
 	cache_unlock(mc);

This is just a refactoring of code with no real gain.  The previous usage
was correct.

As Ian mentioned before, posting patches inline makes it easier to quote in
the reply (at least for my arcane mailer.  ;).


The rest up to this point looks pretty good to me.  Thanks a bunch for
doing this!

-Jeff
