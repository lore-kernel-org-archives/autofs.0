From: Ian Kent <raven@themaw.net>
Subject: Re: AFS + LDAP
Date: Sat, 08 Jul 2006 13:23:29 +0800
Message-ID: <1152336210.2814.23.camel@raven.themaw.net>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
	<1152189192.8761.24.camel@raven.themaw.net>
	<20060706194023.GG32706@mail.iSKUNK.ORG>
	<1152236488.2922.19.camel@raven.themaw.net>
	<20060707170919.GI32706@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060707170919.GI32706@mail.iSKUNK.ORG>
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

On Fri, 2006-07-07 at 13:09 -0400, Daniel Richard G. wrote:
> On Fri, 2006 Jul 07 09:41:28 +0800, Ian Kent wrote:
> > 
> > OK. The existing code appears to call hes_resolve with just the
> > component of say yoav so that is the bit that would need to be stored as
> > the key in an alternate source.
> 
> Right. The semantics of the lookup are a bit different, but not enough to 
> be of concern here.
> 
> > Only to the extent that if you have existing records and you don't want
> > to convert them to the sun format. Ultimately something has to be feed
> > to a parser and hesoid and sun format parsers are all we have atm.
> 
> This would be a legacy-free installation, so my focus is on doing things 
> the Right Way(tm), whether new code is needed or not.
> 
> > > I was hoping for something more along the lines of an extension to the 
> > > standard NIS schema. (It's common for AFS sites to have each user's home 
> > 
> > Don't quite follow.
> > There are three schema in use about the place, the automount NIS schema,
> > rfc2307 and rfc2307-bis automount schema.
> > 
> > They all have objectclasses to hold automount keys and corresponding
> > mount information.
> 
> As I understand rfc2307, nisMap/nisObject/etc. is just a catch-all 
> mechanism for adding attributes not already covered by the schema. The RFC 
> advises against this approach in favor of defining new schemas as needed.
> 
> As for the automount schema (I assume this is samples/autofs.schema)... the 
> suggestion is that the necessary information should go into the 
> automountInformation attribute?

I always get confused with these names.
Never the less it appears that other implementations are moving toward
rfc2307-bis for LDAP based automount maps. I would make this the default
schema for version 5 except that we need to retain backward
compatibility with those that use what was the default in version 4.
It's easy enough to change in the config anyway.

Have a look at the version 5 config file for examples of the three
schema in common use.

> 
> The reason I'm leery of the Hesiod-record-in-an-LDAP-attribute approach 
> (and more generally, the everything-in-this-one-LDAP-attribute approach) is 
> that the string itself really represents what should be three or four 
> separate attributes. You can't [properly] administer or use that attribute 
> without a parser, and especially on the admin side, this is awkward.
> 
> > > be no lookup/parser disjunction. Should there be any issue with a backend 
> > > module that effectively does both tasks?
> > 
> > Not really, but maybe.
> > The entry point into this is the lookup module.
> > 
> > In version 4 and version 5 so far the lookup module for a map source is
> > called to find the mount data it then calls the parser module which in
> > turn calls the appropriate mount module.
> 
> I see. So the separation is not enforced; the daemon only knows about 
> lookup modules, and the modules can delegate however they wish.

Yes but this is driven by the map entry itself. For example a Sun format
entry like

etc	-fstype=nfs,rw    server:/dir

will lead to a call to the mount_nfs.c mount module.

Sun format mount (and to a lesser extent Hesiod format) tables are
widely used and we are striving for interoperability so a storage
mechanism with multiple attributes would not fit in very well from a
standardization point of view.

Ian
