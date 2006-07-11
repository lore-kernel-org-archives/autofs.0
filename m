From: Heinrich Rebehn <rebehn@ant.uni-bremen.de>
Subject: Re: automount removes mountpoint upon exit
Date: Tue, 11 Jul 2006 16:06:39 +0200
Message-ID: <44B3B06F.90006@ant.uni-bremen.de>
References: <44B23316.7050808@ant.uni-bremen.de>
	<x494pxp1ql7.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x494pxp1ql7.fsf@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> ==> Regarding [autofs] automount removes mountpoint upon exit; Heinrich Rebehn <rebehn@ant.uni-bremen.de> adds:
> 
> rebehn> Hi list,
> 
> rebehn> We use automount 4.1.3 in our Kubuntu cluster.  In this cluster,
> rebehn> all machines mount their nfsroot ro for security reasons, except
> rebehn> for one "master" machine which is used to maintain the nfsroot.  I
> rebehn> discovered that every time the master machine shuts down, all the
> rebehn> autofs mountpoints are removed. If another machine reboots while
> rebehn> the master machine is down, autofs is unable to recreate the
> rebehn> mountpoints and thus fails.
> 
> rebehn> Is there any way to keep automount from removing the mountpoint
> rebehn> upon exit?
> 
> Well, in the RHEL version of the package we added a patch that causes
> automount to only remove directories if it had created them.  Thus, if you
> simply create the top-level automount points, those won't be removed by the
> demon exiting,  However, if you rely on path components below the
> top-level, you are out of luck.
> 
> I've attached the patch, not sure if it will apply to vanilla 4.1.3.
> 
> -Jeff
> 
> --- autofs-4.1.3/daemon/automount.c.no-rmdir	2005-01-21 13:04:38.153059825 -0600
> +++ autofs-4.1.3/daemon/automount.c	2005-01-21 13:11:26.316690021 -0600
> @@ -429,9 +429,17 @@ static int mount_autofs(char *path)
>  	ap.pipefd = ap.ioctlfd = -1;
>  
>  	/* In case the directory doesn't exist, try to mkdir it */
> -	if (mkdir_path(path, 0555) < 0 && errno != EEXIST && errno != EROFS) {
> -		crit("failed to create iautofs directory %s", ap.path);
> -		return -1;
> +	if (mkdir_path(path, 0555) < 0) {
> +		if (errno != EEXIST && errno != EROFS) {
> +			crit("failed to create iautofs directory %s", ap.path);
> +			return -1;
> +		}
> +		/* If we recieve an error, and it's EEXIST or EROFS we know
> +		   the directory was not created. */
> +		ap.dir_created = 0;
> +	} else {
> +		/* No errors so the directory was successfully created */
> +		ap.dir_created = 1;
>  	}
>  
>  	/* Pipe for kernel communications */
> @@ -1349,7 +1357,7 @@ static void cleanup_exit(const char *pat
>  
>  	closelog();
>  
> -	if ((!ap.ghost || !submount) && *(path + 1) != '-')
> +	if ((!ap.ghost || !submount) && (*(path + 1) != '-') && ap.dir_created)
>  		if (rmdir(path) == -1)
>  			warn("failed to remove dir %s: %m", path);
>  
> @@ -1672,6 +1680,7 @@ int main(int argc, char *argv[])
>  	ap.exp_timeout = DEFAULT_TIMEOUT;
>  	ap.ghost = DEFAULT_GHOST_MODE;
>  	ap.type = LKP_INDIRECT;
> +	ap.dir_created = 0; /* We haven't created the main directory yet */
>  
>  	opterr = 0;
>  	while ((opt = getopt_long(argc, argv, "+hp:t:vdVg", long_options, NULL)) != EOF) {
> --- autofs-4.1.3/include/automount.h.no-rmdir	2005-01-21 13:04:38.157059762 -0600
> +++ autofs-4.1.3/include/automount.h	2005-01-21 13:04:38.189059263 -0600
> @@ -111,6 +111,8 @@ struct autofs_point {
>  	struct lookup_mod *lookup;		/* Lookup module */
>  	enum states state;
>  	int state_pipe[2];
> +	unsigned dir_created;		/* Was a directory created for this
> +					   mount? */
>  };
>  
>  /* Standard function used by daemon or modules */

Thank you for the patch, Jeff.
However, i failed to understand the debian package system and simply 
have no time to read a couple of manpages and howtos just to implement 
this small patch. So i simply set the immutable flag on our server and 
it works!

Will this patch be in the officcial version some day, so we eventually 
see it in debian or ubuntu?

--Heinrich
