From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Fix usage of uninitialized pointer
Date: Thu, 01 Jun 2017 17:13:33 +0800
Message-ID: <1496308413.2580.6.camel@themaw.net>
References: <1496151337-21367-1-git-send-email-buczek@molgen.mpg.de>
         <1496190434.3804.1.camel@themaw.net> <1496194664.3804.3.camel@themaw.net>
         <e4e26a3f-7bda-1c6a-18e6-af05c2490d6d@molgen.mpg.de>
         <350fd28e-8e61-24b0-f2e4-38a4476c8108@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=1X23q+ay4Y8Tn1t2XZ
        4hHg8XmNMtEIZny1+o1XANQQA=; b=imeXiZqfQARb7A9isNatPYSy5Jj7xADJtg
        xNEuSYk5vMyXlPIbOWw7+1lSwk+8DPTeH1q/6zDTUJzH9AkR8kftTL/pbb6UdG9A
        N3MWOw1YtLowkCiWiQzRcmN4uIoBDlK79Qj2JwacQYWTvJyoidWIxNxeb2qqiuop
        VMg+mnBKiC1Yqgm8pX5tR8pBA0U/gHsXF7TytIVBJU26067S79FSXHiIXdgaf6TW
        TEzYvl4XH5StvqWQ9Dl9LLkV7LZUAS2WtJ7JaAIU3exK7aU6+S75nv7IDZCdDGNW
        hVM2fzTXcWCR2s/lZwmzQbQfuZqRQa3lhhF2jKbIZci7nLYPpxDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=1X23q+ay4Y8Tn1t2XZ4hHg8XmNMtEIZny1+o1XANQQA=; b=EmftroL8
        70bX8W1+cZHMz8MQaPqpq7DvDHzO+WNdv6KjspLuLYdhiB34OwD0E+3kNYmmRcbB
        mksVN3nHiZZzlrO7Gl0LGZ6+HUO+pXvd3iPcnOfGgX0SpV4ffMNjcrPdayvDx+Wo
        88NPiqdfAwraprG0oC+r6Xr6ucDSiBtjamZFj7TQtWdeIJpbOwXHY0iB7lKc9upo
        1enXDFVqX3fhkMdCo1KBy+FqWQEGbNZSBY+6FrkHgSkLMHiUWennODxlHiyzVL1H
        F+lEMiT/kK1FWKkar6ZMJvRFZxnVTGHDPe1TMG3e6wwgILjIv/+EM4Hnsx/ZVYeg
        khH+s6Tael6iAw==
In-Reply-To: <350fd28e-8e61-24b0-f2e4-38a4476c8108@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs@vger.kernel.org

On Wed, 2017-05-31 at 22:28 +0200, Donald Buczek wrote:
> On 31.05.2017 16:22, Donald Buczek wrote:
> > On 05/31/17 03:37, Ian Kent wrote:
> > > On Wed, 2017-05-31 at 08:27 +0800, Ian Kent wrote:
> > > > On Tue, 2017-05-30 at 15:35 +0200, Donald Buczek wrote:
> > > > > In the error path after a getgrgid_r failure (e.g. when a unnamed gid
> > > > > was used), the pointer tsv->group was left unitialized. Still the tsv
> > > > > was given to pthread_setspecific(key_thread_stdenv_vars,...) and the
> > > > > consumers used and freed the uninitialized pointer.
> > > > 
> > > > Umm ... ok, I'll check ... good catch.
> > > 
> > > I think this bug will warrant another release.
> > > 
> > > > >      2017-05-29T18:16:11+02:00 rofl automount[14749]: attempting to
> > > > > mount
> > > > > entry
> > > > > /package/twiki
> > > > >      2017-05-29T18:16:11+02:00 rofl automount[14749]:
> > > > > set_tsd_user_vars:
> > > > > failed
> > > > > to get group info from getgrgid_r
> > > > >      2017-05-29T18:16:11+02:00 rofl automount[14749]: mounted
> > > > > /package/twiki
> > > > >      2017-05-29T18:16:11+02:00 rofl systemd[1]: automount.service:
> > > > > main
> > > > > process
> > > > > exited, code=dumped, status=6
> > > > >      2017-05-29T18:16:12+02:00 rofl systemd[1]: automount.service
> > > > > holdoff
> > > > > time
> > > > > over, scheduling restart.
> > > > >      2017-05-29T18:16:12+02:00 rofl systemd[1]: Unit automount.service
> > > > > entered
> > > > > failed state.
> > > > >      2017-05-29T18:16:12+02:00 rofl automount[17936]: Starting
> > > > > automounter
> > > > > version 5.1.3, master map auto.master
> > > > > 
> > > > >      [May29 18:16] traps: automount[18234] general protection
> > > > > ip:7f8b025c324a
> > > > > sp:7f8b0049a508 error:0 in libc-2.19.so[7f8b02541000+1a2000]
> > > > > 
> > > > > Handle the error by not calling pthread_setspecific. Clean up
> > > > > and return instead.
> > > > > ---
> > > > >   lib/mounts.c | 21 ++++++++++++---------
> > > > >   1 file changed, 12 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/lib/mounts.c b/lib/mounts.c
> > > > > index ce6a60a..fe1a6cd 100644
> > > > > --- a/lib/mounts.c
> > > > > +++ b/lib/mounts.c
> > > > > @@ -1552,28 +1552,31 @@ void set_tsd_user_vars(unsigned int logopt,
> > > > > uid_t
> > > > > uid,
> > > > > gid_t gid)
> > > > >       }
> > > > >     no_group:
> > > > > -    if (status || !pgr)
> > > > > +    if (status || !pgr) {
> > > > >           error(logopt, "failed to get group info from getgrgid_r");
> > > > > -    else {
> > > > 
> > > > Extra braces, I leave these out (when I can) on single statement clauses
> > > > deliberately and always try to put the single statement as the first
> > > > branch of
> > > > the if.
> > > > 
> > > > > +        goto free_gr_tmp;
> > > > > +    } else {
> > > > >           tsv->group = strdup(gr.gr_name);
> > > > > -        if (!tsv->group)
> > > > > +        if (!tsv->group) {
> > > > >               error(logopt, "failed to malloc buffer for group");
> > > > > +            goto free_gr_tmp;
> > > > > +        }
> > > > >       }
> > > > >   -    if (gr_tmp)
> > > > > -        free(gr_tmp);
> > > > > -
> > > > >       status = pthread_setspecific(key_thread_stdenv_vars, tsv);
> > > > >       if (status) {
> > > > >           error(logopt, "failed to set stdenv thread var");
> > > > >           goto free_tsv_group;
> > > > >       }
> > > > > -
> > > > > +    if (gr_tmp)
> > > > > +        free(gr_tmp);
> > > > 
> > > > But this doesn't do what I intended.
> > > > 
> > > > What I want to do is set the thread specific standard variables even
> > > > if the
> > > > group name can't be obtained.
> > > > 
> > > > It looks like I've made an assumption elsewhere that if the tsd is
> > > > set then
> > > > all
> > > > the variables have valid values, I'd rather fix that than do this.
> > > 
> > > I would prefer to do this instead.
> > > 
> > > Could you check this resolves the problem you have seen please.
> > 
> > Sorry, the patch doesn't apply, because it is line wrapped and contains
> > utf8 unicode non breaking space characters. Can I pull it?
> 
> 
> Never mind, edited it in by hand.
> 
> I can confirm, that the bug is fixed.
> 
> Test procedure:
> 
> run
> 
>      valgrind --leak-check=full daemon/automount -f -v
> 
> in one shell. Run
> 
>      perl -e '$(=65533;$)=65533;system("ls /project/SOME_AUTOMOUNT_PATH")'
> 
> in another.
> 
> Result from master (release_5.1.3) are several valgrind warnings and 
> death by segv:
> 
>      set_tsd_user_vars: failed to get group info from getgrgid_r
>      ==18686== Use of uninitialised value of size 8
>      ==18686==    at 0x4C2AAF2: strlen (vg_replace_strmem.c:454)
>      ==18686==    by 0x619FF8D: strdup (strdup.c:41)
>      [...]
>      ==18686== Invalid read of size 1
>      ==18686==    at 0x4C2AAF2: strlen (vg_replace_strmem.c:454)
>      ==18686==    by 0x619FF8D: strdup (strdup.c:41)
>      ==18686==    by 0x13A18D: macro_addvar (macros.c:305)
>      [...]
>      ==18686==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
>      ==18686== Process terminating with default action of signal 11 
> (SIGSEGV): dumping core
>      ==18686==  Access not within mapped region at address 0x0
>      ==18686==    at 0x4C2AAF2: strlen (vg_replace_strmem.c:454)
>      ==18686==    by 0x619FF8D: strdup (strdup.c:41)
>      ==18686==    by 0x13A18D: macro_addvar (macros.c:305)
>      ==18686==    by 0x12F1E4: do_macro_addvar (mounts.c:368)
> 
> Result with you patch on top: No errors (aside from expected 
> "set_tsd_user_vars: failed to get group info from getgrgid_r") and a 
> mounted directory.
> 
> Didn't try to expand the variables in a map, though.
> 
> Thumbs up from my side.

Thanks for doing this.

> 
>    Donald
> 
> 
> 
> > 
> > Donald
> > 
> > 
> > > 
> > > autofs-5.1.3 - fix unset tsd group name handling
> > > 
> > > From: Ian Kent <raven@themaw.net>
> > > 
> > > Commit 1a64a6bbc5 changed set_tsd_user_vars() to set the thread specific
> > > values even if the group name could not be obtained.
> > > 
> > > But the structure holding the values was not initialized on allocation
> > > so the group field might not be NULL when no group name is available.
> > > 
> > > Also the macro addition and removal functions didn't handle setting a
> > > macro name with a NULL value.
> > > 
> > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > Reported-by: Donald Buczek <buczek@molgen.mpg.de>
> > > ---
> > >   lib/macros.c |   27 +++++++++++++--------------
> > >   lib/mounts.c |    1 +
> > >   2 files changed, 14 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/lib/macros.c b/lib/macros.c
> > > index ff9ba89..30dbcdb 100644
> > > --- a/lib/macros.c
> > > +++ b/lib/macros.c
> > > @@ -281,19 +281,21 @@ macro_addvar(struct substvar *table, const char
> > > *str, int
> > > len, const char *value
> > >       }
> > >         if (lv) {
> > > -        char *this = malloc(strlen(value) + 1);
> > > -        if (!this) {
> > > -            lv = table;
> > > -            goto done;
> > > +        char *this = NULL;
> > > +
> > > +        if (value) {
> > > +            this = malloc(strlen(value) + 1);
> > > +            if (this)
> > > +                strcpy(this, value);
> > >           }
> > > -        strcpy(this, value);
> > > -        free(lv->val);
> > > +        if (lv->val)
> > > +            free(lv->val);
> > >           lv->val = this;
> > >           if (lv != table)
> > >               lv = table;
> > >       } else {
> > >           struct substvar *new;
> > > -        char *def, *val;
> > > +        char *def, *val = NULL;
> > >             def = strdup(str);
> > >           if (!def) {
> > > @@ -302,18 +304,15 @@ macro_addvar(struct substvar *table, const char
> > > *str, int
> > > len, const char *value
> > >           }
> > >           def[len] = '\0';
> > >   -        val = strdup(value);
> > > -        if (!val) {
> > > -            lv = table;
> > > -            free(def);
> > > -            goto done;
> > > -        }
> > > +        if (value)
> > > +            val = strdup(value);
> > >             new = malloc(sizeof(struct substvar));
> > >           if (!new) {
> > >               lv = table;
> > >               free(def);
> > > -            free(val);
> > > +            if (val)
> > > +                free(val);
> > >               goto done;
> > >           }
> > >           new->def = def;
> > > diff --git a/lib/mounts.c b/lib/mounts.c
> > > index ce6a60a..0b38bd8 100644
> > > --- a/lib/mounts.c
> > > +++ b/lib/mounts.c
> > > @@ -1463,6 +1463,7 @@ void set_tsd_user_vars(unsigned int logopt,
> > > uid_t uid,
> > > gid_t gid)
> > >           error(logopt, "failed alloc tsv storage");
> > >           return;
> > >       }
> > > +    memset(tsv, 0, sizeof(struct thread_stdenv_vars));
> > >         tsv->uid = uid;
> > >       tsv->gid = gid;
> > 
> > 
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
