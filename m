From: Ian Kent <raven@themaw.net>
Subject: Re: making the mountpoints visible all the time (fwd)
Date: Sat, 22 Nov 2003 15:19:43 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0311221515290.2992-100000@raven.themaw.net>
References: <3FBE6DEF.5020202@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FBE6DEF.5020202@zytor.com>
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

On Fri, 21 Nov 2003, H. Peter Anvin wrote:

> Ian Kent wrote:
> > 
> > The above works that way without the update.
> > 
> > I'm not sure that a periodic update really gets us much. Since in most
> > sites maps change infrequently.
> > 
> > On the other hand at work we run a cron every night on all our machines to
> > trigger an update of the maps.
> > 
> > So I'm on the fence here?
> > 
> 
> Oh yes, a lot of map types support querying "has a change occurred"
> (usually in the form of a generation number, or in the case of a file
> map, the mtime.)  This absolutely should be taken advantage of.

Like the netid (or whatever it's called in NIS).

Not sure about LDAP.
I seem to remember some timestamps live in each entry. I'll need to check.

> 
> (For a program map, this complicates the protocol somewhat.  I don't
> know necessarily of the best way to deal with that.  It needs some
> thinking :)

A hard one I think.

I read the entire map to often as it is so I need to come up with 
something.

This is shaping up to be quite an interesting proprosal.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
