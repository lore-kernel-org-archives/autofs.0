From: Steffen Grunewald <steffen.grunewald@aei.mpg.de>
Subject: Re: Automounting on /. deleting entire FS!
Date: Mon, 11 Oct 2004 19:00:11 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20041011170010.GI27189@debian-server.aei.mpg.de>
References: <20041011152938.GL21585@lego.fgm.com>
	<16746.43302.434588.743693@segfault.boston.redhat.com>
	<20041011160135.GM21585@lego.fgm.com>
	<16746.45101.876872.951336@segfault.boston.redhat.com>
	<20041011162927.GN21585@lego.fgm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041011162927.GN21585@lego.fgm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: Martin Fick <fick@fgm.com>
Cc: autofs@linux.kernel.org

On Mon, Oct 11, 2004 at 12:29:27PM -0400, Martin Fick wrote:
> > Nothing is in /etc/ on your old root partition?  I don't see anything=
 in
> > the autofs code that would remove an entire directory hierarchy plus =
its
> > contents.
> Well, I don't have acces to the system here, I am at work,
> but I didn't see any files, just a few vacant directories
> left such as:
>=20
> 	/bin (maybe)
> 	/dev
> 	/etc
> 	/home/fick (my home dir, empty!)
> 	/mnt
> 	/usr (was mounted externally)

Looks like the contents of fs cache.=20
You might try to find out what's there (from single user best, but
another root partition would do too) using df. Make sure to first mount
read-only, then (when you can see everything is somehow still alive)
remount rw. fsck'ing may be a Very Bad Idea. If you can see files it'd
be a good idea to do some kind of backup (if it works, you won't need it
afterwards in 99% of all cases) before going rw.

There's still hope.

Cheers,
 Steffen

(BTW, it's a quite common trap, almost as efficient as chown -R xyz .*)

> I had assumed at first that it was something like what you
> suggested and so I simply rebooted into the other partition
> and was shocked to find that nothing came back!

??? so you started another kernel and gave it the root=3D... arg?
Then of course automount would be running before you can do anything...
there's perhaps even more hope than you'd expect!

--=20
Steffen Grunewald * * * Merlin cluster admin (http://pandora.aei.mpg.de)
Albert-Einstein-Institut (MPI Gravitationsphysik, http://www.aei.mpg.de)
       Science Park Golm, Am M=FChlenberg 1, 14476 Potsdam, Germany
e-mail: steffen.grunewald(*)aei.mpg.de * +49-331-567-{fon:7233,fax:7298}
