From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Tue, 6 Jul 2010 13:35:00 +0200
Message-ID: <201007061335.00264.arnd@arndb.de>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de> <20100705195837.GF5240@nowhere> <1278378690.3070.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278378690.3070.6.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, autofs@linux.kernel.org

On Tuesday 06 July 2010, Ian Kent wrote:
> So it makes no difference whether the patches are combined, if it breaks
> autofs then it probably won't be fixed but it may cause the replacement
> to happen sooner.

Well, the main point of applying the patch now is to avoid breaking the
autofs module when we remove the .ioctl operation.

> As far as the patch goes that should be fine and we should be able to
> remove the BKL from autofs4 soon after but I'm not brave enough to try
> just yet.

Well, the only use of the BKL in autofs4 is in the ioctl function. You
can probably replace that trivially with a global mutex, but from a quick
inspection, even that should not be needed: The only ioctl command in
autofs4 that does not already seem to have adequate locking is
autofs4_get_set_timeout, which is even easier to change and still harmless
if you don't do it at all.

	Arnd
