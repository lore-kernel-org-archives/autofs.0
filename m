From: Ian Kent <raven@themaw.net>
Subject: Re: More directories?
Date: Wed, 12 Mar 2008 20:59:19 +0900
Message-ID: <1205323159.2949.36.camel@raven.themaw.net>
References: <47D4445E.10100@bononline.nl>
	<1205114970.3025.19.camel@raven.themaw.net>
	<47D4DFFC.8010705@bononline.nl>
	<1205197978.2955.5.camel@raven.themaw.net>
	<47D7A632.8010101@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47D7A632.8010101@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org


On Wed, 2008-03-12 at 10:45 +0100, Stef Bon wrote:
> Ian Kent wrote:
> >
> >
> > Return everything else but the key as usual.
> > Format like:
> >
> > [-fstype=<type>,<options] [[/] [localtion] \
> > 	/<dir> location \
> > 	/<dir> location ....
> >
> > The leading "/" is required and the root mount "/" is optional.
> > It's been a while since I played with this but I think the offsets of
> > the multi-mount need to be in depth order.
> >
> > Ian
> >
> >   
> Ok, this format you give returns a list. This list is interpreted by the 
> automount daemon,
> and it determines which entry applies.
> 
> Now it should be possible to let this script (it has to be a script) 
> only show the entry which applies:

No, that's not what I said.
This is a multi-mount entry, so by definition, all mounts in the
hierarchy must be supplied when the entry is requested. 

> 
> -fstype=cifs,credentials=/home/sbon/.smb/mount.cred     / \
>                          /sbon/lfs20060812/public ://lfs20060812/public

No, that's not right.

The spec I gave said that if "/", the root of the mount tree is present,
it must have a corresponding location, which isn't present here. Leave
it out.

If you return this entry, without the "/", then it will be the only
mount you will be able to make until it expires away. Until that time
you will not be have an opportunity to supply another entry. If you
don't need more mount offsets then this should work OK (without the
"/").

This is the way it must be with multiple, possibly nested, mount
entries.

Ian
