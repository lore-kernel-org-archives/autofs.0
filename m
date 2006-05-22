From: Daniel Qarras <dqarras@yahoo.com>
Subject: Re: AutoFS Problems with Laptops
Date: Mon, 22 May 2006 02:11:52 -0700 (PDT)
Message-ID: <20060522091152.51175.qmail@web36802.mail.mud.yahoo.com>
References: <44717133.3000304@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44717133.3000304@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> >> A script should just output the map entry without the key. Like
> >> -fstype=nfs,rw,soft,intr 10.0.0.1:/work
> > 
> > Unfortunately, this still creates (null) directory and I can even
> go to
> > /var/autofs/whatever to see contents of /work. And if the script
> > outputs both /work and /home I see only either of them, depending
> the
> > order the entries are printed and if they are on the same line or
> in
> > two lines.
> 
> That's interesting.
> 
> You mean you get a directory "(null)" with no mount?
> That shouldn't happen because the the "(null)" key shouldn't be found
> and so shouldn't have a mount entry associated with it. If the script
> needs to return a fail on the lookup it should return 1, 0 on
> success.

The "(null)" directory has contents of /home. I now modified the script
so that it is just like this:

#!/bin/sh
echo -fstype=nfs,rw,soft,intr 10.0.0.1:/home
echo -fstype=nfs,rw,soft,intr 10.0.0.1:/work

The (null) directory is visible when I say:

cd /var/autofs
ls

It also gave me access to /home via any directory but not to /work.
meaning that I see contents of /home via these directories:

/var/autofs/home
/var/autofs/test
/var/autofs/work

Cheers,

Dan.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
