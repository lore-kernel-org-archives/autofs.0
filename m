From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
Date: Fri, 29 Feb 2008 11:42:05 -0600
Message-ID: <20080229174205.GB24296@sergelap.ibm.com>
References: <1204179747.3501.21.camel@raven.themaw.net> <20080227223734.caab0165.akpm@linux-foundation.org> <1204182500.3501.49.camel@raven.themaw.net> <20080227232339.af6e904a.akpm@linux-foundation.org> <1204185623.3501.84.camel@raven.themaw.net> <x494pbtxaup.fsf@segfault.boston.devel.redhat.com> <20080228195118.GA16634@sergelap.austin.ibm.com> <1204255932.3969.86.camel@raven.themaw.net> <20080229160921.GA24296@sergelap.ibm.com> <47C830B9.20505@openvz.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47C830B9.20505@openvz.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Emelyanov <xemul@openvz.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Ian Kent <raven@themaw.net>, Jeff Moyer <jmoyer@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>

Quoting Pavel Emelyanov (xemul@openvz.org):
> > The way the user namespaces work right now is similar to say the IPC
> > namespace - a task belongs to one user, that user belongs to precisely
> > one user namespace.
> > 
> > Even in my additional userns patches, I was changing uid to store the
> > (uid, userns) so a struct user still belonged to just one user
> > namespace.
> > 
> > In contrast, with pid namespaces a task is associated with a 'struct
> > pid' which links it to multiple process ids, one in each pid namespace
> > to which it belongs.
> > 
> > Perhaps we should be treating user namespaces like pid namespaces?
> 
> I'm afraid, that I'm just starting a new thread of discussion in a
> wrong place, but I can't refrain from asking "what for?"

For the reasons I listed there :)

> > So if I'm user 500 in what I think is the initial user namespace, I can
> > create a container with a new user namespace, the init task of which is
> > both uid 0 in the child userns, and uid 500 in the higher level,
> > automatically giving the container access to any files I own.
> 
> So do you mean that I can become a root, by calling clone()?

You can become root in the new container.  Your capabilities are
meaningful only to targets (users, files) which exist in the user
namespace in which you are root.  It becomes more precise than the
CAP_NS_OVERRIDE approach in my last patchset.

> Thanks,
> Pavel
