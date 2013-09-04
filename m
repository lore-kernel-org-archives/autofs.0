From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/3] autofs4 - fix device ioctl mount lookup
Date: Wed, 4 Sep 2013 03:26:17 +0100
Message-ID: <20130904022617.GG13318@ZenIV.linux.org.uk>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
 <20130904010301.GE13318@ZenIV.linux.org.uk>
 <20130904020013.GF13318@ZenIV.linux.org.uk>
 <CA+55aFwF+dqSMyGE+3LamM+qSDymieyReYB+RPb8fHTTmntgqw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwF+dqSMyGE+3LamM+qSDymieyReYB+RPb8fHTTmntgqw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ian Kent <raven@themaw.net>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Sep 03, 2013 at 07:18:42PM -0700, Linus Torvalds wrote:
> On Tue, Sep 3, 2013 at 7:00 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > That aside, I'm really not happy with this kind of games; this stuff clearly
> > belongs in fs/namei.c where we can simply see the last component.  Doing that
> > on the level of "let's scan the pathname for slashes, etc." is just plain
> > wrong.  Let's step back for a minute here; what are you trying to do?
> > You have a pathname that should resolve to a mountpoint, without triggering
> > automount (or crossing into the mountpoint, for that matter) and you want
> > struct path for the bottom of that mount stack?  Or is it something
> > completely different?
> 
> Can we add a LOOKUP_NOAUTOMNT bit or something (not exposed to user
> space, only used for this particular kern_path() call). Then, if/when
> automount gets called recursively (through autofs4_lookup? Or is it
> just the autofs4_d_automount() interface?) it can just decide to not
> follow that last path.
> 
> Hmm? I don't think we pass in the lookup-flags to d_automount, but
> that could be changed. Yes?

No need, really - what we ought to do, AFAICS, is what umount(2) needs.
I've applied slightly modified variant of Jeff's "vfs: allow umount to handle
mountpoints without revalidating them" (modified by just leaving the
struct path filled with mountpoint and leaving the equivalent of follow_mount()
to caller) to the local queue and I'm pretty sure that it's what we want
here as well.

I'll push for-next tonight and send a pull request your way tomorrow, if you
are OK with that.
