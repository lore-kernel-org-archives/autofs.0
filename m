From: Ian Kent <raven@themaw.net>
Subject: Re: automount
Date: Tue, 3 Feb 2004 20:41:12 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402032038390.4761@raven.themaw.net>
References: <200402022049.10239.Joerg.Fichter@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200402022049.10239.Joerg.Fichter@gmx.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: =?iso-8859-1?q?J=F6rg=20Fichter?= <Joerg.Fichter@gmx.de>
Cc: autofs@linux.kernel.org

On Mon, 2 Feb 2004, [iso-8859-1] J=F6rg Fichter wrote:

> Dear Sirs,
>=20
> I've installed the automount system on my PC. Different user works on t=
his=20
> terminal! So I modified the auto.master file like this:
>=20
> /misc	/etc/auto.misc		user, exec, uid=3D700, gid=3D500

Can't at the moment.

The user option is only supported by mount when present in the fstab.

I posted a message to the util-linux list but haven't followed up on this=
.=20
I've been to busy.

Ian
