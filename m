From: Ian Kent <raven@themaw.net>
Subject: Re: Fwd: Converting to New Syntax
Date: Tue, 02 May 2017 08:58:17 +0800
Message-ID: <1493686697.2579.1.camel@themaw.net>
References: <CA+onWPdMOVqgvW7rhyDCQ8u4xJ+RTQptPtEjTRj4yja4tF9CnA@mail.gmail.com>
         <CA+onWPcDEfabovjUriMRTDVnOo8tx8rLf4PxJA13Xt_By5J4bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=xE1qB9cQX+zK37pSTX
        vOevdoIwO9q4AVzaQTaCGSy78=; b=C9j//EIuUyDO6Xr/5nle2uclerey4uPHy6
        whik+1nB9ZS7TAshfnhgFFm47hL7l+umj3rNzXLP6AdJfc/fbH1QlI4xvVeNXBUI
        /dh5ygvzM6mJHeLublapqIM4e1PltPwYFpV56me/MqtI6FI6ZLultcBx4GBgEDj3
        BkbhhDWalY12pMXWI/co94ixh2b2FtIAiHSN2pXV4vUsfS/jsabC4PUCVd3YIbw9
        Dkc4NDeJ0bjdrnKQ3z8ACGRalPt8puEGNh0mSqnrumdgZ/1Uig7fo1LZ/wUFYgcO
        aHD4UN8Q8vQHxj5T3YSQd1dDgPWIu17XvvRsqw8awwkGrjXnNEfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=xE1qB9cQX+zK37pSTXvOevdoIwO9q4AVzaQTaCGSy78=; b=AEkbsp00
        qmkzgK3VPxqjSzQ3ILFFaOqFWy/zPPXatqJrLv92ET2ZThlB2+7BNQEfQMmaIWj7
        GRFV1jpcpEB1H6O/hcFia5Ylzzs5fPBNLjZd106u0UTQdtlsQ4rlaPPrCiNaDIiK
        y4jGAOecxiZJVLOLgGubgDcCUcoxW1xz7fyTz6XmHYAEWK4ORp1FoP5AnEcqGMgd
        Hvvp7ajOFuD50iXZoHKH4RCywRWs46hGqcJhXD4vhabb61BfGnWHkHDfGkMKaug+
        zAW9mHdxzMnXsBnyjLmi/FtsqDVI8hna0djrdkPFuuAff1m1wTtL7qlbMFv4fTW4
        u+RPxJnCNEt+gg==
In-Reply-To: <CA+onWPcDEfabovjUriMRTDVnOo8tx8rLf4PxJA13Xt_By5J4bQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Jamie Jackson <jamiejaxon@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2017-05-01 at 16:02 -0400, Jamie Jackson wrote:
> I'm new to Autofs, but I've had one auto-mount going for a few weeks
> now. It came time for me to add a second one, but I ran into "ignoring
> duplicate indirect mount /mnt/non-icf/my"

All you need to understand is the concept that there is one master map that
contains top level automount managed mount points and entries in it have a
specific format.

The master map associates mount maps with these top level automount mount
points.

The maps specified in master map entries typically have more than one entry
(although if one entry is all you need that's fine too).

> 
> I see from https://www.spinics.net/lists/autofs/msg00000.html that I'm
> supposed to use a different syntax to get both of these mount points
> to coexist:
> 
> /mnt/non-icf/my/secureftp
> /mnt/non-icf/my/testsftp
> 
> I'm reading https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-nfs-c
> lient-config-autofs.html
> , but I'm having trouble absorbing the content.
> 
> Could someone help me convert what I've got to what I need?
> 
> https://gist.github.com/jamiejackson/460ba0a6526d6251554a157821f526da

First lets look at the master map.

If you're not using entries that are present in the default comment them out.
That would be /misc, /net and +auto.master.

Commenting out the last one is actually important because, if you're not using
the automount entry of nsswitch, the sources present in the default install
(this configuration file isn't owned by autofs) can cause some error message
noise in the log and introduce an unnecessary delay at startup.

Now these two entries:
/mnt/non-icf/my /etc/auto.my_sftp_test \
        uid=492,gid=488,--timeout=60,--ghost,--debug  
/mnt/non-icf/my /etc/auto.my_sftp_prod \
        uid=492,gid=488,--timeout=60,--ghost,--debug

The uid and gid options are not used by autofs.

Personally I always use the autofs configuration to enable debug logging.

Either way you need to ensure that syslog is capturing log level debug or
greater for the log entries to be sent to syslog.

If you're using systemd journalctl to instect the logs then setting log level
doesn't matter but if there is a lot of logging systemd will start dropping
entries.

Also I prefer to use the browse option rather than --ghost.

Then there's the duplicate entries.

So the master map would become, say:
/mnt/non-icf/my      /etc/auto.my_sftp --timeout=60,browse

And /etc/auto.my_sftp would contain:
secureftp 
-fstype=fuse,ro,nodev,noatime,allow_other,IdentityFile=/root/.ssh/my_sftp_key
 :sshfs\#XXXXX@secureftp.my.com\:/export/home/ICFfiles
testsftp 
-fstype=fuse,ro,nodev,noatime,allow_other,IdentityFile=/root/.ssh/hud_sftp_key
 :sshfs\#XXXXX@testsftp.my.com\:/export/home/ICFfiles

If you want to have separate top level mount points for stable and test then you
need to use a different top level mount point path in the master map so you can
use two distinct maps.

Beware that if you try to set debugging for the fuse mounts themselves (ie. not
handled by autofs) I think the sshfs mount process won't go into the background
causing the mount to never complete and that will result in unexpected
behaviour.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
