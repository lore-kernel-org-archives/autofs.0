From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Wed, 30 Nov 2016 14:22:44 -0800
Message-ID: <20161130142244.57bc0d853bcb194d2fba3856@linux-foundation.org>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

So a far as I can tell, this patch series is intended to
address Al's review comments against the
http://lkml.kernel.org/r/20161011053352.27645.83962.stgit@pluto.themaw.net
series?
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
