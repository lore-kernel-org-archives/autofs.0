From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/8] vfs - change d_manage() to take a struct path
Date: Wed, 19 Oct 2016 12:40:31 -0700
Message-ID: <20161019124031.94a44fbdd0970989f05d1893@linux-foundation.org>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

On Tue, 11 Oct 2016 13:33:52 +0800 Ian Kent <raven@themaw.net> wrote:

> For the autofs module to be able to reliably check if a dentry is a
> mountpoint in a multiple namespace environment the ->d_manage() dentry
> operation will need to take a path argument instead of a dentry.

This patchset contains lots of ViroStuff.  I'll queue it up for some
testing and will go into wait-and-see mode.

Some patches had an explicit From: Ian Kent <ikent@redhat.com> and some
did not.  I assumed that this was intended for all patches.  So all
patches now have different From: and Signed-off-by: email addresses. 
Unclear if this was your intent ;)


