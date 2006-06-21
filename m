From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] [PATCH] autofs4 needs to force fail return revalidate
Date: Wed, 21 Jun 2006 09:37:20 -0400
Message-ID: <x49irmuhbov.fsf@segfault.boston.redhat.com>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <200606210618.k5L6IFDr008176@raven.themaw.net> (Ian Kent's
 message of "Wed, 21 Jun 2006 14:18:15 +0800")
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: akpm@osdl.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

==> Regarding [autofs] [PATCH] autofs4 needs to force fail return revalidate; Ian Kent <raven@themaw.net> adds:

raven> Hi Andrew,

raven> I didn't get any adverse (or other feedback) for this patch after
raven> posting an RFC to LKML so here it is.

raven> For a long time now I have had a problem with not being able to
raven> return a lookup failure on an existsing directory. In autofs this
raven> corresponds to a mount failure on a autofs managed mount entry that
raven> is browsable (and so the mount point directory exists).

raven> While this problem has been present for a long time I've avoided
raven> resolving it because it was not very visible. But now that autofs v5
raven> has "mount and expire on demand" of nested multiple mounts, such as
raven> is found when mounting an export list from a server, solving the
raven> problem cannot be avoided any longer.

raven> I've tried very hard to find a way to do this entirely within the
raven> autofs4 module but have not been able to find a satisfactory way to
raven> achieve it.

raven> So, I need to propose a change to the VFS.

raven> Signed-off-by: Ian Kent <raven@themaw.net>

Acked-by: Jeff Moyer <jmoyer@redhat.com>

-Jeff
