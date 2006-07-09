From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: AFS + LDAP
Date: Sun, 9 Jul 2006 01:35:04 -0400
Message-ID: <20060709053504.GF7333@mail.iSKUNK.ORG>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
	<1152189192.8761.24.camel@raven.themaw.net>
	<20060706194023.GG32706@mail.iSKUNK.ORG>
	<1152236488.2922.19.camel@raven.themaw.net>
	<20060707170919.GI32706@mail.iSKUNK.ORG>
	<1152336210.2814.23.camel@raven.themaw.net>
	<20060708075345.GA7333@mail.iSKUNK.ORG>
	<1152373694.2814.54.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1152373694.2814.54.camel@raven.themaw.net>
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
Cc: Ian Kent <raven@themaw.net>

On Sat, 2006 Jul 08 23:48:13 +0800, Ian Kent wrote:
> > 
> > 	automountKey: qux
> > 	automountType: device
> > 	automountFormat: xfs
> > 	automountPath: /dev/sda5
> > 	automountWritable: yes
> 
> We would probably need a couple of other attributes, say for mount
> options other than read/write.

This is why you want your standards written by some greybeard at Sun 
instead of a rabble-rouser like me :-)  Certainly here, there'd be a lot of 
ground to cover, corner cases and the like.

> Right row (and for quite a long time) I've been most concerned with
> bringing the current autofs feature set up to par with functionality of
> other industry standard products. This is where the interoperability
> bent comes from and so haven't really thought about doing it better. The
> other reason that interoperability is so important to me is that Linux
> autofs must be able to fit into mixed vendor sites with minimal hassle
> for the admin as the heaviest autofs users tend to have such
> environments. In fact this one of the reasons I took up maintenance of
> the package.

Absolutely no disagreement here.

> But it's getting there now so in the not so distant future a project
> like this would be a great idea. I think it's likely to be a little
> bigger task than you my be thinking. Perhaps your thinking a proof of
> concept module(s) might be a good idea at this stage. And then
> discussion about how the schema might need to change.

It's an intriguing idea, to allow a good "universal" schema to evolve.

I'm coming from the perspective of needing to support an organization, 
however, so this would go a bit beyond my mandate. I'd have to think about 
this, and gauge how well the idea of using a "prototype" schema would suit 
my colleagues.

> Just thinking about this is quite strange.
> Linux autofs has been behind the pack for so long that to suddenly be
> considering how the service could do things better and possibly
> establish the standard in time to come is really weird.

And that view in itself is a bit novel to me, seeing as how Linux in 
general seems to be getting the lion's share of new *nix features these 
days :)  (It doesn't hurt that autofs's userspace side seems eminently
hackable, too.)

> Never the less I can't see us getting much support for such a proposal
> unless Linux autofs is at least providing all the existing expected
> functionality in a sound, stable and reliable way so I've still got my
> hands full for at least a while.

It's a fair point, and your earlier comments make perfect sense in light of 
it. Though I'm still a bit surprised that my proposal wasn't something that 
you'd come across before, in one form or another.

Ian, kind thanks for expounding on the situation for me. You've given me a 
bit to think about. It does seem like a "six of one, half-dozen of the 
other" judgment call at this point in time.


Sincerely yours,


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
