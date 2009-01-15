From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands
	of	entries
Date: Fri, 16 Jan 2009 00:16:13 +0900
Message-ID: <1232032573.3100.53.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
	<1231813498.3057.12.camel@zeus.themaw.net>
	<1231820126.3057.14.camel@zeus.themaw.net>
	<408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
	<1231823945.3057.20.camel@zeus.themaw.net>
	<408431290901131943t2c678c8ej10c1829c71b5a557@mail.gmail.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
	<408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
	<1231939076.3168.53.camel@zeus.themaw.net>
	<408431290901140620k11a8cf7evb667895a59c7e204@mail.gmail.com>
	<1231983710.3100.38.camel@zeus.themaw.net>
	<x49vdsgvcdk.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49vdsgvcdk.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org, Paul Wankadia <junyer@google.com>

On Thu, 2009-01-15 at 10:04 -0500, Jeff Moyer wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > But onto the problem.
> >
> > It should be fairly straight forward to start using the map mtime again.
> > The time stamp on cache entries that have been added will be later than
> > the mtime if the file map hasn't changed so we can use that. But we also
> > need to prevent re-reading the map from the beginning as we populate the
> > cache. I was thinking that I could add each entry read during a lookup
> > to the cache so that they would be found on subsequent lookups (as long
> > as the mtime is earlier than the time stamp). Additionally, I could keep
> > track of the file position so I don't read entries already read. It
> > likely won't be quite as simple in the end but we really need to do
> > something to for really large maps.
> >
> > Any other thoughts?
> 
> Sure, just read the whole map.  Even large maps aren't that big.  What
> are we talking, 10k?  50k?  You're better off reading the whole thing in
> at once.

Yeah, that would be best. I'll have a think about how to detect when to
do that. Maybe we can rip out that convoluted change detection logic for
file maps, after all they should be fairly simple to deal with.

Ian
