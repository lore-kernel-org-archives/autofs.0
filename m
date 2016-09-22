From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Thu, 22 Sep 2016 10:43:26 -0500
Message-ID: <87k2e4c541.fsf@x220.int.ebiederm.org>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
        <20160914061445.24714.68331.stgit@pluto.themaw.net>
        <20160917201000.omswgttgyzcu7jt6@mguzik>
        <1474248973.3204.14.camel@themaw.net>
        <87oa3iikgf.fsf@x220.int.ebiederm.org>
        <1474411462.22440.2.camel@themaw.net>
        <1474412413.22440.7.camel@themaw.net>
        <1474507987.12887.5.camel@themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474507987.12887.5.camel@themaw.net> (Ian Kent's message of
        "Thu, 22 Sep 2016 09:33:07 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Mateusz Guzik <mguzik@redhat.com>, NeilBrown <neilb@suse.com>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

Ian Kent <raven@themaw.net> writes:

> Eric, Mateusz, I appreciate your spending time on this and particularly pointing
> out my embarrassingly stupid is_local_mountpoint() usage mistake.
>
> Please accept my apology for the inconvenience.
>
> If all goes well (in testing) I'll have follow up patches to correct this fairly
> soon.

Related question.  Do you happen to know how many mounts per mount
namespace tend to be used?  It looks like it is going to be wise to put
a configurable limit on that number.  And I would like the default to be
something high enough most people don't care.  I believe autofs is
likely where people tend to use the most mounts.

Eric
