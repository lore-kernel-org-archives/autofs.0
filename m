From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Fri, 16 Jan 2009 14:05:39 +0900
Message-ID: <1232082339.3166.72.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231983710.3100.38.camel@zeus.themaw.net>
	<x49vdsgvcdk.fsf@segfault.boston.devel.redhat.com>
	<1232032573.3100.53.camel@zeus.themaw.net>
	<408431290901151233q33699529r6119788c998866ed@mail.gmail.com>
	<x49d4eouwt6.fsf@segfault.boston.devel.redhat.com>
	<408431290901151257i70400351yc3ab9360136c8e9c@mail.gmail.com>
	<1232065653.3166.19.camel@zeus.themaw.net>
	<1232066406.3166.28.camel@zeus.themaw.net>
	<1232070195.3166.36.camel@zeus.themaw.net>
	<408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
	<1232079714.3166.56.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232079714.3166.56.camel@zeus.themaw.net>
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
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Fri, 2009-01-16 at 13:22 +0900, Ian Kent wrote:
> >         
> >         diff --git a/daemon/lookup.c b/daemon/lookup.c
> >         index 741d846..b954045 100644
> >         --- a/daemon/lookup.c
> >         +++ b/daemon/lookup.c
> >         @@ -283,10 +283,13 @@ static int do_read_map(struct
> >         autofs_point *ap, struct map_source *map, time_t a
> >                 * for the fail cases to function correctly and to
> >         cache the
> >                 * lookup handle.
> >                 *
> >         -        * We always need to whole map for direct mounts in
> >         order to
> >         -        * mount the triggers.
> >         +        * We always need to read the whole map for direct
> >         mounts in
> >         +        * order to mount the triggers. We also want to read
> >         the whole
> >         +        * map if it's a file map to avoid potentially lengthy
> >         linear
> >         +        * file scanning.
> >                 */
> >         -       if (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type !=
> >         LKP_DIRECT)
> >         +       if (strcmp(map->type, "file") ||
> > 
> > I suspect that you want && instead.
> 
> Yeah, I think that isn't quite right but I also think that && won't fix
> it. I'll think on that one again.

On second thoughts, I think you were right the first time, && it is.

But the real question is whether we are willing to put up with the
overhead of file scan lookups while we wait for the a map read to
complete. That probably won't happen all that often so I'm thinking
maybe it's ok.

Ian
