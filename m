From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: show pipe inode in mount options
Date: Fri, 08 Jan 2016 20:58:33 +0800
Message-ID: <1452257913.7030.25.camel@themaw.net>
References: <20151216120222.19097.54512.stgit@localhost.localdomain>
	 <568E8840.3010801@odin.com> <1452237640.2973.19.camel@themaw.net>
	 <568F9D85.6070601@odin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=zJzu4ZpoRlrLxjQfUdJxgjC7ojg=; b=FyRl+X
	Y8Qdh918J2wmj5ctDnTVnGZJ9WRo3gMSpp3VpzAF/wEf6izTXUMHvY4TIMDgmzZb
	3308v0K2MI/gBrm3u69eYMveEi7OCemEv/S6XKy5Ils42Ll2rHJ4o0Ykk6nG3gK8
	PREszXBWreyFtvmUUcdbMZCInAOL22yrE5/qM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=zJzu4ZpoRlrLxjQ
	fUdJxgjC7ojg=; b=F7ft2+PGqVFuvwuoAg2iQpQZPhPk36MSzFhZLMExpIrPrFI
	w/OZ1bHwQNaC9q9bc835u1vgcNR30SvcZKQFTvTWxsra2mMBG1FAceBxER6GByuj
	SCMCZutkGo9K2jFfhsw9Lv0B82ABUwj9p7dlw7ooMziiPQF47mkJric2QR/0=
In-Reply-To: <568F9D85.6070601@odin.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: skinsbursky@virtuozzo.com
Cc: criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>

On Fri, 2016-01-08 at 12:29 +0100, Stanislav Kinsburskiy wrote:
>=20
> 08.01.2016 08:20, Ian Kent =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, 2016-01-07 at 16:46 +0100, Stanislav Kinsburskiy wrote:
> > > Good day, gentlemen.
> > >=20
> > > Could you update, what's the status with this patch?
> > > Without it it's impossible to match process pipe with kernel
> > > pipe,
> > > while
> > > this is "must have" to be able to migrate AutoFS via CRIU.
> > Right, I did mean to reply to this mail but have been distracted by
> > family stuff.
> >=20
> > I don't know what CRIU is and people looking at changelog entries
> > shouldn't need to do a web search to find out.
> >=20
> > Could you change it a little.
>=20
> Fair enough. I'll resend with more descriptive message.
> But first I would like to clarify to you the problem root and why
> it's=20
> done like this.
>=20
> > I'm also not sure whether to forward this (assuming the description
> > is
> > updated a little) to Al or to include it in the series to rename
> > autofs4 to autofs that I'm hoping to ask be included in linux-next
> > fairly soon.
>=20
> Here I don't know, what's better. Of course Al can take it as well.
> But,=20
> probably, first would be nice to make sure, that this solution is the
> best one.
> Description of the problem is below.
>=20
> > Passing it on to Al will likely interfere with the series coming
> > from
> > linux-next so that could be bit of a hassle.
> >=20
> > Another thing I'm wondering about is the order this entry will
> > appear
> > at in the options. You order choice is sensible though and autofs
> > shouldn't have a problem with the inserted option but other
> > applications might.
>=20
> I should put it at the end, probably?
>=20
> > Finally, and perhaps most importantly, I don't get what your trying
> > to
> > do, you also haven't given any clues to that in the patch
> > dscription.
> >=20
> > IOW how do you expect to use this.
> >=20
> > >=20
> > > 16.12.2015 13:02, Stanislav Kinsburskiy =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> > > > This is required for CRIU to migrate a mount point, when write
> > > > end
> > > > in user
> > > > space is closed.
> > Like I said what does this mean.
> >=20
> > autofs doesn't need this when it re-constructs a mount tree from
> > existing mounts on re-start or after a SIGKILL on the automount
> > process.
> >=20
> > How is this different and how will it be used?
> >=20
> > The question to be answered here is "is this the best way to do it
> > and
> > will it work for the autofs mount types you expect it to"?
>=20
> So, here is a brief description of the problem.
> To migrate autofs mount, one have to reconstruct control pipe between
> kernel and autofs master.
> There are two cases I'm wiling to support:
> 1) Automount binary (autofs package). This program is very gentle and
> it=20
> doesn't close write end of the pipe after mount.
> 2) Systemd. This program closes write end of the pipe once the mount
> is=20
> done.

I must admit I'm having trouble understanding the description.
Give me a little time with it.

I don't know how systemd works with autofs mounts only that it uses the
autofs direct mount type.

autofs uses both indirect and direct mounts and both can have offsets
(from the kernel POV semantically direct mounts). So there is quite a
bit to worry about beside the kernel pipe.

Anyway, it seems your only concern is the kernel pipe and I wonder why
you can't just set the mount catatonic (in autofs speak) on save and
open a new kernel pipe then set the pipefd on the autofs mount on
restore.

But probably my suggestion is far to simplistic as I get the impression
you have a process already in a given state which you want to restore.

One thing to keep in mind is that if an autofs mount is not set
catatonic any access other than the owner process (process group pid)
will hang unless there is an actual user space process to service the
callback.

Although I don't know the flow of things that might be important at
some point.

And if the mount is set catatonic the process needs to set the pipefd
to take "ownership" which also clears the mount catatonic flag.

Anyway, let me think about what you've written for a while.
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
