From: Ian Kent <raven@themaw.net>
Subject: Re: Fwd: Converting to New Syntax
Date: Wed, 03 May 2017 08:52:47 +0800
Message-ID: <1493772767.2831.3.camel@themaw.net>
References: <CA+onWPdMOVqgvW7rhyDCQ8u4xJ+RTQptPtEjTRj4yja4tF9CnA@mail.gmail.com>
         <CA+onWPcDEfabovjUriMRTDVnOo8tx8rLf4PxJA13Xt_By5J4bQ@mail.gmail.com>
         <1493686697.2579.1.camel@themaw.net>
         <CA+onWPdL-dj_P=8d5-FqXZVHifQJdR7N6DH+uXh5DNc23yMqQw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=y+CynP6wWmxgn4Vwj+
        oc5nZvNLSuuimapMTf+2PrCWI=; b=UrLZtIg/tK5gtfrMcFm5457A187J1hliRg
        J5MQJN4GvJ3FnEzHGhKKUpUimwNQveTZiL7dbQ3wQ7NLx64Z51FpWWe2lXTHxfY4
        vtkJCnS3iKF/apIx6Wah9c+wKnstyKbKTfy51rWKX8UdMMMfEHaT6OJiLWqMMAZp
        wb67Y1wdF3lv8mileX0X2ergweopovtPDi9a5CTGcpclGthHaH1u6YQjw2Ae5Bii
        2p6D8mqPYRh40HOKHgXUzGm9aSFuUk8JrfvjfudyE4VdCHutrDqkndsvzipi+TsU
        zirpKYXyFT5HcgDrSq7eK0V5e9U//BRVYqWfdr7k7vcPc8QvpU1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=y+CynP6wWmxgn4Vwj+oc5nZvNLSuuimapMTf+2PrCWI=; b=cTefwlwF
        C2q6p2za8H5vJf5YC58U24Iwt9ApKw+1x1nfkfCN6Nq/HTyejq3Djxk6P3UxooWI
        FLdNGGvj5T7f3VugvNx0bj4uOo/Rsh/syV5mj3YFtNlWhxfiwHBIHOWQ0GhBQeaa
        dioTF6pukTmGLKOpMuv2QBTZkZa3WVxIO+lxeEUe6QuuLwzwI1dFxOB6l0TlTE1P
        Te8zY5rtlI+cvwIo1jdAbidi7onE7o0bCD5HEeE/24WBAmgdQO5ASNM1inbfa6gp
        MboXed/cnUW/cKgCvWIWLL7tFvr5iJvURzb9ScuFpzdRB7HSugwXCDvmb1BEcMeO
        qgns7lOrEjo3+g==
In-Reply-To: <CA+onWPdL-dj_P=8d5-FqXZVHifQJdR7N6DH+uXh5DNc23yMqQw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Jamie Jackson <jamiejaxon@gmail.com>
Cc: autofs@vger.kernel.org

On Tue, 2017-05-02 at 12:17 -0400, Jamie Jackson wrote:
> On Mon, May 1, 2017 at 8:58 PM, Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2017-05-01 at 16:02 -0400, Jamie Jackson wrote:
> > > I'm new to Autofs, but I've had one auto-mount going for a few weeks
> > > now. It came time for me to add a second one, but I ran into "ignoring
> > > duplicate indirect mount /mnt/non-icf/my"
> > 
> > All you need to understand is the concept that there is one master map that
> > contains top level automount managed mount points and entries in it have a
> > specific format.
> > 
> > The master map associates mount maps with these top level automount mount
> > points.
> > 
> > The maps specified in master map entries typically have more than one entry
> > (although if one entry is all you need that's fine too).
> > 
> > > 
> > > I see from https://www.spinics.net/lists/autofs/msg00000.html that I'm
> > > supposed to use a different syntax to get both of these mount points
> > > to coexist:
> > > 
> > > /mnt/non-icf/my/secureftp
> > > /mnt/non-icf/my/testsftp
> > > 
> > > I'm reading https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-n
> > > fs-c
> > > lient-config-autofs.html
> > > , but I'm having trouble absorbing the content.
> > > 
> > > Could someone help me convert what I've got to what I need?
> > > 
> > > https://gist.github.com/jamiejackson/460ba0a6526d6251554a157821f526da
> > 
> > First lets look at the master map.
> > 
> > If you're not using entries that are present in the default comment them
> > out.
> > That would be /misc, /net and +auto.master.
> > 
> > Commenting out the last one is actually important because, if you're not
> > using
> > the automount entry of nsswitch, the sources present in the default install
> > (this configuration file isn't owned by autofs) can cause some error message
> > noise in the log and introduce an unnecessary delay at startup.
> 
> Great, I see the difference after having removed it.
> 
> > Now these two entries:
> > /mnt/non-icf/my /etc/auto.my_sftp_test \
> >         uid=492,gid=488,--timeout=60,--ghost,--debug
> > /mnt/non-icf/my /etc/auto.my_sftp_prod \
> >         uid=492,gid=488,--timeout=60,--ghost,--debug
> > 
> > The uid and gid options are not used by autofs.
> 
> When I had them defined, the files showed as having the local
> user/group that I wanted. After having removed them, they show as the
> uid/gid of the remote user. I'm not sure how to reconcile my findings
> with what you said, above. Could you elaborate on that?

Umm .. now I think about it what I said is plain wrong (almost).

It's been a while since I've had to think about this but I think master map
entry options that aren't autofs specific will be used as global options
(appended to map entry options by default) for mounts so it probably comes down
to what fuse will do with the options.

Without a mounts having been triggered for these map entries the options should
have no effect.

> 
> > Personally I always use the autofs configuration to enable debug logging.
> 
> I take that to mean that i should remove the `--debug` option from the
> master map, and add `LOGGING=debug` to auto.master. (Done.)

Mmm .. oldish syntax .. what version, OS?
It shouldn't matter though.

> 
> > Either way you need to ensure that syslog is capturing log level debug or
> > greater for the log entries to be sent to syslog.
> > 
> > If you're using systemd journalctl to instect the logs then setting log
> > level
> > doesn't matter but if there is a lot of logging systemd will start dropping
> > entries.
> > 
> > Also I prefer to use the browse option rather than --ghost.
> 
> It looks like `BROWSE_MODE=yes` is the default, so I just removed the
> `--ghost` flag.

It depends on distribution.

The internal program default is browse (because other widely used autofs
implementations had this default) but in RHEL, for example, the default
installed configuration sets browse_mode to no because that was the expected
behaviour of autofs before browsing was implemented.

And there can be some unexpected semantic behaviours when using it. But that
also depends on kernel version, it gets hard to describe at this point so I'll
not say more about it. 

snip ...

> 
> > Beware that if you try to set debugging for the fuse mounts themselves (ie.
> > not
> > handled by autofs) I think the sshfs mount process won't go into the
> > background
> > causing the mount to never complete and that will result in unexpected
> > behaviour.
> 
> Yup, I learned that the hard way in
> https://bugzilla.redhat.com/show_bug.cgi?id=1434600. Thanks for that.

Right, I thought the name looked familiar, ;)

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
