From: Ian Kent <raven@themaw.net>
Subject: Re: AFS + LDAP
Date: Sat, 08 Jul 2006 23:48:13 +0800
Message-ID: <1152373694.2814.54.camel@raven.themaw.net>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
	<1152189192.8761.24.camel@raven.themaw.net>
	<20060706194023.GG32706@mail.iSKUNK.ORG>
	<1152236488.2922.19.camel@raven.themaw.net>
	<20060707170919.GI32706@mail.iSKUNK.ORG>
	<1152336210.2814.23.camel@raven.themaw.net>
	<20060708075345.GA7333@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060708075345.GA7333@mail.iSKUNK.ORG>
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

On Sat, 2006-07-08 at 03:53 -0400, Daniel Richard G. wrote:

> And this is the crux of the matter. The present approach seems to be to 
> continue using these old Sun/Hesiod tables, only accessed in a different 
> form. Hasn't anyone [with some clout] proposed something along more 
> "modern" lines?
> 
> It's easy to conceive of a multi-attribute schema that could subsume NFS 
> and AFS mappings, and others as well. For example...
> 
> 	automountKey: foo
> 	automountType: nfs
> 	automountHost: budgie
> 	automountPath: /usr/local/foo
> 	automountWritable: true
> 
> 	automountKey: bar
> 	automountType: afs
> 	automountHost: parakeets.com	(AFS cell name)
> 	automountPath: /afs/parakeets.com/users/bar
> 	automountWritable: no
> 
> 	automountKey: qux
> 	automountType: device
> 	automountFormat: xfs
> 	automountPath: /dev/sda5
> 	automountWritable: yes
> 

We would probably need a couple of other attributes, say for mount
options other than read/write.

> 	etc.
> 
> (This was more or less what I had in mind for a schema that obviated the 
> need for parsing---none of those attributes have to be chopped up.)
> 
> Interoperability is a concern, true. But a precise schema would be a win in 
> an all/mostly-Linux network, the BSDs would probably follow suit if it were 
> good enough, and for everyone else there's always program maps....
> 
> (Would appreciate comments on this, as I'm only speculating)

Interesting proposal.

Right row (and for quite a long time) I've been most concerned with
bringing the current autofs feature set up to par with functionality of
other industry standard products. This is where the interoperability
bent comes from and so haven't really thought about doing it better. The
other reason that interoperability is so important to me is that Linux
autofs must be able to fit into mixed vendor sites with minimal hassle
for the admin as the heaviest autofs users tend to have such
environments. In fact this one of the reasons I took up maintenance of
the package.

But it's getting there now so in the not so distant future a project
like this would be a great idea. I think it's likely to be a little
bigger task than you my be thinking. Perhaps your thinking a proof of
concept module(s) might be a good idea at this stage. And then
discussion about how the schema might need to change.

Just thinking about this is quite strange.
Linux autofs has been behind the pack for so long that to suddenly be
considering how the service could do things better and possibly
establish the standard in time to come is really weird.

Never the less I can't see us getting much support for such a proposal
unless Linux autofs is at least providing all the existing expected
functionality in a sound, stable and reliable way so I've still got my
hands full for at least a while.

Ian
