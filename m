From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Tue, 29 Nov 2005 14:09:17 -0500
Message-ID: <17292.42845.186329.808676@segfault.boston.redhat.com>
References: <1132670358.4039.37.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222329100.9982@donald.themaw.net>
	<17283.17854.189791.135878@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0511242311570.2314@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511242311570.2314@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds; Ian Kent <raven@themaw.net> adds:

raven> On Tue, 22 Nov 2005, Jeff Moyer wrote:
>> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds; Ian Kent <raven@themaw.net> adds:
>> 

raven> Could you review this patch please Jeff.

After reviewing this further, I did find a problem.  See below.

> --- autofs-4.1.4/modules/lookup_file.c.update-fix	2005-11-24 22:00:30.000000000 +0800
> +++ autofs-4.1.4/modules/lookup_file.c	2005-11-24 22:52:56.000000000 +0800
[snip]
> @@ -407,12 +407,12 @@ int lookup_mount(const char *root, const

>  	/* only if it has been modified */
>  	if (st.st_mtime > ctxt->mtime) {
> +		exists = cache_lookup(key);
> +
>  		ret = lookup_one(root, key, key_len, ctxt);
> -		if (!ret)
> +		if (!exists && !ret)
>  			return 1;

This check is wrong.  ret will be zero only if there is a failure reading
the map or adding an entry to the cache.  I think the code should look
like so:

	if (st.st_mtime > ctxt->mtime) {
		exists = cache_lookup(key);

		ret = lookup_one(root, key, key_len, ctxt);
		if (!ret)
			return 1;

		if (ret == CHE_MISSING && exists) {          <----------
			if (!cache_delete(root, key, CHE_RMPATH))
				rmdir_path(key);

			/* Maybe update wild card map entry */
			if (ap.type == LKP_INDIRECT)
				lookup_wild(root, ctxt);

			/* Have parent update its map */
			if (t_last_read > ap.exp_runfreq)
				kill(getppid(), SIGHUP);
		} else if (ret == CHE_UPDATED) {
			/* Have parent update its map */
			if (t_last_read > ap.exp_runfreq)
				kill(getppid(), SIGHUP);
		}
	}

As a matter of cleanliness, it would be good to use the CHE_ defines when
testing for error.  This mistake likely would not have been made if the
code had read:

		if (ret == CHE_FAIL)
			return 1;

instead of "if (!ret)".

-Jeff
