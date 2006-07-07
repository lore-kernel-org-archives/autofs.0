From: Ian Kent <raven@themaw.net>
Subject: Re: AFS + LDAP
Date: Fri, 07 Jul 2006 09:41:28 +0800
Message-ID: <1152236488.2922.19.camel@raven.themaw.net>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
	<1152189192.8761.24.camel@raven.themaw.net>
	<20060706194023.GG32706@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060706194023.GG32706@mail.iSKUNK.ORG>
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
To: "Daniel Richard G." <skunk@iskunk.org>
Cc: autofs@linux.kernel.org

On Thu, 2006-07-06 at 15:40 -0400, Daniel Richard G. wrote:
> On Thu, 2006 Jul 06 20:33:12 +0800, Ian Kent wrote:
> > 
> > I'm not familiar with the hesoid system but I assume that in the record
> > above we have:
> > 
> > AFS -> filesystem type
> > /afs/athena.mit.edu/user/y/o/yoav -> filesystem
> > w -> read/write option rw
> 
> Aye, that's right.
> 
> > The last field is confusing but it may be the key used by hes_resolve?
> > If so for autofs it would not normally be a path but a component such as
> > yoav here.
> 
> It's the mount point, actually. The original way of working is that you 
> would mount the volume by invoking "attach sipb" or "attach yoav", without 
> reference to a base path. /mit is the usual location, but some special 
> volumes (e.g. for system software) mount elsewhere in the filesystem.

OK. The existing code appears to call hes_resolve with just the
component of say yoav so that is the bit that would need to be stored as
the key in an alternate source.

> 
> > So you could store this in LDAP by one of the schema such as the NIS
> > schema by setting attributes for a distinguished name like:
> > 
> [...]
> > 
> > cn: yoav
> > nisMapEntry: AFS /afs/athena.mit.edu/user/y/o/yoav w
> > 
> [...]
> > 
> > There's a fair bit of detail left out because I'm not sure about it so
> > there would have to be some trial and error. But the ",hesoid" will send
> > the entry to the hesoid parser instead of the sun parser in the same way
> > as the hesoid lookup module does.
> 
> Hmm. So it would basically be a Hesiod record stuffed into an LDAP 
> attribute... and (if I understand correctly) autofs is currently limited to 
> this sort of approach as _something_ ultimately has to be fed to the Hesiod 
> parser.

Only to the extent that if you have existing records and you don't want
to convert them to the sun format. Ultimately something has to be feed
to a parser and hesoid and sun format parsers are all we have atm.

> 
> I was hoping for something more along the lines of an extension to the 
> standard NIS schema. (It's common for AFS sites to have each user's home 
> directory be a separately mountable volume, so having some sort of 
> user-volume equivalence in LDAP is reasonable.)

Don't quite follow.
There are three schema in use about the place, the automount NIS schema,
rfc2307 and rfc2307-bis automount schema.

They all have objectclasses to hold automount keys and corresponding
mount information.

> 
> I take it something like this would require new code to support, then? And 
> how would this work---pulling data from LDAP, but not doing any parsing per 
> se (as the information is already broken out into attributes); there would 
> be no lookup/parser disjunction. Should there be any issue with a backend 
> module that effectively does both tasks?

Not really, but maybe.
The entry point into this is the lookup module.

In version 4 and version 5 so far the lookup module for a map source is
called to find the mount data it then calls the parser module which in
turn calls the appropriate mount module.

You need to be careful not to implement something that is specific to
what you require rather than something that general and that others may
benefit from. Otherwise we would end up with a bunch of limited function
modules.

The feeling is that this design is inflexible and it will be redesigned
at some point.

Ian
