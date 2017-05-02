From: Jamie Jackson <jamiejaxon@gmail.com>
Subject: Re: Fwd: Converting to New Syntax
Date: Tue, 2 May 2017 12:17:46 -0400
Message-ID: <CA+onWPdL-dj_P=8d5-FqXZVHifQJdR7N6DH+uXh5DNc23yMqQw@mail.gmail.com>
References: <CA+onWPdMOVqgvW7rhyDCQ8u4xJ+RTQptPtEjTRj4yja4tF9CnA@mail.gmail.com>
 <CA+onWPcDEfabovjUriMRTDVnOo8tx8rLf4PxJA13Xt_By5J4bQ@mail.gmail.com> <1493686697.2579.1.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+VAxUeFt7D6uRy5jPpIW6CIDzfIsE5aF7Vydusv1xDI=;
        b=VbSIhHlhj2tPL8iBJTVys/ie4GrABHeH0BGOjitK5bpCAUFJi6T+aTxEFsP8oBD/1M
         KZ30jYpLwXCkDHzyi2/ooTJJMIn0bBdCNflgthk7lXUYSqTmpReoMjW9bZ0oTbF7Yzwk
         jgC5UZnhjggqpnKt8Syt8s3nc54k8wjyt4pxSnTGFZJVc4JQ4Tq8ZCq+jKMur0weK2PO
         UghrlRn8C/Yg9shNqT3dBrfMCPj0suZdcKoKCDOpKkJ6o9A/kjAzra3Ao+wy51edHqx/
         TRZGwCUT7S/3vzGU7itWu9gEuqAvjRZ5I5UoCOj0h6Y+yL5yz7kqPJtpNv0Vf1Rnnpfj
         Cf6w==
In-Reply-To: <1493686697.2579.1.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

On Mon, May 1, 2017 at 8:58 PM, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2017-05-01 at 16:02 -0400, Jamie Jackson wrote:
>> I'm new to Autofs, but I've had one auto-mount going for a few weeks
>> now. It came time for me to add a second one, but I ran into "ignoring
>> duplicate indirect mount /mnt/non-icf/my"
>
> All you need to understand is the concept that there is one master map that
> contains top level automount managed mount points and entries in it have a
> specific format.
>
> The master map associates mount maps with these top level automount mount
> points.
>
> The maps specified in master map entries typically have more than one entry
> (although if one entry is all you need that's fine too).
>
>>
>> I see from https://www.spinics.net/lists/autofs/msg00000.html that I'm
>> supposed to use a different syntax to get both of these mount points
>> to coexist:
>>
>> /mnt/non-icf/my/secureftp
>> /mnt/non-icf/my/testsftp
>>
>> I'm reading https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-nfs-c
>> lient-config-autofs.html
>> , but I'm having trouble absorbing the content.
>>
>> Could someone help me convert what I've got to what I need?
>>
>> https://gist.github.com/jamiejackson/460ba0a6526d6251554a157821f526da
>
> First lets look at the master map.
>
> If you're not using entries that are present in the default comment them out.
> That would be /misc, /net and +auto.master.
>
> Commenting out the last one is actually important because, if you're not using
> the automount entry of nsswitch, the sources present in the default install
> (this configuration file isn't owned by autofs) can cause some error message
> noise in the log and introduce an unnecessary delay at startup.

Great, I see the difference after having removed it.

> Now these two entries:
> /mnt/non-icf/my /etc/auto.my_sftp_test \
>         uid=492,gid=488,--timeout=60,--ghost,--debug
> /mnt/non-icf/my /etc/auto.my_sftp_prod \
>         uid=492,gid=488,--timeout=60,--ghost,--debug
>
> The uid and gid options are not used by autofs.

When I had them defined, the files showed as having the local
user/group that I wanted. After having removed them, they show as the
uid/gid of the remote user. I'm not sure how to reconcile my findings
with what you said, above. Could you elaborate on that?

> Personally I always use the autofs configuration to enable debug logging.

I take that to mean that i should remove the `--debug` option from the
master map, and add `LOGGING=debug` to auto.master. (Done.)

> Either way you need to ensure that syslog is capturing log level debug or
> greater for the log entries to be sent to syslog.
>
> If you're using systemd journalctl to instect the logs then setting log level
> doesn't matter but if there is a lot of logging systemd will start dropping
> entries.
>
> Also I prefer to use the browse option rather than --ghost.

It looks like `BROWSE_MODE=yes` is the default, so I just removed the
`--ghost` flag.

> Then there's the duplicate entries.
>
> So the master map would become, say:
> /mnt/non-icf/my      /etc/auto.my_sftp --timeout=60,browse
>
> And /etc/auto.my_sftp would contain:
> secureftp
> -fstype=fuse,ro,nodev,noatime,allow_other,IdentityFile=/root/.ssh/my_sftp_key
>  :sshfs\#XXXXX@secureftp.my.com\:/export/home/ICFfiles
> testsftp
> -fstype=fuse,ro,nodev,noatime,allow_other,IdentityFile=/root/.ssh/hud_sftp_key
>  :sshfs\#XXXXX@testsftp.my.com\:/export/home/ICFfiles
>
> If you want to have separate top level mount points for stable and test then you
> need to use a different top level mount point path in the master map so you can
> use two distinct maps.

Got it. Seeing your conversion of my configs helps me understand.
Everything seems to be working with both mounts (except that the
ownership looks weird). Thanks for the help.

> Beware that if you try to set debugging for the fuse mounts themselves (ie. not
> handled by autofs) I think the sshfs mount process won't go into the background
> causing the mount to never complete and that will result in unexpected
> behaviour.

Yup, I learned that the hard way in
https://bugzilla.redhat.com/show_bug.cgi?id=1434600. Thanks for that.

Jamie
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
