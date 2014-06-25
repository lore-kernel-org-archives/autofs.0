From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs4 - fix false positive compile error
Date: Wed, 25 Jun 2014 13:06:48 -0700
Message-ID: <20140625130648.1e3cd0e578602918dc38bb6a@linux-foundation.org>
References: <20140625124939.31035.84884.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20140625124939.31035.84884.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 25 Jun 2014 20:49:39 +0800 Ian Kent <raven@themaw.net> wrote:

> On strict build environments we can see:
> 
> fs/autofs4/inode.c: In function 'autofs4_fill_super':
> fs/autofs4/inode.c:312: error: 'pgrp' may be used uninitialized in this
> function
> make[2]: *** [fs/autofs4/inode.o] Error 1
> make[1]: *** [fs/autofs4] Error 2
> make: *** [fs] Error 2
> make: *** Waiting for unfinished jobs....
> 
> This is due to the use of pgrp_set being used to indicate pgrp has
> has been set rather than initializing pgrp itself.
> 

Yes, that code seems to be explicitly designed to trigger a gcc warning ;)

What is a "strict build environment"?  Someone's using -Werror for the
entire kernel?  That must make for a miserable life.


