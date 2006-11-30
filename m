From: Peter Staubach <staubach@redhat.com>
Subject: Re: [autofs4 patch] Clean up the ldap code
Date: Thu, 30 Nov 2006 14:33:52 -0500
Message-ID: <456F3220.9050504@redhat.com>
References: <x497ixcvnf7.fsf@segfault.boston.devel.redhat.com>	<456F2B0C.8050300@redhat.com>
	<x49r6vku4r9.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49r6vku4r9.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

Jeff Moyer wrote:
> ==> On Thu, 30 Nov 2006 14:03:40 -0500, Peter Staubach <staubach@redhat.com> said:
>
> Peter> Jeff Moyer wrote:
> Peter> > Hi, Ian, list,
> Peter> >
> Peter> > Here's a patch that significantly cleans up the lookup_ldap module.
> Peter> > In the beginning of time (for this module), there was only one
> Peter> > supported LDAP schema.  And for a time, it was good.  After a while,
> Peter> > however, standards emerged -- standards which conflicted with our
> Peter> > original LDAP schema vision.  With each new standard, our LDAP module
> Peter> > gained ugly if clauses and added return values.  The parsing of such
> Peter> > things made the module less and less pleasing to the eye.  And, users
> Peter> > began to complain of many queries to their poor little LDAP servers.
> Peter> >
> Peter> > In a heroic effort to bring peace back to the world of autofs and
> Peter> > LDAP, I present this patch.  Among its merits, I submit the following:
> Peter> >
> Peter> > o It will perform less binds to the LDAP server
> Peter> > o It will remember which LDAP schema worked, and continue to query
> Peter> >   only that schema (instead of trying all three every time)
> Peter> >
>
> Peter> It is good to remember the working schema, but what happens if that
> Peter> schema stops working?  It seems like it would be good to forget and
> Peter> then try all three again until another working schema is discovered.
>
> I'm not sure that a sane administrator would switch schemas in
> production; that seems like a fairly unlikely situation.  Also, how
> would you differentiate between a failed lookup for a key that doesn't
> exist and a failed lookup due to a schema change?  I think that we
> have to enforce at least some sane constraints, here.
>
>   

I guess that I was naively hoping that there was some way to
differentiate between these two failed lookups.

If not, then I agree completely.  I think that assuming a sane
administrator may be a bit of a dangerous assumption, but what
the heck, gotta start someplace, I guess.  :-)

> It's worth noting, too, that this assumes that a site only uses one
> schema.  Mixing and matching will certainly break this code.
>
> In the RHEL variant of this patch, I actually implemented a
> command-line option to keep the old behaviour.  It would do so by
> simply never setting the saved schema, thus incurring a lookup using
> all three for each request.  I could post that portion of the patch if
> people are interested in it.

I think that the changes look good and well worth some experience
in the real world.

    Thanx...

       ps
