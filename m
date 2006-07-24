From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: parse_sun.c error
Date: Mon, 24 Jul 2006 16:06:51 -0400
Message-ID: <x49psfun4x0.fsf@segfault.boston.redhat.com>
References: <C4094AFA0A6.00000427bradla@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C4094AFA0A6.00000427bradla@inbox.com> (Brad Arrington's
	message of "Sun, 23 Jul 2006 07:27:25 -0800")
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
To: Brad Arrington <bradla@inbox.com>
Cc: autofs@linux.kernel.org, raven@themaw.net

==> Regarding [autofs] parse_sun.c error; Brad Arrington <bradla@inbox.com> adds:

> diff -ur autofs-4.1.4a/modules/parse_sun.c autofs-4.1.4b/modules/parse_sun.c
> --- autofs-4.1.4a/modules/parse_sun.c   2005-04-05 05:42:42.000000000 -0700
> +++ autofs-4.1.4b/modules/parse_sun.c   2006-07-22 11:55:39.000000000 -0700
> @@ -647,10 +647,6 @@
>         mountpoint = alloca(namelen + 1);
>         sprintf(mountpoint, "%.*s", namelen, name);

> -       what = alloca(loclen + 1);
> -       memcpy(what, loc, loclen);
> -       what[loclen] = '\0';
> -
>         if (!strcmp(fstype, "autofs") && strchr(loc, ':') == NULL) {
>                 char mtype[7];
>                 int mtype_len;
> _______________ cut __________________________

> diff -ur autofs-5.0.1a/modules/parse_sun.c autofs-5.0.1b/modules/parse_sun.c
> --- autofs-5.0.1a/modules/parse_sun.c   2006-07-13 01:11:39.000000000 -0700
> +++ autofs-5.0.1b/modules/parse_sun.c   2006-07-22 13:37:40.000000000 -0700
> @@ -669,9 +669,6 @@
>                 what[loclen + mtype_len] = '\0';
>         } else {
>  */
> -               what = alloca(loclen + 1);
> -               memcpy(what, loc, loclen);
> -               what[loclen] = '\0';
>  /*     } */

>         debug(ap->logopt,

Looks sane to me.

-Jeff
