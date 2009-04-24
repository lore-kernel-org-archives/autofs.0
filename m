From: Stef Bon <stef@bononline.nl>
Subject: Re: Automounter stops after reload signal.
Date: Fri, 24 Apr 2009 10:19:19 +0200
Message-ID: <49F17607.1010606@bononline.nl>
References: <49DCCD73.5050307@bononline.nl>
	<1239545315.23791.0.camel@zeus.themaw.net>
	<49E22C1D.8030504@bononline.nl> <49E2D284.1040801@themaw.net>
	<49E2F90A.9010901@bononline.nl> <49E2FF76.2080108@themaw.net>
	<20090424043142.GA3172@zeus.themaw.net>
	<20090424045400.GA5578@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090424045400.GA5578@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> Oops, that's not quite right.
> Try this instead, of course the CHANGELOG hunk might not apply.
>
> autofs-5.0.4 - library reload fix update fix
>
> From: Ian Kent <raven@themaw.net>
>
> The library reload fixes introduced a bug which causes autofs to
> incorrectly shutdown. Previously the signal handling thread only
> recieved signals either when they were explicity sent or it was
> time to shutdown so continuing on to call the signal handling
> routine was the correct thing to do. Now we need to join with
> the mount handling thread at exit but, in this case, we don't
> want to continue on to the signal handling routine as that will
> incorrectly cause the signal to be passed on to other mount
> handling threads.
> ---
>
>  CHANGELOG          |    1 +
>  daemon/automount.c |   13 +++++++++++--
>  lib/master.c       |    2 --
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
>
> diff --git a/CHANGELOG b/CHANGELOG
> index 7ca45fd..5e01812 100644
> --- a/CHANGELOG
> +++ b/CHANGELOG
> @@ -44,6 +44,7 @@
>  - use intr option as hosts mount default.
>  - fix kernel includes.
>  - dont umount existing direct mount on master re-read.
> +- fix incorrect shutdown introduced by library relaod fixes.
>  
>  4/11/2008 autofs-5.0.4
>  -----------------------
> diff --git a/daemon/automount.c b/daemon/automount.c
> index 80691fa..d7e3e12 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -1332,8 +1332,17 @@ static void *statemachine(void *arg)
>  		case SIGTERM:
>  		case SIGINT:
>  		case SIGUSR2:
> -			if (master_done(master_list))
> -				return NULL;
> +			master_mutex_lock();
> +			if (!list_empty(&master_list->completed)) {
> +				if (master_done(master_list)) {
> +					master_mutex_unlock();
> +					return NULL;
> +				}
> +				master_mutex_unlock();
> +				break;
> +			}
> +			master_mutex_unlock();
> +
>  		case SIGUSR1:
>  			do_signals(master_list, sig);
>  			break;
> diff --git a/lib/master.c b/lib/master.c
> index 762094f..e43f835 100644
> --- a/lib/master.c
> +++ b/lib/master.c
> @@ -1182,7 +1182,6 @@ int master_done(struct master *master)
>  	struct master_mapent *entry;
>  	int res = 0;
>  
> -	master_mutex_lock();
>  	head = &master->completed;
>  	p = head->next;
>  	while (p != head) {
> @@ -1195,7 +1194,6 @@ int master_done(struct master *master)
>  	}
>  	if (list_empty(&master->mounts))
>  		res = 1;
> -	master_mutex_unlock();
>  
>  	return res;
>  }
>
>   
Ok, thanks a lot! I will try this.

Stef Bon
