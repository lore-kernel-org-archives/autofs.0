From: Ian Kent <raven@themaw.net>
Subject: Re: making the mountpoints visible all the time (fwd)
Date: Fri, 21 Nov 2003 14:59:36 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311211453250.6131-100000@wombat.indigo.net.au>
References: <3FBD6DA9.70204@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FBD6DA9.70204@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 20 Nov 2003, H. Peter Anvin wrote:

> Ian Kent wrote:
> >
> > To fit in with the existing framework I would need to require the entire
> > map returned for a NULL key.
> >
>
> That's correct.
>
> >
> >>And of course autofs needs to deal with the consequences of the map
> >>changing underneath it.
> >
> > I normally reread the map and try again on lookup failure. There is the
> > HUP signal to do a manual map reread.
> >
>
> A better option is probably to update periodically.  You still need to
> be able to handle query of a mount point that you don't know about
> (might have appeared anew) or a mount point you thought exist not being
> found.

The above works that way without the update.

I'm not sure that a periodic update really gets us much. Since in most
sites maps change infrequently.

On the other hand at work we run a cron every night on all our machines to
trigger an update of the maps.

So I'm on the fence here?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
