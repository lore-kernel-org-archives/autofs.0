From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/8] vfs - change d_manage() to take a struct path
Date: Thu, 27 Oct 2016 03:11:11 +0100
Message-ID: <20161027021111.GI19539@ZenIV.linux.org.uk>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
 <20161019124031.94a44fbdd0970989f05d1893@linux-foundation.org>
 <1477006776.3207.14.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477006776.3207.14.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Fri, Oct 21, 2016 at 07:39:36AM +0800, Ian Kent wrote:

> Maybe Al has been too busy to comment, he has been on the Cc from the start.

That's... a very mild version of what's been going on.  Let's just say that
the last few weeks had been really interesting.  Not that the shit has
settled, but there was some slackening in the shitstorm last few days.
Unlikely to last, I'm afraid, but...
 
> Hopefully this email will prompt a review, Al?

Aside of the Eric's note re constifying struct path (strongly seconded),
I'm not sure if expiration-related side of that is correct.  OTOH,
since the expiration happens from userland...

How much testing did it get?  I've several test setups involving
autofs, but they are nowhere near exhaustive and I don't have good
enough feel of the codebase to slap together something with decent
coverage...
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
