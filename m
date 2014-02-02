From: Ian Kent <raven@themaw.net>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Sun, 02 Feb 2014 11:45:51 +0800
Message-ID: <1391312751.2670.48.camel@perseus.fritz.box>
References: <52E92627.9050801@molgen.mpg.de>
	 <1391223436.2501.39.camel@perseus.fritz.box>
	 <52ECF015.9030707@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Z5a2m0G36DnnA3pgFv836gQinVg=; b=kXvhg57poSd55tnPlllaauE246yu
	IAGBFsXwnR8LWo3+j8Ss5FyGnGswD7bVA2+aTKgVXhvaay8NQa3Jy33/tF7qyoHk
	qU+XQpwkzJuU0WUTo58L2thWz97djNjhtzZCdPZ5AMTlpNbNt02Ok0W12S7vdDee
	s3KUJ+qASntnE0o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Z5a2m0G36DnnA3pgFv836g
	QinVg=; b=DgrFzQ/fTEsJWTdsdiSxqKIRNQSqYFR8Vlk9jVewQi3+FssHfpaiGO
	3K3Qq9NUxXrGdTVDPUL2A4UDfXu3LcuZtS7p/GD2b/koPgSv2wjgR6QlcO4VNqpP
	gdWVmUjZp1Fpeh5Bi1RwKGSMlW5MrtWEEkpo+2zHjYgaPX+t9Ezx0=
In-Reply-To: <52ECF015.9030707@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Sat, 2014-02-01 at 14:01 +0100, Donald Buczek wrote:
> Am 01.02.2014 03:57, schrieb Ian Kent:
> > On Wed, 2014-01-29 at 17:02 +0100, Donald Buczek wrote:
> >> Hello,
> >>
> >> we are trying to switch from amd to autofs. After successfully testing
> > I didn't notice this before, so as an aside from our discussion
> >
> > You were (perhaps are) an amd user.
> >
> > As it happens I'm working on adding an amd map parser to autofs,
> > probably for similar reasons to you needing to switch away from using
> > it. I guess it won't make much difference to you since many people use
> > amd for its cross platform abilities. And, well, there's that bug we're
> > discussing ....
> >
> > But, fyi, let me tell you where it's at.
> >
> > I'm not sure how much of the functionality will end up in autofs quite
> > yet but so far the things that likely won't be available are:
> >
> > - type program mounts
> >    - needed in autofs too.
> >    - but can't be done without significant autofs infrastructure
> >      change (or they would have been done in autofs ages ago).
> >    - would like to add this, probably some time later.
> >
> > - type nfsx mounts
> >    - might (but probably not) get done for the initial commit.
> >    - a bit hard to do within autofs.
> >
> > - type lustre mounts
> >    - would like to do for initial commit but ....
> >
> > - type direct mounts
> >    - I think I understand how these are supposed to work.
> >    - don't work in amd on linux so can't check.
> >    - can't find any references to users of them either.
> >    - a bit difficult to do in autofs.
> >    - undecided as yet, at best will do some time later.
> >
> > - map type passwd
> >    - seems to prescriptive to be useful.
> >    - unlikely to be implemented.
> >
> > - map type ndbm
> >    - may implement later if people use it.
> >    - would need to add to autofs as well for sane implementation.
> >
> > - configuration options not yet implemented
> >    - fully_qualified_hosts
> >    - unmount_on_exit
> >    - browsable_dirs
> >    - probably a couple of others I've missed.
> >    - many of the configuration options aren't used or aren't
> >      sensible within autofs.
> >
> > - man page for amd options
> >    - autofs(5) will need to be updated before initial commit.
> >
> >
> > I've probably missed a few things but this will give you an idea.
> > My plan is to commit initial changes, announce this to try and get some
> > testers and continue to work on it after that. Eventually the amd map
> > changes will be autofs-5.1.0.
> >
> > Any interest in this?
> > Ian
> >
> 
> Well, to be true, we don't need anything of this. Where we have used 
> some of the more complex map features of amd, I consider this a mistake 
> and I'm happy to find  another solution for that. As small and simple as 
> possible is what we would appreciate the most.

Yeah, when I first saw amd maps (quite a long time ago now) my thought
was they were more complex than they need to be and, at the time,
recommended against using amd for that reason. There was also the
potential support headache that could result from using something that
people could bend and twist in hard to understand ways.

> 
> Even with the current autofs code, much of the complexity comes from 
> features, we don't need (though I surly acknowledge that other do): 
> direct maps, nested mountpoints, ldap maps, nis maps... We could even 
> live without multithreading in the daemon. We could live without 
> automatic selection between nfs and local bind mounts (because we build 
> the maps on each node individually after we pushed around the 
> configuration data). We could live without expiration support in kernel 
> and daemon and just try to /bin/umount from our own scripts ourselves. 
> I'm not to happy with uid/gid of the original mount persisting in kernel 
> data structure, perhaps to see the daemon die on getpwuid() in two 
> years, because the original account expired some month ago. For what? 
> For /${uid}/ in the paths? Our goal is to provide a stable, global 
> namespace to our nodes and not a "depends on who asked for it" namespace 
> :-)

Yes, autofs is too complex, I agree.

But, it's been my experience that trying to simplify something mostly
leads to even more complex code which misses the point completely. So
I'll most likely leave it the way it is until I have a reason to change
it.

Other people do use the features though so it's worth spending time to
make them function as best I can.

Your saying that if an automounted mount remains mounted for a long time
the uid/gid in the dentry info struct can become stale and cause
subsequent failures.

I guess that could happen but a stale uid/gid shouldn't cause a mount
failure in AFAICS, except for those whose maps use those settings. In
which case they do need to (and should) be concerned with mounts that
stay mounted for long amounts of time.

Beside the macro usage it's used to trigger dependent mounts in the
mount location path, since the daemon doesn't trigger mounts itself. I
guess the requesting uid/gid isn't really needed for that, I suppose I
could make the spawned mount its own process group leader and that would
be enough but I have the uid/gid.

Sure, something else you don't need but .....

> 
> In our current setting, amd sits as a local nfs-server on the automount 
> directories, so any path resolution of an already mounted subdirectory 
> still goes through RPC serialisation and context switches and a big, 
> buggy user-mode daemon. This is the great performance and stability 
> problem we want to get rid of, so we go for in-kernel autofs. I think, 
> in the latest versions of amd they are working on supporting autofs too, 
> but we had too many bad experience, we don't want to upgrade amd away 
> from our more or less stable version. So, please, autofs/automount, 
> don't become a second amd, stay as small and simple and fast and bugfree 
> as possible. Just my view.

It's way too late for autofs to be small and simple, ;)

In amd autofs support has been present for quite a while.

What is recent is support for sun format maps but I don't expect that
will ever make it into an actual release given the current lack of
activity in the project.

It's too late, the amd parser is nearly ready for initial commit.

In my defense, there's quite good code separation between the amd and
autofs specific parts due to how a parser is added to autofs. Sure, the
map sources (like file, nis, etc.) necessarily need changes for the key
matching logic but that isn't a great deal of code. And the changes to
other parts of the code base are relatively small. I'm not saying there
won't be problems with it initially but I don't think it is as bad as
you think it will be. The implementation itself is much smaller than it
is in amd.

Indeed, the amd parser implementation is, IMHO, much better than the
autofs parser implementation from a design POV and I'm thinking of
re-writing the autofs parser with a similar design.

As I said above I've resisted doing that to date because I've spent so
much time getting it adequately stable and it has been doing it's job
well enough. But I need to add a feature for the amd parser that has
been requested for autofs also and the best way to do it means doing the
re-write (rather than just adding a hard to maintain hack). Not only
that there's a real possibility for simplification of the autofs parser
(in this case anyway) that usually doesn't actually happen during a
re-write. So I have some compelling reasons to do it.

Ian


