From: Ian Kent <raven@themaw.net>
Subject: Re: Returning issues.
Date: Tue, 07 Jun 2011 13:23:24 +0800
Message-ID: <1307424204.3285.52.camel@perseus.themaw.net>
References: <4DEBB650.8030207@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=/AHWNgLS3x7QZLNmrXPG0TX1LHQ=;
	b=FcF/5VkyLrYveiAVs9B+OvhqyxbB7dWlx9H1UblO2xfhHhXG+rmm9G6C4m9UQkxmU5yECCQ6K0+rKMGx3+ws+O+hok2YcZqwwoTGGVZgK62sbJDKd5JL835XWlOUt3sKUi7ebih+vPo3/72xo8L+oBByuu4EATX2QxqJKGjxf78=
In-Reply-To: <4DEBB650.8030207@bononline.nl>
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
Cc: autofs@linux.kernel.org

On Sun, 2011-06-05 at 19:01 +0200, Stef Bon wrote:
> hi,
> 
> I see that issues that automounter doing unnecessary mounting like:
> 
> http://linux.kernel.org/pipermail/autofs/2011-May/006568.html

I think you misunderstood the report here.
Neither of the points below were related to it.

> 
> and here
> 
> http://linux.kernel.org/pipermail/autofs/2011-April/006542.html
> 
> some more documentation here would prevent users asking the
> same questions.
> 
> This behaviour is mostly caused by:
> 
> A.
> 
> ls is a alias (in de shell) to ls --color=auto
> 
> which will follow targets, and this makes the automounter mount.

This mostly isn't a problem these days as most user space utilities
behave better with automount these days.

We will need to wait and see how the user space utilities behave with
the new vfs automount kernel infrastructure and work out what needs to
be done as we go.

> 
> B.
> 
> 
> extended attributes called by the environment, or an app.
> 
> I see here a sollution is proposed to fix this in coreutils and the acl 
> package. Hmm, is this right?

Yes, this was related to inconsistent use of system calls within the
user space utility, an lgetxattr(2) call was being made instead of a
getxattr(2) call (inconsistent with respect to previous calls in the
same utility code path), which was causing a mount to occur on the
follow, as required by the lgetxattr(2) call.

So, in this case, it needed to be fixed in the utility.

We may see more of these over the coming months, we will need to wait
and see and work out what we need to do on a case by case basis.

> 
> If an app wants to get the xattr of an autofs managed directory, what is 
> the sollution proposed here then?

autofs directories don't have extended attributes.

> Can't an autofs managed directory have Xattr?? That does not sound right.

No, the autofs fs doesn't support extended attributes.

Do you really think we need extended attributes?
If you do then a patch, which includes some reasoning of why we need
them, would be welcomed.

> 
> In my construction I'm blocking the xattr calls to autofs managed dirs, 
> unless it's already mounted, and I consider this as an ugly hack.

How? 

Since the autofs fs inode operations do not define a getxattr operation
these calls always return -EOPNOTSUPP. So they don't cause a callback to
user space. User space should handle the EOPNOTSUPP return since
extended attributes may not be available for a file system?

OTOH the lgetxattr(2) call requires the kernel follow the mount point
(by definition) and so a mount should be attempted and the call made
upon the mounted file system if it succeeds.

The bottom line is that the kernel has changed quite significantly
underneath you, sorry.

Although the behavior should be substantially the same it isn't exactly
the same and we will need to work out if we need to change anything and
what we need to change. Keep in mind that we need to try and adhere to
normal system call semantics were we can, if at all possible.

Ian
