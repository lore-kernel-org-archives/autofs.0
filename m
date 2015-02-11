From: Ian Kent <ikent@redhat.com>
Subject: Re: sloppy mount option not handled by some filesystems.
Date: Wed, 11 Feb 2015 18:52:16 +0800
Message-ID: <1423651936.2599.32.camel@pluto.fritz.box>
References: <CAJfpegsPezK7-MY7F+re7N4N564OyzKVPsmOa-zSWGSpuP7W_A@mail.gmail.com>
	 <1422401769.2654.29.camel@pluto.fritz.box>
	 <CAJfpegvkCRbpTCTOvOpdw0F167SvrzVRnCtGJGxUQ9hdoYS3pw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <CAJfpegvkCRbpTCTOvOpdw0F167SvrzVRnCtGJGxUQ9hdoYS3pw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: autofs@vger.kernel.org, lchiquitto@suse.com

On Wed, 2015-02-11 at 11:11 +0100, Miklos Szeredi wrote:
> On Wed, Jan 28, 2015 at 12:36 AM, Ian Kent <ikent@redhat.com> wrote:
> 
> > I could leave it only for NFS, as it supports it anyway, and not pass it
> > for any other mounts. Then any bug requests could be passed on the the
> > file system maintainers. Then I could add it for that file system when
> > done.
> >
> > The only annoyance with that approach is the autofs generic mount
> > module, which is used to mount a number of file systems, would need to
> > check the file system name to decide whether to add the sloppy option.
> >
> > TBH I'm not to fussy about what we do here but we need to make a
> > decision before I do or I'll end up flipping back and forth.
> >
> > So I guess it's up to us to decide, ;)
> >
> > I'll post a message to the autofs list once we decide and see if we get
> > any good arguments to change the approach and we can alter it as needed
> > (if at all).
> 
> Hi Ian,
> 
> Any news about this?
> 
> There's more and morecomplaints about the new behavior.  I'm inclined
> to just make it NFS-only, as that will restore the old state of
> affairs.

Good question, I must admit I had forgotten about it since with the
report I had the subsystem changed to ignore the option.

I was going to not pass it from autofs and I have a patch for that.
We could use that, after I check I've cover the bases, and I'll commit
it upstream with the next set of patches (that might be a little while
though).

Ian

