From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: AFS + LDAP
Date: Sat, 8 Jul 2006 03:53:45 -0400
Message-ID: <20060708075345.GA7333@mail.iSKUNK.ORG>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
	<1152189192.8761.24.camel@raven.themaw.net>
	<20060706194023.GG32706@mail.iSKUNK.ORG>
	<1152236488.2922.19.camel@raven.themaw.net>
	<20060707170919.GI32706@mail.iSKUNK.ORG>
	<1152336210.2814.23.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1152336210.2814.23.camel@raven.themaw.net>
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

On Sat, 2006 Jul 08 13:23:29 +0800, Ian Kent wrote:
> 
> I always get confused with these names.
> Never the less it appears that other implementations are moving toward
> rfc2307-bis for LDAP based automount maps. I would make this the default
> schema for version 5 except that we need to retain backward
> compatibility with those that use what was the default in version 4.
> It's easy enough to change in the config anyway.
>
> Have a look at the version 5 config file for examples of the three
> schema in common use.

I have to agree that rfc2307-bis looks like the most straightforward of the 
lot. (Shouldn't the tarball bundle a copy of the automount portion of that 
schema?)

> > I see. So the separation is not enforced; the daemon only knows about 
> > lookup modules, and the modules can delegate however they wish.
> 
> Yes but this is driven by the map entry itself. For example a Sun format
> entry like
> 
> etc	-fstype=nfs,rw    server:/dir
> 
> will lead to a call to the mount_nfs.c mount module.

"However they wish" was a bit cavalier; of course the modules obey the map
:)

> Sun format mount (and to a lesser extent Hesiod format) tables are
> widely used and we are striving for interoperability so a storage
> mechanism with multiple attributes would not fit in very well from a
> standardization point of view.

And this is the crux of the matter. The present approach seems to be to 
continue using these old Sun/Hesiod tables, only accessed in a different 
form. Hasn't anyone [with some clout] proposed something along more 
"modern" lines?

It's easy to conceive of a multi-attribute schema that could subsume NFS 
and AFS mappings, and others as well. For example...

	automountKey: foo
	automountType: nfs
	automountHost: budgie
	automountPath: /usr/local/foo
	automountWritable: true

	automountKey: bar
	automountType: afs
	automountHost: parakeets.com	(AFS cell name)
	automountPath: /afs/parakeets.com/users/bar
	automountWritable: no

	automountKey: qux
	automountType: device
	automountFormat: xfs
	automountPath: /dev/sda5
	automountWritable: yes

	etc.

(This was more or less what I had in mind for a schema that obviated the 
need for parsing---none of those attributes have to be chopped up.)

Interoperability is a concern, true. But a precise schema would be a win in 
an all/mostly-Linux network, the BSDs would probably follow suit if it were 
good enough, and for everyone else there's always program maps....

(Would appreciate comments on this, as I'm only speculating)


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
