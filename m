From: Steffen Grunewald <steffen.grunewald@aei.mpg.de>
Subject: Re: automount 4.1.3: unmount timeout not working
Date: Wed, 26 Jan 2005 16:20:37 +0100
Message-ID: <20050126152037.GX21479@debian-server.aei.mpg.de>
References: <20050122215228.GA14303@tangens.sinus.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050122215228.GA14303@tangens.sinus.cz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

On Sat, Jan 22, 2005 at 10:52:28PM +0100, Pavel Troller wrote:
> Hello to all the list members,
>   I decided to write to this list after a lot of time spent by trying t=
o
> find an answer for my question, but I didn't find any so I'm trying the=
 luck
> here.
>   I'm using automount 4.1.3 with kernel 2.6.10, but the problem appeare=
d
> formerly, with 2.6.7, and it's not directly related to the kernel, beca=
use it
> didn't appear with a kernel change, but with some other change in my sy=
stem
> or setup, which I cannot track down.

I also see this (Debian Sarge, installation done some weeks ago, package
version is 4.1.3-4). WIth an older installation (another Sarge), still us=
ing
3.9.99-4.0.0pre10-16, this doesn't show up.

>   The problem itself is that the autoumount doesn't unmount automatical=
ly after
> the timeout expires.

An upgrade to 4.1.3-8 apparently cured the problem; I don't know how
close the Debian package maintainer Steiner Gundersson works with autofs
people, and whether he's introduced some patches that have not been in
the previous version (and may have found their way into 4.1.4).
Sure, Debian Sarge is called "testing", that's what I'm doing, it's not
"stable" yet (but there's still hope), but I'd like to see a close
cooperation between the mainstream maintainers and the maintainers of
Linux distros...

Cheers,
 steffen

--=20
Steffen Grunewald * * * Merlin cluster admin (http://pandora.aei.mpg.de)
Albert-Einstein-Institut (MPI Gravitationsphysik, http://www.aei.mpg.de)
       Science Park Golm, Am M=FChlenberg 1, 14476 Potsdam, Germany
e-mail: steffen.grunewald(*)aei.mpg.de * +49-331-567-{fon:7233,fax:7298}
