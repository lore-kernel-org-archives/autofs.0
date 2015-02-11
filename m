From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: sloppy mount option not handled by some filesystems.
Date: Wed, 11 Feb 2015 12:03:06 +0100
Message-ID: <CAJfpegvt7ArFWV6+6gzJA2QT+-DC+t5x9Op3R=OBO-bNfHFreA@mail.gmail.com>
References: <CAJfpegsPezK7-MY7F+re7N4N564OyzKVPsmOa-zSWGSpuP7W_A@mail.gmail.com>
	<1422401769.2654.29.camel@pluto.fritz.box>
	<CAJfpegvkCRbpTCTOvOpdw0F167SvrzVRnCtGJGxUQ9hdoYS3pw@mail.gmail.com>
	<1423651936.2599.32.camel@pluto.fritz.box>
	<1423652197.2599.33.camel@pluto.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0Xj9963BZY8fCT6BIki6K/JHshTfyiMlXd0nAUfVoIM=;
        b=dznqNlT5LiwcXSn/OQldYqMWNbjFNj8DAEFkYErvyKqV/WivQdDhye7IkimLQMe/Ts
         LVpxo+yx8oHuIV4cFD8ZBhcyTFBTAtLPXOgRWO/G0y6r64dZ4mo++8E6P1MaPL85QlWc
         zWPLPNTm7ONNwXuPQhNLrzv1wotl48mK492kQ=
In-Reply-To: <1423652197.2599.33.camel@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <ikent@redhat.com>
Cc: autofs@vger.kernel.org, lchiquitto@suse.com

On Wed, Feb 11, 2015 at 11:56 AM, Ian Kent <ikent@redhat.com> wrote:
> On Wed, 2015-02-11 at 18:52 +0800, Ian Kent wrote:
>> On Wed, 2015-02-11 at 11:11 +0100, Miklos Szeredi wrote:
>> > On Wed, Jan 28, 2015 at 12:36 AM, Ian Kent <ikent@redhat.com> wrote:
>> >
>> > > I could leave it only for NFS, as it supports it anyway, and not pass it
>> > > for any other mounts. Then any bug requests could be passed on the the
>> > > file system maintainers. Then I could add it for that file system when
>> > > done.
>> > >
>> > > The only annoyance with that approach is the autofs generic mount
>> > > module, which is used to mount a number of file systems, would need to
>> > > check the file system name to decide whether to add the sloppy option.
>> > >
>> > > TBH I'm not to fussy about what we do here but we need to make a
>> > > decision before I do or I'll end up flipping back and forth.
>> > >
>> > > So I guess it's up to us to decide, ;)
>> > >
>> > > I'll post a message to the autofs list once we decide and see if we get
>> > > any good arguments to change the approach and we can alter it as needed
>> > > (if at all).
>> >
>> > Hi Ian,
>> >
>> > Any news about this?
>> >
>> > There's more and morecomplaints about the new behavior.  I'm inclined
>> > to just make it NFS-only, as that will restore the old state of
>> > affairs.
>>
>> Good question, I must admit I had forgotten about it since with the
>> report I had the subsystem changed to ignore the option.
>>
>> I was going to not pass it from autofs and I have a patch for that.
>> We could use that, after I check I've cover the bases, and I'll commit
>> it upstream with the next set of patches (that might be a little while
>> though).
>
> Leaving it for NFS only, of course.

Okay.

If you have a patch, please let me know and I'll review and test it.

Thanks,
Miklos
