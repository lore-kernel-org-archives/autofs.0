From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
Date: Tue, 29 Jan 2019 20:58:11 -0800
Message-ID: <20190129205811.2bd83d93dbc05325a8c55954@linux-foundation.org>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
        <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
        <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
        <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Bian <bianpan2016@163.com>

On Wed, 30 Jan 2019 10:07:15 +0800 Ian Kent <raven@themaw.net> wrote:

> On Tue, 2019-01-29 at 17:16 -0800, Andrew Morton wrote:
> > On Sat, 12 Jan 2019 08:00:40 +0800 Ian Kent <raven@themaw.net> wrote:
> > 
> > > Add an autofs file system mount option that can be used to provide
> > > a generic indicator to applications that the mount entry should be
> > > ignored when displaying mount information.
> > 
> > What is the reason for adding this feature?
> 
> In other OSes that provide autofs and that provide a mount list
> to user space based on the kernel mount list a no-op mount option
> ("ignore" is the one use on the most common OS) is allowed so that
> autofs file system users can optionally use it.
> 
> The idea is that it be used by user space programs to exclude
> autofs mounts from consideration when reading the mounts list.
> 
> Prior to the change to link /etc/mtab to /proc/self/mounts all
> I needed to do to achieve this was to use mount(2) and not update
> the mtab but now that no longer works.
> 
> I know the symlinking happened a long time ago and I considered
> doing this then but, at the time I couldn't remember the commonly
> used option name and thought persuading the various utility
> maintainers would be too hard.
> 
> But now I have a RHEL request to do this for compatibility for a
> widely used product so I want to go ahead with it and try and
> enlist the help of some utility package maintainers.
> 
> Clearly, without the option nothing can be done so it's at least
> a start.

OK.  I guess I can just paste the above into the changelog.

Also, Documentation/filesystems/autofs*.txt are owed an update?


