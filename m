From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fix buffer overflow
Date: Wed, 21 Nov 2007 21:39:41 +0900
Message-ID: <1195648781.3076.17.camel@raven.themaw.net>
References: <20071121111730.22911.53791.stgit@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20071121111730.22911.53791.stgit@sor.suse.de>
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
To: Matthias Koenig <mkoenig@suse.de>
Cc: autofs@linux.kernel.org

On Wed, 2007-11-21 at 12:17 +0100, Matthias Koenig wrote:
> A overflow problem due to wrong size specification in read/write
> calls is fixed.

What can I say, "that's really dumb of me!".

> 
> Signed-off-by: Matthias Koenig <mkoenig@suse.de>
> ---
> 
>  daemon/automount.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/daemon/automount.c b/daemon/automount.c
> index 7becad5..f31ec11 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -1125,7 +1125,7 @@ static void become_daemon(unsigned foreground)
>  		if (pid > 0) {
>  			int r;
>  			close(start_pipefd[1]);
> -			r = read(start_pipefd[0], pst_stat, sizeof(pst_stat));
> +			r = read(start_pipefd[0], pst_stat, sizeof(*pst_stat));
>  			if (r < 0)
>  				exit(1);
>  			exit(*pst_stat);
> @@ -2061,12 +2061,12 @@ int main(int argc, char *argv[])
>  	if (!master_read_master(master_list, age, 0)) {
>  		master_kill(master_list);
>  		*pst_stat = 3;
> -		res = write(start_pipefd[1], pst_stat, sizeof(pst_stat));
> +		res = write(start_pipefd[1], pst_stat, sizeof(*pst_stat));
>  		close(start_pipefd[1]);
>  		exit(3);
>  	}
>  
> -	res = write(start_pipefd[1], pst_stat, sizeof(pst_stat));
> +	res = write(start_pipefd[1], pst_stat, sizeof(*pst_stat));
>  	close(start_pipefd[1]);
>  
>  	state_mach_thid = pthread_self();
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
