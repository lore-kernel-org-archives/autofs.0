From: Ian Kent <raven@themaw.net>
Subject: Re: Returning issues.
Date: Wed, 08 Jun 2011 12:55:02 +0800
Message-ID: <1307508903.3275.52.camel@perseus.themaw.net>
References: <4DEBB650.8030207@bononline.nl>
	<1307424204.3285.52.camel@perseus.themaw.net>
	<4DEDEC32.4070602@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=QZrl8nZVKPS+/x14DEWMcKVLfCU=;
	b=nKd0L7KZ8NBaG3pKryUMewr4dfZO7Seymk8kBCUCSkAL5hobxaWRlLphhpWjHe3fbrKU42vlWTkWpikbLufLqlqrPBzWpT/bqFNLd1MBLt5K6rU7GOWxIUw6TeaRQ3Lnr+PUefv6cTD/LKb92xAQbNxCulMGP4YsY4XyeeeCXTw=
In-Reply-To: <4DEDEC32.4070602@bononline.nl>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org, David Howells <dhowells@redhat.com>

On Tue, 2011-06-07 at 11:15 +0200, Stef Bon wrote:
> On 06/07/2011 07:23 AM, Ian Kent wrote:
> > On Sun, 2011-06-05 at 19:01 +0200, Stef Bon wrote:
> >> hi,
> >>
> >> I see that issues that automounter doing unnecessary mounting like:
> >>
> >> http://linux.kernel.org/pipermail/autofs/2011-May/006568.html
> > I think you misunderstood the report here.
> > Neither of the points below were related to it.
> >
> >> and here
> >>
> >> http://linux.kernel.org/pipermail/autofs/2011-April/006542.html
> >>
> >> some more documentation here would prevent users asking the
> >> same questions.
> >>
> >> This behaviour is mostly caused by:
> >>
> >> A.
> >>
> >> ls is a alias (in de shell) to ls --color=auto
> >>
> >> which will follow targets, and this makes the automounter mount.
> > This mostly isn't a problem these days as most user space utilities
> > behave better with automount these days.
> >
> > We will need to wait and see how the user space utilities behave with
> > the new vfs automount kernel infrastructure and work out what needs to
> > be done as we go.
> 
> I hope you're right. How do apps "know" a directory is a autofs managed 
> mountpoint?
> 
> 
> >> B.
> >>
> >>
> >> extended attributes called by the environment, or an app.
> >>
> >> I see here a sollution is proposed to fix this in coreutils and the acl
> >> package. Hmm, is this right?
> > Yes, this was related to inconsistent use of system calls within the
> > user space utility, an lgetxattr(2) call was being made instead of a
> > getxattr(2) call (inconsistent with respect to previous calls in the
> > same utility code path), which was causing a mount to occur on the
> > follow, as required by the lgetxattr(2) call.
> >
> > So, in this case, it needed to be fixed in the utility.
> 
> You're mixing things here I think. A lgetxattr will normally not follow 
> a symlink,
> as the call getxattr does.
> 
> Isn't it the other way around?
> 
> (compare stat and lstat: lstat looks at the symlink self, stat follows 
> the symlink and takes the target)

Oh ... of course you are right and I think I'll need to re-visit the
report for case B.

Don't forget that we are talking about directories that have follow link
semantics and that is the source of the semantic behavior. Also we are
talking about automount directories themselves not the thing that may be
mounted on top of them. Once mounted upon, the autofs directory should
be followed when looking up a path unless it is in the process of
expiring or has an in progress mount occurring. 

Lets try that again with the test in the kernel and referring to your
problem with stat in the previous mail.

if (!(flags & LOOKUP_FOLLOW) &&
            !(flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY |
                       LOOKUP_OPEN | LOOKUP_CREATE)))
                return -EISDIR;

If we aren't using an l variant (such as stat(2)) LOOKUP_FOLLOW will be
set so this test won't prevent a mount from being attempted. The EISDIR
is a little misleading. It is used internally by the kernel automount
code to say "don't automount just use this directory".

The comment:
        /* We want to mount if someone is trying to open/create a file of any
         * type under the mountpoint, wants to traverse through the mountpoint
         * or wants to open the mounted directory.

snip ...

         * We don't want to mount if someone's just doing a stat and they've
         * set AT_SYMLINK_NOFOLLOW - unless they're stat'ing a directory and
         * appended a '/' to the name.

essentially says, don't mount for l variants of system calls that are
trying to get information unless a "/" is appended to the end of the
path.

That sounds like it is the opposite to what you observed and the
opposite of what used to happen. Previously the autofs module did not
distinguish between LOOKUP_FOLLOW being set or not and would always not
perform a mount. So, once again we have the age old problem of what to
do to prevent mount storms without compromising the semantics of system
calls. But we don't always see the mount storms occurring nowadays so a
lot has changed in user space, which is good. I did miss this during
development though, *sigh*.

Note that LOOKUP_CONTINUE is set if the path component is not the last
component in the path so a mount will always be attempted in that case.

> 
> Anyhow, when a userspace utility does something like that, it's a 
> serious error. Utilities should do exactly what is requested, and never 
> anything else.
> 
> 
> 
> | autofs directories don't have extended attributes.
> 
> You mean only the autofs managed mount points? The contents of the share 
> can have Xattr right?

Sure, yes, autofs must get out of the road once it has a mount on it.

> 
> 
> >> Can't an autofs managed directory have Xattr?? That does not sound right.
> > No, the autofs fs doesn't support extended attributes.
> >
> > Do you really think we need extended attributes?
> > If you do then a patch, which includes some reasoning of why we need
> > them, would be welcomed.
> 
> No, it suprise me only, since the contents of an autofs managed 
> mountpoint can have Xatttr (see above) and I consider the autofs managed 
> mountpoint belonging to the mounted share.
> 
> Maybe simular like the stat call, where the trailing slash makes the 
> difference, a trailing slash to the end of the path when doing 
> getxattr/setxattr is doing a call to the "." dir on the remote share, 
> and without it it's going to the autofs managed dir on the localhost, 
> resulting in a EOPNOTSUPP as expected.
> 
> > >  
> > >  In my construction I'm blocking the xattr calls to autofs managed dirs,
> > >  unless it's already mounted, and I consider this as an ugly hack.
> | How?
> 
> This is possible in the (special) construction I'm working on, fuse-workspace and mount.md5key.

There's a lot of information her, which probably isn't specific to the
issue being discussed so

snip ...

> | Since the autofs fs inode operations do not define a getxattr operation
> | these calls always return -EOPNOTSUPP. So they don't cause a callback to
> | user space. User space should handle the EOPNOTSUPP return since
> | extended attributes may not be available for a file system?
> 
> | OTOH the lgetxattr(2) call requires the kernel follow the mount point
> | (by definition) and so a mount should be attempted and the call made
> | upon the mounted file system if it succeeds.
> 
> |The bottom line is that the kernel has changed quite significantly
> |underneath you, sorry.
> 
> 
> That's not a problem, but what is a problem is the lack of good documentation/announces
> saying this behaviour has changed. I'm saying this in general,not meaning you,
> and staying up to date with every important development and change is a job in it self....

Yeah, but in this case I missed the really major change myself.

> 
> | Although the behavior should be substantially the same it isn't exactly
> |the same and we will need to work out if we need to change anything and
> |what we need to change. Keep in mind that we need to try and adhere to
> |normal system call semantics were we can, if at all possible.
> 
> 
> Mentioning the recent changes, what about the new O_PATH option added to options to open a directory?
> Has this any effect on the behaviour, when for example  opening the mountpoint self.

Don't know, can't see anything relevant in the kernel source.
 
Ian
