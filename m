From: Ian Kent <raven@themaw.net>
Subject: Re: making the mountpoints visible all the time (fwd)
Date: Fri, 21 Nov 2003 08:51:16 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311210848040.32325-100000@wombat.indigo.net.au>
References: <3FBB9E22.8090309@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FBB9E22.8090309@zytor.com>
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

On Wed, 19 Nov 2003, H. Peter Anvin wrote:

> Ian Kent wrote:
> >
> > That sounds good a good idea for inclusion in 4.1.1 (I have quite a list
> > already).
> >
> > Move the decision on what the map contains to the program map implementer.
> > That would be fairly straight forward to implement given that I have a
> > placeholder function in each map module.
> >
>
> Well, it's pretty much the only thing that makes sense, since a program
> map can inherently do "anything".
>
> Pretty much ghosting implies that there are now two operations required
> of a map: key->data lookup (old), and enumerate all keys (new).

To fit in with the existing framework I would need to require the entire
map returned for a NULL key.

>
> And of course autofs needs to deal with the consequences of the map
> changing underneath it.

I normally reread the map and try again on lookup failure. There is the
HUP signal to do a manual map reread.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
