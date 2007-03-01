From: Ian Kent <raven@themaw.net>
Subject: Re: module development
Date: Thu, 01 Mar 2007 21:21:43 +0900
Message-ID: <1172751703.3377.14.camel@raven.themaw.net>
References: <45E4AC36.3060707@cesca.es>
	<1172628050.3461.0.camel@raven.themaw.net> <45E592E9.7040104@cesca.es>
	<1172735288.3377.7.camel@raven.themaw.net> <45E6B73F.6030906@cesca.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45E6B73F.6030906@cesca.es>
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
To: Jordi Prats <jprats@cesca.es>
Cc: autofs@linux.kernel.org

On Thu, 2007-03-01 at 12:21 +0100, Jordi Prats wrote:
> Hi,
> Ok, No problem! Here it is with the only changes of my proposal.

The approach is good.

But there's something not quite right which I can't quite put my finger
on. I'll have a closer look on the weekend.

btw, this is something that a couple of people have asked for which I
haven't got to it yet.

Thanks
Ian

> 
> Jordi
> 
> Ian Kent wrote:
> > On Wed, 2007-02-28 at 15:34 +0100, Jordi Prats wrote:
> >   
> >> Hi all,
> >> I have modified autofs's source code to create an entry point for the 
> >> umount operation. Here I attach a patch for autofs-4.1.4
> >>
> >> This patch will allow to create a custom umount operation. In my case I 
> >> need to perform an operation before mounting the fs and after. So, I 
> >> think this could help others.
> >>
> >> What I need to do to contribute this code?
> >>     
> >
> > Sorry, you've got a bit of work to do on that patch.
> >
> > When you make a patch please make the diff from a clean source tree.
> > The reason for this is that the diff should contain only the changes
> > that you're proposing so the possibility of mistakes getting through is
> > minimized. As it is this patch contains a more unrelated stuff than the
> > changes for the proposal itself. I can't really follow it well enough to
> > know what you're trying to do.
> >
> > Ian
> >
> >
> >
> >   
> 
> 
> plain text document attachment (patch-umount)
> diff -Naur autofs-4.1.4/daemon/automount.c autofs-modificat/daemon/automount.c
> --- autofs-4.1.4/daemon/automount.c	2005-03-06 10:43:55.000000000 +0100
> +++ autofs-modificat/daemon/automount.c	2007-02-28 11:55:00.000000000 +0100
> @@ -139,31 +139,7 @@
>  
>  static int umount_ent(const char *root, const char *name, const char *type)
>  {
> -	char path_buf[PATH_MAX];
> -	struct stat st;
> -	int sav_errno;
> -	int is_smbfs = (strcmp(type, "smbfs") == 0);
> -	int status;
> -	int rv = 0;
> -
> -	sprintf(path_buf, "%s/%s", root, name);
> -	status =  lstat(path_buf, &st);
> -	sav_errno = errno;
> -
> -	/* EIO appears to correspond to an smb mount that has gone away */
> -	if (!status ||
> -	    (is_smbfs && (sav_errno == EIO || sav_errno == EBADSLT))) {
> -		int umount_ok = 0;
> -
> -		if (!status && (S_ISDIR(st.st_mode) && (st.st_dev != ap.dev)))
> -			umount_ok = 1;
> -
> -		if (umount_ok || is_smbfs) {
> -			rv = spawnll(LOG_DEBUG, 
> -				    PATH_UMOUNT, PATH_UMOUNT, path_buf, NULL);
> -		}
> -	}
> -	return rv;
> +  return do_umount(root, name, type);
>  }
>  
>  /* Like ftw, except fn gets called twice: before a directory is
> diff -Naur autofs-4.1.4/daemon/Makefile autofs-modificat/daemon/Makefile
> --- autofs-4.1.4/daemon/Makefile	2004-04-03 09:14:33.000000000 +0200
> +++ autofs-modificat/daemon/Makefile	2007-02-28 11:03:47.000000000 +0100
> @@ -6,8 +6,8 @@
>  -include ../Makefile.conf
>  include ../Makefile.rules
>  
> -SRCS = automount.c spawn.c module.c mount.c
> -OBJS = automount.o spawn.o module.o mount.o
> +SRCS = automount.c spawn.c module.c mount.c umount.c
> +OBJS = automount.o spawn.o module.o mount.o umount.o
>  
>  version := $(shell cat ../.version)
>  
> diff -Naur autofs-4.1.4/daemon/module.c autofs-modificat/daemon/module.c
> --- autofs-4.1.4/daemon/module.c	2004-01-29 17:01:22.000000000 +0100
> +++ autofs-modificat/daemon/module.c	2007-02-28 13:27:28.000000000 +0100
> @@ -240,6 +240,75 @@
>  	return mod;
>  }
>  
> +
> +struct mount_mod *open_umount(const char *name, const char *err_prefix)
> +{
> +	struct mount_mod *mod;
> +	char *fnbuf;
> +	size_t size_name;
> +	size_t size_fnbuf;
> +	void *dh;
> +	int *ver;
> +	
> +	size_name = _strlen(name, PATH_MAX + 1);
> +	if (!size_name)
> +		return NULL;
> +
> +	mod = malloc(sizeof(struct mount_mod));
> +	if (!mod) {
> +		if (err_prefix)
> +			crit("%s%m", err_prefix);
> +		return NULL;
> +	}
> +
> +	size_fnbuf = size_name + strlen(AUTOFS_LIB_DIR) + 13;
> +	fnbuf = alloca(size_fnbuf);
> +	if (!fnbuf) {
> +		free(mod);
> +		if (err_prefix)
> +			crit("%s%m", err_prefix);
> +		return NULL;
> +	}
> +	snprintf(fnbuf, size_fnbuf, "%s/umount_%s.so", AUTOFS_LIB_DIR, name);
> +	
> +	if (!(dh = dlopen(fnbuf, RTLD_NOW))) {
> +		if (err_prefix)
> +			crit("%scannot open umount module %s (%s)",
> +			       err_prefix, name, dlerror());
> +		free(mod);
> +		return NULL;
> +	}
> +
> +	if (!(ver = (int *) dlsym(dh, "mount_version"))
> +	    || *ver != AUTOFS_MOUNT_VERSION) {
> +		if (err_prefix)
> +			crit("%smount module %s version mismatch",
> +			     err_prefix, name);
> +		dlclose(dh);
> +		free(mod);
> +		return NULL;
> +	}
> +
> +	if (!(mod->mount_init = (mount_init_t) dlsym(dh, "mount_init")) ||
> +	    !(mod->mount_umount = (mount_umount_t) dlsym(dh, "mount_umount")) ||
> +	    !(mod->mount_done = (mount_done_t) dlsym(dh, "mount_done"))) {
> +		if (err_prefix)
> +			crit("%smount module %s corrupt", err_prefix, name);
> +		dlclose(dh);
> +		free(mod);
> +		return NULL;
> +	}
> +
> +	if (mod->mount_init(&mod->context)) {
> +		dlclose(dh);
> +		free(mod);
> +		return NULL;
> +	}
> +	mod->dlhandle = dh;
> +	return mod;
> +}
> +
> +
>  int close_mount(struct mount_mod *mod)
>  {
>  	int rv = mod->mount_done(mod->context);
> diff -Naur autofs-4.1.4/daemon/umount.c autofs-modificat/daemon/umount.c
> --- autofs-4.1.4/daemon/umount.c	1970-01-01 01:00:00.000000000 +0100
> +++ autofs-modificat/daemon/umount.c	2007-02-28 15:05:30.000000000 +0100
> @@ -0,0 +1,63 @@
> +/* ----------------------------------------------------------------------- *
> + *   
> + *   umount.c - Abstract umount code used by modules for an unexpected
> + *            filesystem type
> + *
> + *   Copyright 2007 Jordi Prats - CESCA - All Rights Reserved
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
> + *   USA; either version 2 of the License, or (at your option) any later
> + *   version.
> + *   
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + *
> + * ----------------------------------------------------------------------- */
> +
> +#include <syslog.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "automount.h"
> +
> +/* These filesystems are known not to work with the "generic" module */
> +static char *not_generic[] = { "ext3lvm",
> +			       NULL
> +};
> +
> +// (const char *root, const char *name, int name_len,
> +// const char *what, const char *fstype, const char *options)
> +
> +int do_umount(const char *root, const char *name, const char *type)
> +{
> +	struct mount_mod *mod;
> +	const char *modstr;
> +	char **ngp;
> +	int rv;
> +		
> +	mod = open_umount(modstr = type, NULL);
> +	if (!mod) {
> +		for (ngp = not_generic; *ngp; ngp++) {
> +			if (!strcmp(type, *ngp))
> +				break;
> +		}
> +		if (!*ngp)
> +			mod = open_umount(modstr = "generic", NULL);
> +		if (!mod) {
> +			error("cannot find umount method for filesystem %s",
> +			       type);
> +			return -1;
> +		}
> +	}
> +
> +	debug("do_umount root %s name type %s",
> +		  root, name, type);
> +
> +	rv = mod->mount_umount(root, name, strlen(name), type, mod->context);
> +	close_mount(mod);
> +
> +	return rv;
> +}
> diff -Naur autofs-4.1.4/include/automount.h autofs-modificat/include/automount.h
> --- autofs-4.1.4/include/automount.h	2005-01-26 14:03:02.000000000 +0100
> +++ autofs-modificat/include/automount.h	2007-02-28 11:54:07.000000000 +0100
> @@ -130,6 +130,9 @@
>  int signal_children(int sig);
>  int do_mount(const char *root, const char *name, int name_len,
>  	     const char *what, const char *fstype, const char *options);
> +
> +int do_umount(const char *root, const char *name, const char *type);
> +
>  int mkdir_path(const char *path, mode_t mode);
>  int rmdir_path(const char *path);
>  
> @@ -200,22 +203,32 @@
>  int mount_init(void **context);
>  int mount_mount(const char *root, const char *name, int name_len,
>  		const char *what, const char *fstype, const char *options, void *context);
> +
> +int mount_umount(const char *root, const char *name, int name_len,
> +		 const char *fstype, void *context);
> +
>  int mount_done(void *context);
>  #endif
>  typedef int (*mount_init_t) (void **);
>  typedef int (*mount_mount_t) (const char *, const char *, int, const char *, const char *,
>  			      const char *, void *);
> +
> +typedef int (*mount_umount_t) (const char *, const char *, int, const char *,
> +			      void *);
> +
>  typedef int (*mount_done_t) (void *);
>  
>  struct mount_mod {
>  	mount_init_t mount_init;
>  	mount_mount_t mount_mount;
> +	mount_umount_t mount_umount;
>  	mount_done_t mount_done;
>  	void *dlhandle;
>  	void *context;
>  };
>  
>  struct mount_mod *open_mount(const char *name, const char *err_prefix);
> +struct mount_mod *open_umount(const char *name, const char *err_prefix);
>  int close_mount(struct mount_mod *);
>  
>  /* mapent cache definition */
> diff -Naur autofs-4.1.4/include/config.h autofs-modificat/include/config.h
> --- autofs-4.1.4/include/config.h	1970-01-01 01:00:00.000000000 +0100
> +++ autofs-modificat/include/config.h	2007-02-28 10:46:55.000000000 +0100
> @@ -0,0 +1,28 @@
> +/* include/config.h.  Generated by configure.  */
> +#ident "$Id: config.h.in,v 1.4 2004/02/03 15:23:21 raven Exp $"
> +/* -*- c -*-
> + *
> + * config.h.in: Pattern file for autofs to be filled in by configure
> + *
> + */
> +
> +/* Program paths */
> +#define HAVE_MOUNT 1
> +#define PATH_MOUNT "/bin/mount"
> +
> +#define HAVE_UMOUNT 1
> +#define PATH_UMOUNT "/bin/umount"
> +
> +/* #undef HAVE_SMBMOUNT */
> +/* #undef PATH_SMBMOUNT */
> +
> +#define HAVE_E2FSCK 1
> +#define PATH_E2FSCK "/sbin/fsck.ext2"
> +
> +#define HAVE_E3FSCK 1
> +#define PATH_E3FSCK "/sbin/fsck.ext3"
> +
> +/* Define this option if mount(8) supports the -s (sloppy) option */
> +#define HAVE_SLOPPY_MOUNT 1
> +
> +/* #undef ENABLE_EXT_ENV */
> diff -Naur autofs-4.1.4/modules/Makefile autofs-modificat/modules/Makefile
> --- autofs-4.1.4/modules/Makefile	2004-08-29 14:46:23.000000000 +0200
> +++ autofs-modificat/modules/Makefile	2007-02-28 13:03:49.000000000 +0100
> @@ -10,13 +10,13 @@
>  	lookup_multi.c \
>  	parse_sun.c    \
>  	mount_generic.c  mount_nfs.c  mount_afs.c  mount_autofs.c \
> -	mount_changer.c  mount_bind.c
> +	mount_changer.c  mount_bind.c umount_generic.c
>  
>  MODS :=	lookup_yp.so lookup_file.so lookup_program.so lookup_userhome.so \
>  	lookup_multi.so \
>  	parse_sun.so \
>  	mount_generic.so mount_nfs.so mount_afs.so mount_autofs.so \
> -	mount_changer.so mount_bind.so
> +	mount_changer.so mount_bind.so umount_generic.so
>  
>  ifeq ($(EXT2FS), 1)
>    SRCS += mount_ext2.c
> diff -Naur autofs-4.1.4/modules/umount_generic.c autofs-modificat/modules/umount_generic.c
> --- autofs-4.1.4/modules/umount_generic.c	1970-01-01 01:00:00.000000000 +0100
> +++ autofs-modificat/modules/umount_generic.c	2007-02-28 15:06:18.000000000 +0100
> @@ -0,0 +1,73 @@
> +/* ----------------------------------------------------------------------- *
> + *   
> + *  umount_generic.c - module for Linux automountd to umount filesystems
> + *                    for which no special magic is required
> + *
> + *   Copyright 2007 Jordi Prats - CESCA - All Rights Reserved
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
> + *   USA; either version 2 of the License, or (at your option) any later
> + *   version; incorporated herein by reference.
> + *
> + * ----------------------------------------------------------------------- */
> +
> +#include <stdio.h>
> +#include <malloc.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <syslog.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
> +#define MODULE_MOUNT
> +#include "automount.h"
> +
> +#define MODPREFIX "umount(generic): "
> +
> +int mount_version = AUTOFS_MOUNT_VERSION;	/* Required by protocol */
> +
> +int mount_init(void **context)
> +{
> +	return 0;
> +}
> +
> +int mount_umount(const char *root, const char *name, int name_len,
> +		 const char *fstype, void *context)
> +{
> +	char path_buf[PATH_MAX];
> +	struct stat st;
> +	int sav_errno;
> +	int is_smbfs = (strcmp(fstype, "smbfs") == 0);
> +	int status;
> +	int rv = 0;
> +	
> +	sprintf(path_buf, "%s/%s", root, name);
> +	status =  lstat(path_buf, &st);
> +	sav_errno = errno;
> +
> +	/* EIO appears to correspond to an smb mount that has gone away */
> +	if (!status ||
> +	    (is_smbfs && (sav_errno == EIO || sav_errno == EBADSLT))) {
> +		int umount_ok = 0;
> +
> +		if (!status && (S_ISDIR(st.st_mode) && (st.st_dev != ap.dev)))
> +			umount_ok = 1;
> +
> +		if (umount_ok || is_smbfs) {
> +			rv = spawnll(LOG_DEBUG, 
> +				    PATH_UMOUNT, PATH_UMOUNT, path_buf, NULL);
> +		}
> +	}
> +	return rv;
> +}
> +
> +int mount_done(void *context)
> +{
> +	return 0;
> +}
