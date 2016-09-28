From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Wed, 28 Sep 2016 08:19:13 +0800
Message-ID: <1475021953.3207.21.camel@themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
         <20160914061445.24714.68331.stgit@pluto.themaw.net>
         <20160917201000.omswgttgyzcu7jt6@mguzik>
         <1474248973.3204.14.camel@themaw.net>
         <87oa3iikgf.fsf@x220.int.ebiederm.org>
         <1474411462.22440.2.camel@themaw.net> <1474412413.22440.7.camel@themaw.net>
         <1474507987.12887.5.camel@themaw.net>
         <87k2e4c541.fsf@x220.int.ebiederm.org>
         <1474592141.3345.20.camel@themaw.net>
         <877fa39z1q.fsf@x220.int.ebiederm.org> <1474604774.3083.1.camel@themaw.net>
         <87oa3e8m2v.fsf@x220.int.ebiederm.org> <1474675869.3078.3.camel@themaw.net>
         <878tue8x4s.fsf@x220.int.ebiederm.org> <1474941132.3390.6.camel@themaw.net>
         <871t057ado.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=Ac1XVanCwviikHDy9z79vr68oKo=; b=rpp5mb
        m820MKh0Jw0VHlFqGu1Su2K6Dt5JXJY+RSdp2ImyVUmM5faCMUcBgXsrdB4J0lt0
        S6iSCvC/0f06intrkHRV0DHkYtU91dneddiPkH3EdmNKVg8xe3kPrJ6wgchRrPAU
        3AfsJfg7ivu2J/jVNSKyg334uTLL72DKOC0g4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Ac1XVanCwviikHD
        y9z79vr68oKo=; b=tP2XeRbAKeIpnPq6sy1BgyggLZ2z12iQcgfDEKzJeTZjIbJ
        1hCSbhH7ABAgq7W+H6zgGbYKPLJoYR/auLDFl/0jF6n1AsHMHdYk4kimGtAwe9zT
        atktySVfdPUh83zFBG3aV8duOb0Lqj3cS57pJkD1SZwB6iWI7cTmQbPR16Jk=
In-Reply-To: <871t057ado.fsf@x220.int.ebiederm.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mateusz Guzik <mguzik@redhat.com>, NeilBrown <neilb@suse.com>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Tue, 2016-09-27 at 08:14 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Mon, 2016-09-26 at 11:05 -0500, Eric W. Biederman wrote:
> > > Ian Kent <raven@themaw.net> writes:
> > > 
> > > > On Fri, 2016-09-23 at 14:15 -0500, Eric W. Biederman wrote:
> > > > > Ian Kent <raven@themaw.net> writes:
> > > > > 
> > > > > 2> On Thu, 2016-09-22 at 20:37 -0500, Eric W. Biederman wrote:
> > > > > > > Ian Kent <raven@themaw.net> writes:
> > > > > > > 
> > > > > > > > On Thu, 2016-09-22 at 10:43 -0500, Eric W. Biederman wrote:
> > > > > > > > > Ian Kent <raven@themaw.net> writes:
> > > > > > > > > 
> > > > > > > > > > Eric, Mateusz, I appreciate your spending time on this and
> > > > > > > > > > particularly
> > > > > > > > > > pointing
> > > > > > > > > > out my embarrassingly stupid is_local_mountpoint() usage
> > > > > > > > > > mistake.
> > > > > > > > > > 
> > > > > > > > > > Please accept my apology for the inconvenience.
> > > > > > > > > > 
> > > > > > > > > > If all goes well (in testing) I'll have follow up patches to
> > > > > > > > > > correct
> > > > > > > > > > this
> > > > > > > > > > fairly
> > > > > > > > > > soon.
> > > > > > > > > 
> > > > > > > > > Related question.  Do you happen to know how many mounts per
> > > > > > > > > mount
> > > > > > > > > namespace tend to be used?  It looks like it is going to be
> > > > > > > > > wise
> > > > > > > > > to
> > > > > > > > > put
> > > > > > > > > a configurable limit on that number.  And I would like the
> > > > > > > > > default
> > > > > > > > > to
> > > > > > > > > be
> > > > > > > > > something high enough most people don't care.  I believe
> > > > > > > > > autofs is
> > > > > > > > > likely where people tend to use the most mounts.
> > > > > > 
> > > > > > Yes, I agree, I did want to try and avoid changing the parameters to
> > > > > > ->d_mamange() but passing a struct path pointer might be better in
> > > > > > the
> > > > > > long
> > > > > > run
> > > > > > anyway.
> > > > > 
> > > > > Given that there is exactly one implementation of d_manage in the tree
> > > > > I
> > > > > don't imagine it will be disruptive to change that.
> > > > 
> > > > Yes, but it could be used by external modules.
> > > > 
> > > > And there's also have_submounts().
> > > 
> > > Good point about have_submounts.
> > > 
> > > > I can update that using the existing d_walk() infrastructure or take it
> > > > (mostly)
> > > > into the autofs module and get rid of have_submounts().
> > > > 
> > > > I'll go with the former to start with and see what people think.
> > > 
> > > That will be interesting to so.  It is not clear to me that if d_walk
> > > needs to be updated, and if d_walk doesn't need to be updated I would
> > > be surprised to see it take into autofs.  But I am happy to look at the
> > > end result and see what you come up with.
> > 
> > I didn't mean d_walk() itself, just the have_submounts() function that's
> > used
> > only by autofs these days. That's all I'll be changing.
> > 
> > To take this functionality into the autofs module shouldn't be a big deal as
> > it
> > amounts to a directory traversal with a check at each node.
> > 
> > But I vaguely remember talk of wanting to get rid of have_submounts() and
> > autofs
> > being the only remaining user.
> > 
> > So I mentioned it to try and elicit a comment, ;)
> 
> From my perspective the key detail is that d_walk is private to dcache.c
> 
> That said you want to look at may_umount_tree, or may_umount that
> are already exported from fs/namespace.c, and already used by autofs.
> One of those may already do the job you are trying to do.

Right, I'm aware of them, autofs uses may_umount() when asking if an autofs
mount can be umounted, and it uses may_umount_tree() to check busyness in its
expire.

may_umount_tree() (and may_umount()) won't tell you if there are any mounts
within the directory tree, only that there is an elevated reference count, for
example an open file or working directory etc., ie. busy.

OTOH, have_submounts() will return true as soon as it encounters a
d_mountpoint() dentry in the directory tree which is what's needed where it's
used and why it can return a false positive for the problem case.

I get that a function, say, path_has_submounts() probably shouldn't be placed in
dcache.c and that's another reason to take the traversal into autofs. 

But if there's no word from Al on that I'd prefer to use d_walk() and put it
there.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
