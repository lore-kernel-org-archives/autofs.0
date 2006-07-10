From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: AFS + LDAP
Date: Sun, 9 Jul 2006 22:27:31 -0400
Message-ID: <20060710022731.GG7333@mail.iSKUNK.ORG>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
	<1152189192.8761.24.camel@raven.themaw.net>
	<20060706194023.GG32706@mail.iSKUNK.ORG>
	<1152236488.2922.19.camel@raven.themaw.net>
	<20060707170919.GI32706@mail.iSKUNK.ORG>
	<1152336210.2814.23.camel@raven.themaw.net>
	<20060708075345.GA7333@mail.iSKUNK.ORG>
	<1152373694.2814.54.camel@raven.themaw.net>
	<20060709053504.GF7333@mail.iSKUNK.ORG>
	<20060709125924.GC27033@uranos.quantum.physik.uni-potsdam.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060709125924.GC27033@uranos.quantum.physik.uni-potsdam.de>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>

On Sun, 2006 Jul 09 14:59:24 +0200, Timo Felbinger wrote:
> 
> Sorry for bursting into your conversation and bringing up an old
> issue again, but it seems to be quite related to this discussion:
> 
> A while ago I did suggest a generalized syntax for LDAP map names,
> by implementing an already existing standard: LDAP URLs as in rfc2255.
> This would be more a "meta"-standard, as it does not enforce any
> specific schema, but allow one to use arbitrary schemas, encoded
> into the map name. So far, I used to think in terms of schemas with
> just two relevant attributes (automount key and information), but I
> actually start to like the idea of splitting automountInformation
> into several attributes.

Hmm... so this lets you encode information that would otherwise go into 
autofs.conf (DEFAULT_{MAP,ENTRY,VALUE}_ATTRIBUTE et al.) and ldap.conf in 
the ldap:// URL itself, eh? I take it the real power comes when you pull 
the map entry itself via LDAP, so that you can effectively reconfigure a 
large number of machines with a single database commit.

> The current map name format would be subset of the URL syntax, so
> compatibility could be preserved.
> 
> I submitted a patch for autofs4 (http://timof.qipc.org/autofs), which
> however didn't make it into autofs5. I understand that this would be
> an ambitious change, and bringing other parts of autofs up to standard
> was probably more urgent; however, it could give plenty of room for
> future improvements (like the evolution of a new standard schema), while
> staying compatible with traditional schemas (at least, I don't see any
> fundamental issues here), so I would still like to hear your opinions
> about implementing this in a future version?

Provided that automountInformation can be broken up, it's an interesting 
approach to hashing out a standard schema. I'm not sure, however, that it's 
a sufficiently flexible one.

The three existing LDAP schemas are easily parameterized---and they are so 
in the default autofs.conf file---but that works because they all have an 
automountInformation catch-all (or its equivalent). When you break that up, 
you get into the question of how the multiple attributes corresponding to 
it should be structured, which is rather open-ended. Certainly I'd prefer 
to tackle such a problem in code, just to avoid any possible constraint 
that a previously-devised parameterization scheme might impose.

> ...btw:
> 
> On Thu, Jul 06 2006 at 15:40:24 -0400, Daniel Richard G. wrote:
> >
> > I was hoping for something more along the lines of an extension to the??
> > standard NIS schema. (It's common for AFS sites to have each user's home??
> > directory be a separately mountable volume, so having some sort of??
> > user-volume equivalence in LDAP is reasonable.)?
> 
> If I understand this correctly (I'm not familiar with AFS), this is pretty
> much the reason why I started to patch lookup_ldap.c in the first place:
> to pull automount information from user account entries (rather than from
> an independent hierarchy), with the "uid" attribute used as the autmountKey,
> when mounting user directories. Seems the natural way of doing it to me.

Oh, absolutely. In fact, I'd been thinking of having non-user volumes live 
in the database as user-like entities, to avoid the separate table, and 
acknowledge the parallels between the two. (Non-user volume records would, 
for the most part, just have a subset of a user's attributes.)

Isn't it possible to do what you describe, however, just by remapping the 
appropriate LDAP attributes in /etc/libnss-ldap.conf? I've haven't tried 
this yet, but I believe you could specify something like

	nss_map_attribute automountKey uid

and with an appropriate automountInformation attribute in each user record, 
autofs would never know the difference.


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
