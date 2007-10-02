From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] nested mounts with loop
Date: Tue, 02 Oct 2007 13:19:25 +0800
Message-ID: <1191302365.26331.36.camel@raven.themaw.net>
References: <n7xir5ybts0.fsf@sor.suse.de>
	<1190743449.3116.20.camel@raven.themaw.net>
	<n7xsl51v3wa.fsf@sor.suse.de>
	<1190821748.12109.33.camel@raven.themaw.net>
	<x491wcl1kjw.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x491wcl1kjw.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

On Wed, 2007-09-26 at 12:02 -0400, Jeff Moyer wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Wed, 2007-09-26 at 17:32 +0200, Matthias Koenig wrote:
> >> Ian Kent <raven@themaw.net> writes:
> >> 
> >> > On Tue, 2007-09-25 at 18:21 +0200, Matthias Koenig wrote:
> >> >> Hi,
> >> >> 
> >> >> we noticed a problem concerning loop mounts on locations that 
> >> >> have to be mounted before. E.g. consider the following situation,
> >> >> a NFS server exporting a cd image, which we want to loop mount
> >> >> locally to get access to the content:
> >> >> 
> >> >> auto.master:
> >> >> /cdimage        auto.cdimage
> >> >> /cdcontent      auto.cdcontent
> >> >> 
> >> >> auto.cdimage:
> >> >> foo             nfsserver:/cdimage/foo.img
> >> >> 
> >> >> auto.cdcontent:
> >> >> foo             -fstype=auto,loop       :/cdimage/foo/foo.img
> >> >> 
> >> >> The access to /cdcontent/foo will fail, when /cdimage/foo is not 
> >> >> mounted before, because spawn_mount does not use SPAWN_OPT_ACCESS
> >> >> in this case.
> >> >> The patch below fixes this problem.
> >> >
> >> > I can't remember now.
> >> > I wonder why I don't always call access?
> >> > I must have had a reason, let me think about it for a while.
> >> 
> >> Yes, I first tried to set SPAWN_OPT_ACCESS as default, but this did
> >> not work and had the negative effect, that NFS mounts could not
> >> be mounted anymore, because an access() has been done on the
> >> NFS location description "nfsserver:/cdimage", which then fails.
> >
> > Of course, I'll go with you're patch.
> 
> Are you sure the argument positions will be the same for all of the
> mount modules?  Is this really the best way to fix this?

Yes, it's possible that the "-o" could end up in a different position if
the code is modified at some later time without thinking.

The SPAWN_OPT_ACCESS mechanism turned out to be the only way to deal
with this case. I spent a fair while trying to work out another way to
do it but couldn't think of any. People had been using this method for
quite a long time in personal patches.

Ian
