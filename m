From: Ian Kent <ikent@redhat.com>
Subject: Re: sloppy mount option not handled by some filesystems.
Date: Wed, 28 Jan 2015 07:36:09 +0800
Message-ID: <1422401769.2654.29.camel@pluto.fritz.box>
References: <CAJfpegsPezK7-MY7F+re7N4N564OyzKVPsmOa-zSWGSpuP7W_A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <CAJfpegsPezK7-MY7F+re7N4N564OyzKVPsmOa-zSWGSpuP7W_A@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: autofs@vger.kernel.org, lchiquitto@suse.com

On Tue, 2015-01-27 at 18:09 +0100, Miklos Szeredi wrote:
> I have two bug reports about filesystems that reject the "-s" option
> and hence can't be used with autofs compiled with the sloppy option
> (which apparently needs to be kept for back compatibility).

I know, I've had only one too.

The problem has come up because libmount decided that file systems have
had enough time to add support for it and started to pass it on to all
file system mounts (without updating the man page). 

Previously it was passed it on to NFS only.

> 
> The mount(8) man page says that filesystems do not necessarily support
> "-s" so I think autofs should honour this.

Yeah, I know.

> 
> Any ideas?

My initial response was to not add it for file systems other than NFS.
But the reporter didn't think that was a good idea.

The end result of the bug was ntfs-3g got a patch to ignore the option
which the reporter wasn't quite happy with either but at that stage we'd
had enough discussion and left it at that.

On one hand not using it for file systems other than NFS restores the
status quo but OTOH it would be useful for file systems to add it. That
really only amounts to file systems initially ignoring it and later
adding checks to not fail a mount when invalid options are encountered.
Both not a big deal but given how long file systems have had to add it
that probably won't happen.
 
> 
> Fs type whitelist?

I could do that.

> 
> Blacklist?

Probably not a good idea since so few file systems support it.

> 
> Retrying without the sloppy option if it fails with it?

Not a good idea I think since it could slow down interactive mounts. I'm
already resisting requests to add mount retries as NFS already does that
given the appropriate options and that would be doubling up and slowing
things down a lot.

> 
> Autofs option to turn off the sloppy option on a per-map or per-mount basis?

As I said, my first thought was to not use it at all any more but there
might be some people that have autofs maps for multiple OSes that still
use options not supported by Linux NFS mount. Probably not many though
because Linux NFS mount allows pretty much all the option variants I'm
aware of these days.

I could leave it only for NFS, as it supports it anyway, and not pass it
for any other mounts. Then any bug requests could be passed on the the
file system maintainers. Then I could add it for that file system when
done.

The only annoyance with that approach is the autofs generic mount
module, which is used to mount a number of file systems, would need to
check the file system name to decide whether to add the sloppy option.

TBH I'm not to fussy about what we do here but we need to make a
decision before I do or I'll end up flipping back and forth.

So I guess it's up to us to decide, ;)

I'll post a message to the autofs list once we decide and see if we get
any good arguments to change the approach and we can alter it as needed
(if at all).

Ian

