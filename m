From: Ian Kent <raven@themaw.net>
Subject: Re: LDAP-based "auto.net" for /net
Date: Thu, 21 Aug 2008 21:47:12 +0800
Message-ID: <1219326432.15073.6.camel@raven.themaw.net>
References: <39967.129.83.31.3.1219317751.squirrel@webmail.kickflop.net>
	<x493akyjxr4.fsf@segfault.boston.devel.redhat.com>
	<48AD7135.9080406@kickflop.net>
	<x49y72qiip7.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49y72qiip7.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Blaine <jblaine@kickflop.net>
Cc: autofs@linux.kernel.org


On Thu, 2008-08-21 at 09:47 -0400, Jeff Moyer wrote:
> Jeff Blaine <jblaine@kickflop.net> writes:
> 
> > Jeff Moyer wrote:
> >> jblaine@kickflop.net writes:
> >>
> >>> If anyone has been successful in getting /net/hostname
> >>> automounting working with LDAP-based autofs maps (not
> >>> a local /etc/auto.net file), I would love to see your
> >>> LDIF information showing how you configured it.
> >>
> >> First, program maps must be on a file system.  Second, are you using
> >> autofs version 4 or 5?  
> >
> > AutoFS 5.
> >
> >> If 5, then you can simply use the ldif equivalent of:
> >> /net       -hosts
> >
> > That's what I am trying to do :)  I was hoping someone could
> > show me theirs.  It's not clear to me how to construct that
> > particular set of LDIF info.

And what have you got in LDAP now or are you starting from scratch?

> 
> OK, what schema are you using?
> 
> -Jeff
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
