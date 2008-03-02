From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
Date: Sat, 01 Mar 2008 18:13:51 -0700
Message-ID: <m1bq5y3p2o.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0802261208400.8490@raven.themaw.net>
	<20080227204546.72e16e8d.akpm@linux-foundation.org>
	<1204179747.3501.21.camel@raven.themaw.net>
	<20080227223734.caab0165.akpm@linux-foundation.org>
	<1204182500.3501.49.camel@raven.themaw.net>
	<20080227232339.af6e904a.akpm@linux-foundation.org>
	<1204185623.3501.84.camel@raven.themaw.net>
	<x494pbtxaup.fsf@segfault.boston.devel.redhat.com>
	<20080228195118.GA16634@sergelap.austin.ibm.com>
	<1204255932.3969.86.camel@raven.themaw.net>
	<20080229160921.GA24296@sergelap.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080229160921.GA24296@sergelap.ibm.com> (Serge E. Hallyn's
	message of "Fri, 29 Feb 2008 10:09:21 -0600")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Ian Kent <raven@themaw.net>, Jeff Moyer <jmoyer@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Pavel Emelyanov <xemul@openvz.org>, "Eric W. Biederman" <ebiederm@xmission.com>

"Serge E. Hallyn" <serue@us.ibm.com> writes:
>
> The way the user namespaces work right now is similar to say the IPC
> namespace - a task belongs to one user, that user belongs to precisely
> one user namespace.
>
> Even in my additional userns patches, I was changing uid to store the
> (uid, userns) so a struct user still belonged to just one user
> namespace.
>
> In contrast, with pid namespaces a task is associated with a 'struct
> pid' which links it to multiple process ids, one in each pid namespace
> to which it belongs.
>
> Perhaps we should be treating user namespaces like pid namespaces?
>
> For autofs this would mean that when autofs wants a uid for some task,
> it would be given the uid in the user namespace which autofs 'knows'.
>
> It would also help me fix the siginfo problems I haven't solved yet -
> rather than having to worry about user namespace lifetimes with siginfos
> (which last a little while but have no clearly defined lifespan) we
> could send the uid in an init user namespace or the uid in the target
> uid namespace, or just a lightweight user struct proxy akin to 'struct
> pid'.
>
> And it also obviates the need for any sort of delegation.
>
> So if I'm user 500 in what I think is the initial user namespace, I can
> create a container with a new user namespace, the init task of which is
> both uid 0 in the child userns, and uid 500 in the higher level,
> automatically giving the container access to any files I own.
>
> Eric, when you get a chance (I know you're overloaded atm) I'd love to
> hear your thoughts on this...

Succinctly.

I think the concept of mapping uids between user namespaces is
fundamental to properly describing and thinking about the semantics of
user namespaces correct.

We don't have to start out anything except handling the case when
no mapping exists, but asking the question how does this uid map
between from one namespace to another is fundamental.

Eric







