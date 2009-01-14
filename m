From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Wed, 14 Jan 2009 22:17:56 +0900
Message-ID: <1231939076.3168.53.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231732946.3073.44.camel@zeus.themaw.net>
	<1231736307.3073.68.camel@zeus.themaw.net>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
	<1231813498.3057.12.camel@zeus.themaw.net>
	<1231820126.3057.14.camel@zeus.themaw.net>
	<408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
	<1231823945.3057.20.camel@zeus.themaw.net>
	<408431290901131943t2c678c8ej10c1829c71b5a557@mail.gmail.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
	<408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
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

On Wed, 2009-01-14 at 21:52 +1100, Paul Wankadia wrote:
> On Wed, Jan 14, 2009 at 7:47 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         > It seems that autofs v5 doesn't read an indirect map into
>         the cache
>         > unless ghosting is enabled, so I'm thinking about adding a
>         map option
>         > to force the read. Has the file map reloading logic changed
>         > significantly since autofs v4?
>         
>         
>         It's a bit hard to give a good answer to that as there have
>         been so many
>         changes but, having said that, it shouldn't have changed much
>         except for
>         the obvious one that it tries not to read the entire map
>         unless it has
>         to. Adding the "--ghost" or "browse" option will cause it to
>         read the
>         entire map. Also, the internal default, which is "browse"
>         enabled by
>         default, is overridden by the default installed configuration
>         with
>         BROWSE_MODE="no" so v5 behaves the same as v4.
> 
> Sorry, I meant the logic that reloads the file map if it's been
> modified. I know that autofs v4 checked the mtime, but I can't see
> where autofs v5 does that.

Yeah, I didn't think I got rid of that.

But the check for a mismatch between the cache and a file key lookup
should be sufficient to only cause a read when the map has actually
changed. I guess we could get multiple HUP signals, one following just
after the other has finished, but that would be a system admin error and
you'd probably want to know about that since we can't make a similar
check some other map sources. I probably should get around to removing
the mtime stuff all-together, perhaps you could let me know if things
work as they should (or not) so I can clean (or fix) that up.

Ian
