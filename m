From: Geoff Mishkin <gmishkin@acs.bu.edu>
Subject: Re: embedded spaces in automounter map options field
Date: Wed, 18 Aug 2004 10:02:57 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200408181003.05973.gmishkin@acs.bu.edu>
References: <200408171008.26436.gmishkin@acs.bu.edu>
	<Pine.LNX.4.58.0408181723030.15856@wombat.indigo.net.au>
Reply-To: gmishkin@bu.edu
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408181723030.15856@wombat.indigo.net.au>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: Text/Plain; charset="us-ascii"
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It's autofs version 4.1.3.

			--Geoff Mishkin <gmishkin@bu.edu>


On Wednesday 18 August 2004 05:23 am, you wrote:
> On Tue, 17 Aug 2004, Geoff Mishkin wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > I have a situation that requires me to have embedded spaces in the
> > options field of my automounter map.  To make things trickier, the map
> > has to be generated with an executable map.  I am using shfs and have to
> > use it's cmd mount option to force it to connect using a specific private
> > key file.  This requires there to be embedded spaces in the options
> > field, like this:
> >
> > - -fstype=shfs,cmd="ssh -i /usr/keys/<username> <username>@<host>"
> >
> > Which causes the automounter to complain bitterly.  Most of the
> > information I've found is for having spaces in share names or mount
> > points, but the advice given doesn't work in the options field.  I've
> > tried all kinds of quotes, backslashing, etc.  I'd greatly appriciate
> > help.
> >
> > Please CC me on replies as I am not subscribed to the list.
>
> You don't say which version of autofs you are using?
>
> Ian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBI2GYpH0X57UnVFoRAm4pAJ4lmMn2c3Z0i1sHqEg39zlEhjVf3QCfWtlO
nWWAmp6dNEY/HYgKtQNzcjQ=
=YPe4
-----END PGP SIGNATURE-----
