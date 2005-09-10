From: Ian Kent <raven@themaw.net>
Subject: Re: lookup_nisplus module
Date: Sat, 10 Sep 2005 11:11:18 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0509101101330.2073@donald.themaw.net>
References: <11593.136.182.2.222.1126298006.squirrel@thepisanis.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <11593.136.182.2.222.1126298006.squirrel@thepisanis.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ryan Pisani <autofs@thepisanis.com>
Cc: autofs@linux.kernel.org

On Fri, 9 Sep 2005, Ryan Pisani wrote:

> Hello -
> I'm new to this list so please forgive me if I do anything out of the
> norm. For the last year and a half I've been applying a fix the
> lookup_nisplus.so source to allow for non-standard nisplus maps. The map
> extension org_dir is hardcoded in the current and previous source as to
> always assume .org_dir to any preceding map name like passwd, hosts, etc.
> It occurred to me this morning that maybe I could get this changed in the
> native autofs package so that I don't have to keep patching rpms for every
> release of RHEL we use at work. Anyhow, I contacted Redhat and they stated
> this would be the proper place to suggest a patch. Below you'll find the
> patch to C source based on autofs 4.1.3. I know nisplus is probably rarely
> used on Linux in most environments, but unfortunately I'm stuck with it in
> mine. Please let me know if there is any way to have this patch verified,
> and possibly included in future releases.
> 

Hi Ryan,

Thanks for your patch.

I have to admit my maintenance of the nisplus code has been poor.
I've received a few patches over the last couple of years and haven't been 
able to merge any.

Priorities, not knowing nisplus myself and the complete lack of the 
ability to test has been the main problem. At one point I tried to 
work with someone on this but it rapidly became too hard.

atm the priority is getting the basic functionality expected of an 
automounter sorted out. Linux autofs just hasn't got it and I've been 
responsible for it for quite a while now so it's way past time to get it 
done.

So all I can say is I've filed it and hope to get to it.

Sorry, for now at least.

Ian

> regards,
> 
> Ryan Pisani
> 
> 
> 
> #autofs-nisplus.patch
> --- autofs-4.1.3.orig/modules/lookup_nisplus.c  2004-01-29
> 10:01:22.000000000 -0
> 600
> +++ autofs-4.1.3/modules/lookup_nisplus.c       2005-06-16
> 13:48:26.000000000 -0
> 500
> @@ -74,14 +74,14 @@
> 
>         debug(MODPREFIX "looking up %s", name);
> 
> -       sprintf(tablename, "[key=%s],%s.org_dir.%s", name, ctxt->mapname,
> +       sprintf(tablename, "[key=%s],%s.%s", name, ctxt->mapname,
>                 ctxt->domainname);
> 
>         result = nis_list(tablename, FOLLOW_PATH | FOLLOW_LINKS, NULL, NULL);
>         if (result->status != NIS_SUCCESS && result->status !=
> NIS_S_SUCCESS) {
>                 /* Try to get the "*" entry if there is one - note that we
> *don'
> t*
>                    modify "name" so & -> the name we used, not "*" */
> -               sprintf(tablename, "[key=*],%s.org_dir.%s", ctxt->mapname,
> +               sprintf(tablename, "[key=*],%s.%s", ctxt->mapname,
>                         ctxt->domainname);
>                 result = nis_list(tablename, FOLLOW_PATH | FOLLOW_LINKS,
> NULL, N
> ULL);
>         }
> 
> ###END PATCH
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
