From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] FD_CLOEXEC cleanups
Date: Thu, 03 Apr 2008 00:02:44 +0800
Message-ID: <1207152164.23879.11.camel@raven.themaw.net>
References: <x49od8te2wh.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49od8te2wh.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, raven@themaw.net


On Tue, 2008-04-01 at 16:27 -0400, Jeff Moyer wrote:
> Hi, Ian,
> 
> We set the close on exec flag all over the place.  This patch just
> cleans things up a bit.

Yep, good idea.

I would like to postpone this till after the mount control work is done
because a number of these will be moved to the single open routine.

> 
>  daemon/automount.c      |   27 ++++---------------------
>  daemon/direct.c         |   50 ++++++++++++------------------------------------
>  daemon/indirect.c       |    7 +-----
>  include/automount.h     |   13 +++++++++++-
>  lib/nss_parse.y         |    7 +-----
>  lib/rpc_subs.c          |   14 +++----------
>  modules/lookup_file.c   |   28 +++++++-------------------
>  modules/mount_changer.c |    6 -----
>  modules/replicated.c    |    7 +-----
>  9 files changed, 49 insertions(+), 110 deletions(-)
> 
> Cheers,
> 
> Jeff
> 
> diff --git a/daemon/automount.c b/daemon/automount.c
> index f31ec11..3590292 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -725,10 +725,7 @@ static int create_logpri_fifo(struct autofs_point *ap)
>  		goto out_free;
>  	}
>  
> -	if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(fd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(fd);
>  
>  	ap->logpri_fifo = fd;
>  
> @@ -1015,15 +1012,8 @@ static int autofs_init_ap(struct autofs_point *ap)
>  	ap->pipefd = pipefd[0];
>  	ap->kpipefd = pipefd[1];
>  
> -	if ((cl_flags = fcntl(ap->pipefd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(ap->pipefd, F_SETFD, cl_flags);
> -	}
> -
> -	if ((cl_flags = fcntl(ap->kpipefd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(ap->kpipefd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(ap->pipefd);
> +	set_cloexec(ap->kpipefd);
>  
>  	/* Pipe state changes from signal handler to main loop */
>  	if (pipe(ap->state_pipe) < 0) {
> @@ -1034,15 +1024,8 @@ static int autofs_init_ap(struct autofs_point *ap)
>  		return -1;
>  	}
>  
> -	if ((cl_flags = fcntl(ap->state_pipe[0], F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(ap->state_pipe[0], F_SETFD, cl_flags);
> -	}
> -
> -	if ((cl_flags = fcntl(ap->state_pipe[1], F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(ap->state_pipe[1], F_SETFD, cl_flags);
> -	}
> +	set_cloexec(ap->state_pipe[0]);
> +	set_cloexec(ap->state_pipe[1]);
>  
>  	if (create_logpri_fifo(ap) < 0) {
>  		logmsg("could not create FIFO for path %s\n", ap->path);
> diff --git a/daemon/direct.c b/daemon/direct.c
> index 619efce..85735fc 100644
> --- a/daemon/direct.c
> +++ b/daemon/direct.c
> @@ -107,15 +107,9 @@ int do_umount_autofs_direct(struct autofs_point *ap, struct mnt_list *mnts, stru
>  		}
>  		ioctlfd = me->ioctlfd;
>  	} else {
> -		int cl_flags;
> -
>  		ioctlfd = open(me->key, O_RDONLY);
> -		if (ioctlfd != -1) {
> -			if ((cl_flags = fcntl(ioctlfd, F_GETFD, 0)) != -1) {
> -				cl_flags |= FD_CLOEXEC;
> -				fcntl(ioctlfd, F_SETFD, cl_flags);
> -			}
> -		}
> +		if (ioctlfd != -1)
> +			set_cloexec(ioctlfd);
>  	}
>  
> 
> @@ -300,7 +294,7 @@ int do_mount_autofs_direct(struct autofs_point *ap, struct mnt_list *mnts, struc
>  	struct mnt_params *mp;
>  	time_t timeout = ap->exp_timeout;
>  	struct stat st;
> -	int status, ret, ioctlfd, cl_flags;
> +	int status, ret, ioctlfd;
>  	struct list_head list;
>  	const char *map_name;
>  
> @@ -315,13 +309,8 @@ int do_mount_autofs_direct(struct autofs_point *ap, struct mnt_list *mnts, struc
>  
>  			if (ioctlfd == -1) {
>  				ioctlfd = open(me->key, O_RDONLY);
> -				if (ioctlfd != -1) {
> -					cl_flags = fcntl(ioctlfd, F_GETFD, 0);
> -					if (cl_flags != -1) {
> -						cl_flags |= FD_CLOEXEC;
> -						fcntl(ioctlfd, F_SETFD, cl_flags);
> -					}
> -				}
> +				if (ioctlfd != -1)
> +					set_cloexec(ioctlfd);
>  			}
>  
>  			if (ioctlfd < 0) {
> @@ -409,10 +398,7 @@ int do_mount_autofs_direct(struct autofs_point *ap, struct mnt_list *mnts, struc
>  		goto out_umount;
>  	}
>  
> -	if ((cl_flags = fcntl(ioctlfd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(ioctlfd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(ioctlfd);
>  
>  	/* Calculate the timeouts */
>  	ap->exp_runfreq = (timeout + CHECK_RATIO - 1) / CHECK_RATIO;
> @@ -538,7 +524,7 @@ int mount_autofs_direct(struct autofs_point *ap)
>  int umount_autofs_offset(struct autofs_point *ap, struct mapent *me)
>  {
>  	char buf[MAX_ERR_BUF];
> -	int ioctlfd, cl_flags, rv = 1, retries;
> +	int ioctlfd, rv = 1, retries;
>  
>  	if (me->ioctlfd != -1) {
>  		if (is_mounted(_PATH_MOUNTED, me->key, MNTS_REAL)) {
> @@ -557,12 +543,8 @@ int umount_autofs_offset(struct autofs_point *ap, struct mapent *me)
>  		}
>  
>  		ioctlfd = open(me->key, O_RDONLY);
> -		if (ioctlfd != -1) {
> -			if ((cl_flags = fcntl(ioctlfd, F_GETFD, 0)) != -1) {
> -				cl_flags |= FD_CLOEXEC;
> -				fcntl(ioctlfd, F_SETFD, cl_flags);
> -			}
> -		}
> +		if (ioctlfd != -1)
> +			set_cloexec(ioctlfd);
>  	}
>  
>  	if (ioctlfd >= 0) {
> @@ -657,7 +639,7 @@ int mount_autofs_offset(struct autofs_point *ap, struct mapent *me)
>  	struct mnt_params *mp;
>  	time_t timeout = ap->exp_timeout;
>  	struct stat st;
> -	int ioctlfd, cl_flags, status, ret;
> +	int ioctlfd, status, ret;
>  	const char *type, *map_name = NULL;
>  
>  	if (is_mounted(_PROC_MOUNTS, me->key, MNTS_AUTOFS)) {
> @@ -767,10 +749,7 @@ int mount_autofs_offset(struct autofs_point *ap, struct mapent *me)
>  		goto out_umount;
>  	}
>  
> -	if ((cl_flags = fcntl(ioctlfd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(ioctlfd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(ioctlfd);
>  
>  	ioctl(ioctlfd, AUTOFS_IOC_SETTIMEOUT, &timeout);
>  
> @@ -1433,7 +1412,7 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
>  	struct pending_args *mt;
>  	char buf[MAX_ERR_BUF];
>  	int status = 0;
> -	int ioctlfd, cl_flags, state;
> +	int ioctlfd, state;
>  
>  	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
>  
> @@ -1485,10 +1464,7 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
>  		return 1;
>  	}
>  
> -	if ((cl_flags = fcntl(ioctlfd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(ioctlfd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(ioctlfd);
>  
>  	debug(ap->logopt, "token %ld, name %s, request pid %u",
>  		  (unsigned long) pkt->wait_queue_token, me->key, pkt->pid);
> diff --git a/daemon/indirect.c b/daemon/indirect.c
> index f6b93d0..09b0d7c 100644
> --- a/daemon/indirect.c
> +++ b/daemon/indirect.c
> @@ -93,7 +93,7 @@ static int do_mount_autofs_indirect(struct autofs_point *ap)
>  	const char *type, *map_name = NULL;
>  	struct stat st;
>  	struct mnt_list *mnts;
> -	int cl_flags, ret;
> +	int ret;
>  
>  	mnts = get_mnt_list(_PROC_MOUNTS, ap->path, 1);
>  	if (mnts) {
> @@ -155,10 +155,7 @@ static int do_mount_autofs_indirect(struct autofs_point *ap)
>  		goto out_umount;
>  	}
>  
> -	if ((cl_flags = fcntl(ap->ioctlfd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(ap->ioctlfd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(ap->ioctlfd);
>  
>  	ap->exp_runfreq = (timeout + CHECK_RATIO - 1) / CHECK_RATIO;
>  
> diff --git a/include/automount.h b/include/automount.h
> index 133fd32..3cf1b99 100644
> --- a/include/automount.h
> +++ b/include/automount.h
> @@ -17,6 +17,8 @@
>  #include <pthread.h>
>  #include <sched.h>
>  #include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
>  #include "config.h"
>  #include "list.h"
>  
> @@ -524,5 +526,14 @@ int alarm_start_handler(void);
>  int alarm_add(struct autofs_point *ap, time_t seconds);
>  void alarm_delete(struct autofs_point *ap);
>  
> -#endif
> +static inline void set_cloexec(int fd)
> +{
> +	int cl_flags;
> +
> +	if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> +		cl_flags |= FD_CLOEXEC;
> +		fcntl(fd, F_SETFD, cl_flags);
> +	}
> +}
>  
> +#endif
> diff --git a/lib/nss_parse.y b/lib/nss_parse.y
> index 90b7d25..7c14d5e 100644
> --- a/lib/nss_parse.y
> +++ b/lib/nss_parse.y
> @@ -163,7 +163,7 @@ static void parse_close_nsswitch(void *arg)
>  int nsswitch_parse(struct list_head *list)
>  {
>  	FILE *nsswitch;
> -	int fd, cl_flags, status;
> +	int fd, status;
>  
>  	nsswitch = fopen(NSSWITCH_FILE, "r");
>  	if (!nsswitch) {
> @@ -175,10 +175,7 @@ int nsswitch_parse(struct list_head *list)
>  
>  	fd = fileno(nsswitch);
>  
> -	if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(fd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(fd);
>  
>  	parse_mutex_lock();
>  	pthread_cleanup_push(parse_mutex_unlock, NULL);
> diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
> index 5797639..f2c5f80 100644
> --- a/lib/rpc_subs.c
> +++ b/lib/rpc_subs.c
> @@ -59,7 +59,7 @@ inline void dump_core(void);
>   */
>  static CLIENT *create_udp_client(struct conn_info *info)
>  {
> -	int fd, cl_flags, ret, ghn_errno;
> +	int fd, ret, ghn_errno;
>  	CLIENT *client;
>  	struct sockaddr_in laddr, raddr;
>  	struct hostent hp;
> @@ -114,10 +114,7 @@ got_addr:
>  		if (fd < 0)
>  			return NULL;
>  
> -		if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> -			cl_flags |= FD_CLOEXEC;
> -			fcntl(fd, F_SETFD, cl_flags);
> -		}
> +		set_cloexec(fd);
>  
>  		laddr.sin_family = AF_INET;
>  		laddr.sin_port = 0;
> @@ -269,7 +266,7 @@ done:
>   */
>  static CLIENT *create_tcp_client(struct conn_info *info)
>  {
> -	int fd, cl_flags, ghn_errno;
> +	int fd, ghn_errno;
>  	CLIENT *client;
>  	struct sockaddr_in addr;
>  	struct hostent hp;
> @@ -318,10 +315,7 @@ got_addr:
>  		if (fd < 0)
>  			return NULL;
>  
> -		if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> -			cl_flags |= FD_CLOEXEC;
> -			fcntl(fd, F_SETFD, cl_flags);
> -		}
> +		set_cloexec(fd);
>  
>  		ret = connect_nb(fd, &addr, &info->timeout);
>  		if (ret < 0)
> diff --git a/modules/lookup_file.c b/modules/lookup_file.c
> index a77068a..331f543 100644
> --- a/modules/lookup_file.c
> +++ b/modules/lookup_file.c
> @@ -395,7 +395,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
>  	char *ent;
>  	struct stat st;
>  	FILE *f;
> -	int fd, cl_flags;
> +	int fd;
>  	unsigned int path_len, ent_len;
>  	int entry, cur_state;
>  
> @@ -432,10 +432,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
>  
>  	fd = fileno(f);
>  
> -	if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(fd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(fd);
>  
>  	while(1) {
>  		entry = read_one(logopt, f, path, &path_len, ent, &ent_len);
> @@ -640,7 +637,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
>  	char *mapent;
>  	struct stat st;
>  	FILE *f;
> -	int fd, cl_flags;
> +	int fd;
>  	unsigned int k_len, m_len;
>  	int entry;
>  
> @@ -682,10 +679,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
>  
>  	fd = fileno(f);
>  
> -	if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(fd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(fd);
>  
>  	while(1) {
>  		entry = read_one(ap->logopt, f, key, &k_len, mapent, &m_len);
> @@ -773,7 +767,7 @@ static int lookup_one(struct autofs_point *ap,
>  	char mapent[MAPENT_MAX_LEN + 1];
>  	time_t age = time(NULL);
>  	FILE *f;
> -	int fd, cl_flags;
> +	int fd;
>  	unsigned int k_len, m_len;
>  	int entry, ret;
>  
> @@ -792,10 +786,7 @@ static int lookup_one(struct autofs_point *ap,
>  
>  	fd = fileno(f);
>  
> -	if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(fd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(fd);
>  
>  	while(1) {
>  		entry = read_one(ap->logopt, f, mkey, &k_len, mapent, &m_len);
> @@ -886,7 +877,7 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
>  	char mapent[MAPENT_MAX_LEN + 1];
>  	time_t age = time(NULL);
>  	FILE *f;
> -	int fd, cl_flags;
> +	int fd;
>  	unsigned int k_len, m_len;
>  	int entry, ret;
>  
> @@ -905,10 +896,7 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
>  
>  	fd = fileno(f);
>  
> -	if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(fd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(fd);
>  
>  	while(1) {
>  		entry = read_one(ap->logopt, f, mkey, &k_len, mapent, &m_len);
> diff --git a/modules/mount_changer.c b/modules/mount_changer.c
> index 08d9147..148a88e 100644
> --- a/modules/mount_changer.c
> +++ b/modules/mount_changer.c
> @@ -152,7 +152,6 @@ int swapCD(const char *device, const char *slotName)
>  {
>  	int fd;			/* file descriptor for CD-ROM device */
>  	int status;		/* return status for system calls */
> -	int cl_flags;
>  	int slot = -1;
>  	int total_slots_available;
>  
> @@ -166,10 +165,7 @@ int swapCD(const char *device, const char *slotName)
>  		return 1;
>  	}
>  
> -	if ((cl_flags = fcntl(fd, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(fd, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(fd);
>  
>  	/* Check CD player status */
>  	total_slots_available = ioctl(fd, CDROM_CHANGER_NSLOTS);
> diff --git a/modules/replicated.c b/modules/replicated.c
> index 90b2925..17062b5 100644
> --- a/modules/replicated.c
> +++ b/modules/replicated.c
> @@ -102,7 +102,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
>  	char tmp[20], buf[MAX_ERR_BUF], *ptr;
>  	struct ifconf ifc;
>  	struct ifreq *ifr, nmptr;
> -	int sock, cl_flags, ret, i;
> +	int sock, ret, i;
>  	uint32_t mask, ha, ia;
>  
>  	memcpy(tmp, host_addr, addr_len);
> @@ -117,10 +117,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
>  		return PROXIMITY_ERROR;
>  	}
>  
> -	if ((cl_flags = fcntl(sock, F_GETFD, 0)) != -1) {
> -		cl_flags |= FD_CLOEXEC;
> -		fcntl(sock, F_SETFD, cl_flags);
> -	}
> +	set_cloexec(sock);
>  
>  	ifc.ifc_len = sizeof(buf);
>  	ifc.ifc_req = (struct ifreq *) buf;
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
