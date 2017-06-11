From: Ian Kent <raven@themaw.net>
Subject: Re: Valgrind warnings for `automount`
Date: Mon, 12 Jun 2017 07:42:17 +0800
Message-ID: <1497224537.2543.1.camel@themaw.net>
References: <e60981ac-2b4e-0dab-1333-2bf88160bda2@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=okWxsXyzpoowlTWX9Z
        n0MyVzHPesg0lQoEm23UmfG5Q=; b=Up2FX0/fmD+P25tD2Dk6sJ20CQ467fXYUU
        2Uq5/ITHnt+KDYlgQu4xP1LgMUCziGSQP39PVE1yr4lXYHY7q2osiwxcnpmssVPA
        +5gzm+gNBPErtEE/rzqE3QMaGc+YwEUMlhLbpmTpfQp57ad0Y/FOQUpUJSfNH9nR
        rxhrBsqAe8qsMtO+TDxKsPys3dBtalzffzMZx6QWUry0CoOm9MYSXZwlN86hU5Jy
        A0pwgYp5hLM+t5M5+LOmNjhvMFJBUM38IPMOOavnaELoEPw9xxb6l+L9G7dmz9dT
        Z1CpQH9EmZeFYYp8R3ugx6vFiEYKpcOSt7InkzisfUAzF3mGDD0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=okWxsXyzpoowlTWX9Zn0MyVzHPesg0lQoEm23UmfG5Q=; b=iBB+4G/y
        VDwTt5IpXpbqcEhGpMZtstGm9DIgadoGq+uNBx5BnqJFyu5ZPs9w5pUTkziQc8bI
        I+nnOqo4u6X3OMRVvAk3IyuLxqPyDV9YQouc5dTs/i7oVYICZ7firkO+0h7/iQjm
        Wy8x1hkcvDsZcVaBdjupesJ/hqXJ/1AjqfiboikqXhTyN7fKNlzAGJzqV3TZQi0g
        0zCLxr+G+LIbYyv6huE35Kv4pyCEhS/I3LC9Y9PXvurksbHTaJ/sXvU+io5evLD/
        D7IuP0psGQAq/pKqQl2OKHhtjzBqTf1/9tn4eEVNIwr0nz+ESFBAudQn0mojoXct
        5QhdMCLnchpWjw==
In-Reply-To: <e60981ac-2b4e-0dab-1333-2bf88160bda2@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Paul Menzel <pmenzel@molgen.mpg.de>, autofs@vger.kernel.org
Cc: it+autofs@molgen.mpg.de

On Thu, 2017-06-08 at 15:14 +0200, Paul Menzel wrote:
> Dear autofs folks,
> 
> 
> Valgrind 3.12.0 shows the following when running `automount`.
> 
> ```
> ==63563== Thread 12:
> ==63563== Conditional jump or move depends on uninitialised value(s)
> ==63563==    at 0x4C2E826: rawmemchr (vg_replace_strmem.c:1402)
> ==63563==    by 0x61D3FB6: _nss_files_parse_grent (fgetgrent_r.c:37)
> ==63563==    by 0xB3CA5FA: internal_getent (files-XXX.c:272)
> ==63563==    by 0xB3CA9E0: _nss_files_getgrgid_r (files-grp.c:39)
> ==63563==    by 0x61D393B: getgrgid_r@@GLIBC_2.2.5 (getXXbyYY_r.c:266)
> ==63563==    by 0x131AC3: set_tsd_user_vars (mounts.c:1538)
> ==63563==    by 0x11B652: do_mount_indirect (indirect.c:776)
> ==63563==    by 0x4E3B190: start_thread (pthread_create.c:309)
> ==63563==  Uninitialised value was created by a heap allocation
> ==63563==    at 0x4C27A10: malloc (vg_replace_malloc.c:298)
> ==63563==    by 0x4C299DC: realloc (vg_replace_malloc.c:785)
> ==63563==    by 0x131A4D: set_tsd_user_vars (mounts.c:1530)
> ==63563==    by 0x11B652: do_mount_indirect (indirect.c:776)
> ==63563==    by 0x4E3B190: start_thread (pthread_create.c:309)
> ==63563==
> ==63563== Conditional jump or move depends on uninitialised value(s)
> ==63563==    at 0x4C2A4A5: __GI_strchr (vg_replace_strmem.c:246)
> ==63563==    by 0x61D3DBB: _nss_files_parse_grent (fgetgrent_r.c:37)
> ==63563==    by 0xB3CA5FA: internal_getent (files-XXX.c:272)
> ==63563==    by 0xB3CA9E0: _nss_files_getgrgid_r (files-grp.c:39)
> ==63563==    by 0x61D393B: getgrgid_r@@GLIBC_2.2.5 (getXXbyYY_r.c:266)
> ==63563==    by 0x131AC3: set_tsd_user_vars (mounts.c:1538)
> ==63563==    by 0x11B652: do_mount_indirect (indirect.c:776)
> ==63563==    by 0x4E3B190: start_thread (pthread_create.c:309)
> ==63563==  Uninitialised value was created by a heap allocation
> ==63563==    at 0x4C27A10: malloc (vg_replace_malloc.c:298)
> ==63563==    by 0x4C299DC: realloc (vg_replace_malloc.c:785)
> ==63563==    by 0x131A4D: set_tsd_user_vars (mounts.c:1530)
> ==63563==    by 0x11B652: do_mount_indirect (indirect.c:776)
> ==63563==    by 0x4E3B190: start_thread (pthread_create.c:309)
> ==63563==
> ==63563== Conditional jump or move depends on uninitialised value(s)
> ==63563==    at 0x4C2A49A: __GI_strchr (vg_replace_strmem.c:246)
> ==63563==    by 0x61D3DBB: _nss_files_parse_grent (fgetgrent_r.c:37)
> ==63563==    by 0xB3CA5FA: internal_getent (files-XXX.c:272)
> ==63563==    by 0xB3CA9E0: _nss_files_getgrgid_r (files-grp.c:39)
> ==63563==    by 0x61D393B: getgrgid_r@@GLIBC_2.2.5 (getXXbyYY_r.c:266)
> ==63563==    by 0x131AC3: set_tsd_user_vars (mounts.c:1538)
> ==63563==    by 0x11B652: do_mount_indirect (indirect.c:776)
> ==63563==    by 0x4E3B190: start_thread (pthread_create.c:309)
> ==63563==  Uninitialised value was created by a heap allocation
> ==63563==    at 0x4C27A10: malloc (vg_replace_malloc.c:298)
> ==63563==    by 0x4C299DC: realloc (vg_replace_malloc.c:785)
> ==63563==    by 0x131A4D: set_tsd_user_vars (mounts.c:1530)
> ==63563==    by 0x11B652: do_mount_indirect (indirect.c:776)
> ==63563==    by 0x4E3B190: start_thread (pthread_create.c:309)
> ==63563==
> ```
> 
> The corresponding code looks like below.
> 
> ```
>          gr_tmp = NULL;
>          status = ERANGE;
> #ifdef ENABLE_LIMIT_GETGRGID_SIZE
>          if (!maxgrpbuf)
>                  maxgrpbuf = detached_thread_stack_size * 0.9;
> #endif
> 
>          /* If getting the group name fails go on without it. It's
>           * used to set an environment variable for program maps
>           * which may or may not use it so it isn't critical to
>           * operation.
>           */
> 
>          tmplen = grplen;
>          while (1) {
>                  char *tmp = realloc(gr_tmp, tmplen + 1);
>                  if (!tmp) {
>                          error(logopt, "failed to malloc buffer for 
> getgrgid_r");
>                          goto no_group;
>                  }
>                  gr_tmp = tmp;
>                  pgr = &gr;
>                  ppgr = &pgr;
>                  status = getgrgid_r(gid, pgr, gr_tmp, tmplen, ppgr);
>                  if (status != ERANGE)
>                          break;
>                  tmplen += grplen;
> 
>                  /* Don't tempt glibc to alloca() larger than is (likely)
>                   * available on the stack if limit-getgrgid-size is 
> enabled.
>                   */
>                  if (!maxgrpbuf || (tmplen < maxgrpbuf))
>                          continue;
> 
>                  /* Add a message so we know this happened */
>                  debug(logopt, "group buffer allocation would be too 
> large");
>                  break;
>          }
> ```
> 
> Unfortunately, I don’t spot the problem. Do you see it?

I've looked at that area quite a bit recently and looking again I don't see what
it's talking about either.

Puzzling.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
