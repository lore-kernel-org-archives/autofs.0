From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] [RFC] direct mount support re-work for autofs v4
Date: Fri, 25 Feb 2005 17:46:10 -0500
Message-ID: <16927.43698.82318.311057@segfault.boston.redhat.com>
References: <Pine.LNX.4.61.0502232157130.8193@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.61.0502232157130.8193@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian,

Thanks for the write-up!  One question below.

==> Regarding [autofs] [RFC] direct mount support re-work for autofs v4; raven@themaw.net adds:

[snip]

raven> As far as the daemon goes the changes needed to do this are fairly
raven> straight forward and reduce overall complexity. They amount to
raven> identifying the direct map in the master map by its key ("/-"),
raven> adding an additional mount option "direct" to each mount, adding an
raven> enumeration function to each map lookup module and to the map cache
raven> module used by autofs v4.  Together they will be used to perform
raven> mounts, expire runs and umounts.

raven> Since a single daemon will handle multiple autofs mounts, we need a
raven> way to distinguish one from another. This can be done by adding two
raven> additional kernel message handlers to the daemon for "missing" and
raven> "expire" events. The new messages will include the ioctl fd that
raven> autofs uses to communicate with the mount point. The lookup key path
raven> is not needed in these messages as the lookup information can be
raven> obtained from the ioctl fd found in the event message. In
raven> particular, the st_dev together with the st_ino from the stat struct
raven> should be sufficient for distinct key lookups.

Isn't the message communicated over the ioctl fd?  If so, why include this
data in the message?  It seems a bit redundant.


This is as far as I got.  I'll try to look at this in more detail next
week.

Thanks!

Jeff
