From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs 3.1.7 -> 4.1.0-beta2
Date: Thu, 11 Dec 2003 14:45:47 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0312111443220.16200-100000@wombat.indigo.net.au>
References: <3FD7F99C.6030609@kmaclub.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FD7F99C.6030609@kmaclub.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Blandford <michael@kmaclub.com>
Cc: autofs@linux.kernel.org

On Wed, 10 Dec 2003, Michael Blandford wrote:

> Ian Kent wrote:
>
> >Could you try this patch please.
> >
> >I'll add it to my source rpm at kernel.org if it works OK for you.
> >You will need to grab a src rpm, build it, install the bin, got to the rpm
> >build directory and do make clean, apply the patch, and make then make
> >install. Be aware this will toast youre autofs init script, auto.master
> >and auto.net (if you have changed them.
> >
> >
> >
>
> I used this patch all day and haven't had any problems with it.  It
> seems good to me.
>

Thanks, I'll put it with the 4.1.0 tar and add it to the source rpm (that
will be a -2) at kernel.org.


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
