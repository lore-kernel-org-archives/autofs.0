From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: Valgrind warnings for `automount`
Date: Mon, 12 Jun 2017 16:20:45 +0200
Message-ID: <b253d607-7714-d5b5-31fc-f5b2533ef877@molgen.mpg.de>
References: <e60981ac-2b4e-0dab-1333-2bf88160bda2@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <e60981ac-2b4e-0dab-1333-2bf88160bda2@molgen.mpg.de>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: Paul Menzel <pmenzel@molgen.mpg.de>, autofs@vger.kernel.org
Cc: it+autofs@molgen.mpg.de

On 06/08/17 15:14, Paul Menzel wrote:
> Dear autofs folks,
>
>
> Valgrind 3.12.0 shows the following when running `automount`.
>
> ```
> =3D=3D63563=3D=3D Thread 12:
> =3D=3D63563=3D=3D Conditional jump or move depends on uninitialised value=
(s)
> =3D=3D63563=3D=3D    at 0x4C2E826: rawmemchr (vg_replace_strmem.c:1402)
> =3D=3D63563=3D=3D    by 0x61D3FB6: _nss_files_parse_grent (fgetgrent_r.c:=
37)
> =3D=3D63563=3D=3D    by 0xB3CA5FA: internal_getent (files-XXX.c:272)
> =3D=3D63563=3D=3D    by 0xB3CA9E0: _nss_files_getgrgid_r (files-grp.c:39)
> =3D=3D63563=3D=3D    by 0x61D393B: getgrgid_r@@GLIBC_2.2.5 (getXXbyYY_r.c=
:266)
> =3D=3D63563=3D=3D    by 0x131AC3: set_tsd_user_vars (mounts.c:1538)
> =3D=3D63563=3D=3D    by 0x11B652: do_mount_indirect (indirect.c:776)
> =3D=3D63563=3D=3D    by 0x4E3B190: start_thread (pthread_create.c:309)
> =3D=3D63563=3D=3D  Uninitialised value was created by a heap allocation
> =3D=3D63563=3D=3D    at 0x4C27A10: malloc (vg_replace_malloc.c:298)
> =3D=3D63563=3D=3D    by 0x4C299DC: realloc (vg_replace_malloc.c:785)
> =3D=3D63563=3D=3D    by 0x131A4D: set_tsd_user_vars (mounts.c:1530)
> =3D=3D63563=3D=3D    by 0x11B652: do_mount_indirect (indirect.c:776)
> =3D=3D63563=3D=3D    by 0x4E3B190: start_thread (pthread_create.c:309)
> =3D=3D63563=3D=3D
> =3D=3D63563=3D=3D Conditional jump or move depends on uninitialised value=
(s)
> =3D=3D63563=3D=3D    at 0x4C2A4A5: __GI_strchr (vg_replace_strmem.c:246)
> =3D=3D63563=3D=3D    by 0x61D3DBB: _nss_files_parse_grent (fgetgrent_r.c:=
37)
> =3D=3D63563=3D=3D    by 0xB3CA5FA: internal_getent (files-XXX.c:272)
> =3D=3D63563=3D=3D    by 0xB3CA9E0: _nss_files_getgrgid_r (files-grp.c:39)
> =3D=3D63563=3D=3D    by 0x61D393B: getgrgid_r@@GLIBC_2.2.5 (getXXbyYY_r.c=
:266)
> =3D=3D63563=3D=3D    by 0x131AC3: set_tsd_user_vars (mounts.c:1538)
> =3D=3D63563=3D=3D    by 0x11B652: do_mount_indirect (indirect.c:776)
> =3D=3D63563=3D=3D    by 0x4E3B190: start_thread (pthread_create.c:309)
> =3D=3D63563=3D=3D  Uninitialised value was created by a heap allocation
> =3D=3D63563=3D=3D    at 0x4C27A10: malloc (vg_replace_malloc.c:298)
> =3D=3D63563=3D=3D    by 0x4C299DC: realloc (vg_replace_malloc.c:785)
> =3D=3D63563=3D=3D    by 0x131A4D: set_tsd_user_vars (mounts.c:1530)
> =3D=3D63563=3D=3D    by 0x11B652: do_mount_indirect (indirect.c:776)
> =3D=3D63563=3D=3D    by 0x4E3B190: start_thread (pthread_create.c:309)
> =3D=3D63563=3D=3D
> =3D=3D63563=3D=3D Conditional jump or move depends on uninitialised value=
(s)
> =3D=3D63563=3D=3D    at 0x4C2A49A: __GI_strchr (vg_replace_strmem.c:246)
> =3D=3D63563=3D=3D    by 0x61D3DBB: _nss_files_parse_grent (fgetgrent_r.c:=
37)
> =3D=3D63563=3D=3D    by 0xB3CA5FA: internal_getent (files-XXX.c:272)
> =3D=3D63563=3D=3D    by 0xB3CA9E0: _nss_files_getgrgid_r (files-grp.c:39)
> =3D=3D63563=3D=3D    by 0x61D393B: getgrgid_r@@GLIBC_2.2.5 (getXXbyYY_r.c=
:266)
> =3D=3D63563=3D=3D    by 0x131AC3: set_tsd_user_vars (mounts.c:1538)
> =3D=3D63563=3D=3D    by 0x11B652: do_mount_indirect (indirect.c:776)
> =3D=3D63563=3D=3D    by 0x4E3B190: start_thread (pthread_create.c:309)
> =3D=3D63563=3D=3D  Uninitialised value was created by a heap allocation
> =3D=3D63563=3D=3D    at 0x4C27A10: malloc (vg_replace_malloc.c:298)
> =3D=3D63563=3D=3D    by 0x4C299DC: realloc (vg_replace_malloc.c:785)
> =3D=3D63563=3D=3D    by 0x131A4D: set_tsd_user_vars (mounts.c:1530)
> =3D=3D63563=3D=3D    by 0x11B652: do_mount_indirect (indirect.c:776)
> =3D=3D63563=3D=3D    by 0x4E3B190: start_thread (pthread_create.c:309)
> =3D=3D63563=3D=3D
> ```
>
> The corresponding code looks like below.
>
> ```
>         gr_tmp =3D NULL;
>         status =3D ERANGE;
> #ifdef ENABLE_LIMIT_GETGRGID_SIZE
>         if (!maxgrpbuf)
>                 maxgrpbuf =3D detached_thread_stack_size * 0.9;
> #endif
>
>         /* If getting the group name fails go on without it. It's
>          * used to set an environment variable for program maps
>          * which may or may not use it so it isn't critical to
>          * operation.
>          */
>
>         tmplen =3D grplen;
>         while (1) {
>                 char *tmp =3D realloc(gr_tmp, tmplen + 1);
>                 if (!tmp) {
>                         error(logopt, "failed to malloc buffer for=20
> getgrgid_r");
>                         goto no_group;
>                 }
>                 gr_tmp =3D tmp;
>                 pgr =3D &gr;
>                 ppgr =3D &pgr;
>                 status =3D getgrgid_r(gid, pgr, gr_tmp, tmplen, ppgr);
>                 if (status !=3D ERANGE)
>                         break;
>                 tmplen +=3D grplen;
>
>                 /* Don't tempt glibc to alloca() larger than is (likely)
>                  * available on the stack if limit-getgrgid-size is=20
> enabled.
>                  */
>                 if (!maxgrpbuf || (tmplen < maxgrpbuf))
>                         continue;
>
>                 /* Add a message so we know this happened */
>                 debug(logopt, "group buffer allocation would be too=20
> large");
>                 break;
>         }
> ```
>
> Unfortunately, I don=E2=80=99t spot the problem. Do you see it?
>
>
> Kind regards,
>
> Paul
This is a bug in glibc 2.19, which is fixed in glibc 2.20.

With glibc-2.19 plus commit

https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;f=3Dnss/nss_files/file=
s-XXX.c;h=3Dac60763eac3d43b7234dd21286ad3ec3f17957fc

the warning is gone. Although I expect

https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;f=3Dnss/nss_files/file=
s-XXX.c;h=3Dd7b00f98106a0f1e3d753b135eeb97dfdf6e2e74

which is included in glibc-2.19, to be part of the solution, too.

Donald

--=20
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
