From: Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH 1/3] Add dir map-type.
Date: Fri, 11 Feb 2011 05:27:43 +0900 (JST)
Message-ID: <20110211.052743.503074989287605879.yamato@redhat.com>
References: <20110114.233641.626657481279092833.yamato@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20110114.233641.626657481279092833.yamato@redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

No comment?

I've got one comment privately: use a suffix instead of prefix "auto." 
to filter included files. I'm reflected the comment in my local source
tree. Before posting it to this list, I'd like to get more feedbacks.

Masatake YAMATO

> `dir' map-type is for including files under a directory into master
> map.
> `file' map-type can be used for including a file with + notation like:
> 
>        +/etc/auto.mine
> 
> in auto.master. However, for specifying a new file to be included you
> have to edit auto.master file. Editing is also needed when you want to
> remove the included file. When you have to do this with your shell
> script you may use sed or awk.
> 
> `dir' map-type permits you adding new master map entries with cp
> command and removing the entries with rm command. `dir' map-type is
> inspired from /etc/httpd/conf.d and /etc/modprobe.d.
> 
> `dir' map-type can be used for included files under a directory
> (e.g. /etc/auto.master.d) with + notation like:
> 
>       +dir:/etc/auto.master.d
> 
> in auto.master. With this notation /etc/auto.master.d/auto.* are
> included.  With the name of the file you can control whether a file
> under the directory is included or not: the file which name starts
> with "auto." is included.
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  daemon/lookup.c      |    3 +-
>  modules/Makefile     |    6 +-
>  modules/lookup_dir.c |  208 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 213 insertions(+), 4 deletions(-)
>  create mode 100644 modules/lookup_dir.c
> 
> diff --git a/daemon/lookup.c b/daemon/lookup.c
> index a9a1f4d..a932f5b 100644
> --- a/daemon/lookup.c
> +++ b/daemon/lookup.c
> @@ -176,7 +176,8 @@ int lookup_nss_read_master(struct master *master, time_t age)
>  			    !strncmp(name, "nis:", 4) ||
>  			    !strncmp(name, "nisplus:", 8) ||
>  			    !strncmp(name, "ldap:", 5) ||
> -			    !strncmp(name, "ldaps:", 6)) {
> +			    !strncmp(name, "ldaps:", 6) ||
> +			    !strncmp(name, "dir:", 4)) {
>  				strncpy(source, name, tmp - name);
>  
>  				/*
> diff --git a/modules/Makefile b/modules/Makefile
> index 9ad3915..96768b1 100644
> --- a/modules/Makefile
> +++ b/modules/Makefile
> @@ -5,14 +5,14 @@
>  -include ../Makefile.conf
>  include ../Makefile.rules
>  
> -SRCS :=	lookup_yp.c  lookup_file.c  lookup_program.c  lookup_userhome.c \
> -	lookup_multi.c lookup_hosts.c \
> +SRCS :=	lookup_yp.c  lookup_file.c lookup_program.c  lookup_userhome.c \
> +	lookup_multi.c lookup_hosts.c lookup_dir.c \
>  	parse_sun.c    \
>  	mount_generic.c  mount_nfs.c  mount_afs.c  mount_autofs.c \
>  	mount_changer.c  mount_bind.c
>  
>  MODS :=	lookup_yp.so lookup_file.so lookup_program.so lookup_userhome.so \
> -	lookup_multi.so lookup_hosts.so \
> +	lookup_multi.so lookup_hosts.so lookup_dir.so \
>  	parse_sun.so \
>  	mount_generic.so mount_nfs.so mount_afs.so mount_autofs.so \
>  	mount_changer.so mount_bind.so
> diff --git a/modules/lookup_dir.c b/modules/lookup_dir.c
> new file mode 100644
> index 0000000..e8563d3
> --- /dev/null
> +++ b/modules/lookup_dir.c
> @@ -0,0 +1,208 @@
> +/* ----------------------------------------------------------------------- *
> + *   
> + *  lookup_dir.c - module for including master files in a directory. 
> + *
> + * Copyright 2011 Red Hat, Inc. All rights reserved.
> + * Copyright 2011 Masatake YAMATO <yamato@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
> + * USA; either version 2 of the License, or (at your option) any later
> + * version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * ----------------------------------------------------------------------- */
> +
> +#include <stdio.h>
> +#include <malloc.h>
> +#include <pwd.h>
> +#include <string.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <dirent.h>
> +
> +
> +#define MODULE_LOOKUP
> +#include "automount.h"
> +#include "nsswitch.h"
> +
> +#define MODPREFIX "lookup(dir): "
> +
> +#define MAX_INCLUDE_DEPTH	16
> +
> +struct lookup_context {
> +  const char *mapname;
> +}; 
> +
> +int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
> +
> +
> +int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **context)
> +{
> +	struct lookup_context *ctxt;
> +	char buf[MAX_ERR_BUF];
> +	struct stat st;
> +
> +	*context = NULL;
> +	ctxt = malloc(sizeof(struct lookup_context));
> +	if (!ctxt) {
> +		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +		logerr(MODPREFIX "malloc: %s", estr);
> +		return 1;
> +	}
> +
> +	if (argc < 1) {
> +		free(ctxt);
> +		logerr(MODPREFIX "No map name");
> +		return 1;
> +	}
> +
> +	ctxt->mapname = argv[0];
> +
> +	if (ctxt->mapname[0] != '/') {
> +		free(ctxt);
> +		logmsg(MODPREFIX
> +		     "dir map %s is not an absolute pathname", argv[0]);
> +		return 1;
> +	}
> +
> +	if (access(ctxt->mapname, R_OK)) {
> +		free(ctxt);
> +		warn(LOGOPT_NONE, MODPREFIX
> +		     "dir map %s missing or not readable", argv[0]);
> +		return 1;
> +	}
> +
> +	if (stat(ctxt->mapname, &st)) {
> +		free(ctxt);
> +		warn(LOGOPT_NONE, MODPREFIX
> +		     "dir map %s, could not stat", argv[0]);
> +		return 1;
> +	}
> +
> +	if ( (!S_ISDIR(st.st_mode)) && (!S_ISLNK(st.st_mode)) ) {
> +		free(ctxt);
> +		warn(LOGOPT_NONE, MODPREFIX
> +		     "dir map %s, is not a directory", argv[0]);
> +	}
> +
> +	*context = ctxt;	
> +	return 0;
> +}
> +
> +static int include_file(struct master *master, time_t age, struct lookup_context* ctxt, struct dirent *e)
> +{
> +	unsigned int logopt = master->logopt;
> +	char included_path[PATH_MAX + 1];
> +	int included_path_len;
> +	char *save_name;
> +	int status;
> +
> +	if (strncmp(e->d_name, "auto.", 5) != 0)
> +		return NSS_STATUS_NOTFOUND;
> +	if (!(e->d_type == DT_REG || e->d_type == DT_LNK))
> +		return NSS_STATUS_NOTFOUND;
> +
> +	included_path_len = snprintf(included_path, 
> +				     PATH_MAX + 1, 
> +				     "%s/%s",
> +				     ctxt->mapname,
> +				     e->d_name);
> +	if (included_path_len > PATH_MAX)
> +		return NSS_STATUS_NOTFOUND;
> +	
> +	save_name = master->name;
> +	master->name = included_path;
> +	
> +	master->depth++;
> +	debug(logopt, MODPREFIX "include: %s", master->name);
> +	status = lookup_nss_read_master(master, age);
> +	if (!status) {
> +		warn(logopt,
> +		     MODPREFIX
> +		     "failed to read included master map %s",
> +		     master->name);
> +	}
> +	master->depth--;
> +	
> +	master->name = save_name;
> +	return NSS_STATUS_SUCCESS;
> +}
> +
> +int lookup_read_master(struct master *master, time_t age, void *context)
> +{
> +	struct lookup_context *ctxt = (struct lookup_context *) context;
> +	unsigned int logopt = master->logopt;
> +	DIR *dirp;
> +	char buf[MAX_ERR_BUF];
> +
> +
> +	if (master->depth > MAX_INCLUDE_DEPTH) {
> +		error(logopt, MODPREFIX
> +		      "maximum include depth exceeded %s", master->name);
> +		return NSS_STATUS_UNAVAIL;
> +	}
> +
> +	debug(logopt, MODPREFIX "opendir: %s", ctxt->mapname);
> +	dirp = opendir(ctxt->mapname);
> +	if (!dirp) {
> +		error(logopt,
> +		      MODPREFIX "could not open master map dir %s",
> +		      ctxt->mapname);
> +		return NSS_STATUS_UNAVAIL;
> +	}
> +
> +
> +	errno = 0;
> +	while (1) {
> +		struct dirent *e;
> +
> +
> +		if ( (e = readdir(dirp)) ) {
> +		        debug(logopt, MODPREFIX "readdir entry: %s", e->d_name);
> +			include_file(master, age, ctxt, e);
> +		}
> +		else if (errno) {
> +			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +			error(logopt,
> +			      MODPREFIX "readdir %s: %s",
> +			      ctxt->mapname,
> +			      estr);
> +			break;
> +		}
> +		else
> +			break;
> +	}
> +	closedir(dirp);
> +
> +	
> +	return NSS_STATUS_SUCCESS;
> +}
> +
> +int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
> +{
> +	ap->entry->current = NULL;
> +	master_source_current_signal(ap->entry);
> +	return NSS_STATUS_UNKNOWN;
> +}
> +
> +int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *context)
> +{
> +	ap->entry->current = NULL;
> +	master_source_current_signal(ap->entry);
> +	return NSS_STATUS_UNKNOWN;
> +}
> +
> +int lookup_done(void *context)
> +{
> +	struct lookup_context *ctxt = (struct lookup_context *) context;
> +	
> +	free(ctxt);
> +	return 0;
> +}
> -- 
> 1.7.3.4
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
