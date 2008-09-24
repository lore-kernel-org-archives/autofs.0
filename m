From: Ian Kent <raven@themaw.net>
Subject: Re: autofs & system libnss* libraries
Date: Wed, 24 Sep 2008 21:33:45 +0800
Message-ID: <1222263225.1280.66.camel@raven.themaw.net>
References: <48DA0F09.9090602@s3group.cz>
	<1222258619.1280.31.camel@raven.themaw.net>
	<48DA36C8.4040403@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48DA36C8.4040403@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

On Wed, 2008-09-24 at 14:47 +0200, Ondrej Valousek wrote:
> >
> > No!
> >
> > I considered that at the outset of version 5 development and decided
> > against it after working on integrating the outdated code that was
> > included in the nss_ldap distribution. Unless the situation changes
> > significantly then I'm not likely to change my mind on this.
> >   
> Does it mean that the nss_ldap is heavily outdated then?

No, just the autofs stuff they had was quite a bit out of date and I had
to resolve this for "all" autofs map sources not just LDAP. So I took
the easy road.

> > I would have to write the nss code for "all" the possible sources
> > against a an API that is difficult to write for, partly because the
> > interface documentation is lousy. Not to mention that I'd then be at the
> > mercy of nss_ldap changes and bugs, and autofs would depend on a
> > configuration file that it doesn't control.
> >   
> My primary concern was why should we (linux distro maintainers) support
> 2 things essentially doing the same?

Not really such an issue for autofs.

We're only concerned with the "automount:" line in /etc/nsswitch.conf
and map source has always been a large part of autofs map management
anyway. The only bit that isn't something we have to do anyway is to
parse /etc/nsswitch.conf which is a relatively small amount of code.

> I did not mean you specifically. Maintaining the libnss* libraries
> should be (probably) job for someone else - you keep focused on the
> autofs-specific tasks.

Again, a bit of a concern relying on others for a fairly small bit of
functionality. Do you have someone in mind?

> And if you think your nss_ldap is better, why should not it serve other
> purposes (like gathering user info from LDAP repository), too?

That's not really applicable, as I say above, I don't do "nss_ldap" I
just parse /etc/nsswitch.conf, the bulk of the functionality has to be
in autofs anyway, which would essentially be the callback functions if
the glibc nss API was used.

> 
> I mean, from the longer perspective, I believe we should merge these
> things. It is neither elegant nor transparent for normal sysadmins.

Neither is a response like "I don't support that go ... for that" or the
converse "we don't support that go talk to the autofs folks for that".

I just can't see the benefit you see in this, sorry.

Perhaps if there was someone actually interested in working through this
there could be meaningful discussions. I suspect the glibc folks would
be happy to hand of (read "get rid of") the nss code to someone else.

Ian
