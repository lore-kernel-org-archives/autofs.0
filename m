From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: some questions about the configuration
Date: Thu, 26 Jan 2006 17:07:58 +0100
Message-ID: <43D8F3DE.5080003@inria.fr>
References: <43D4F1E0.2060201@inria.fr>
	<Pine.LNX.4.64.0601242036050.3037@eagle.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601242036050.3037@eagle.themaw.net>
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
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

Ian Kent wrote:
> On Mon, 23 Jan 2006, Guillaume Rousse wrote:
>=20
>=20
>>I recently started to clean-up the mandriva autofs package a bit, and I
>>have some questions about the default configuration handling.
>>
>>First, it seems autofs-ldap-auto-master, which is installed in
>>/usr/lib/autofs, and auto.{net,smb}, which are installed in /etc, have
>>exactly the same purpose: to automatically produce a list of available
>>mount points from a remote host. If I am right, why are them installed
>>and named differently ? Apart the fact that the first one is native
>>code, whereas the others are shell scripts, they could as well get
>>installed as /usr/lib/autofs/auto.{ldap,smb,net}
>=20
>=20
> the autofs-ldap-auto-master reads the master map from an ldap server. O=
nly=20
> the master map.
>=20
> All the things in /usr/lib/autofs are system things, internal, whereas=20
> things in the map directory, often /etc are the user maps. The example=20
> program maps auto.smb and auto.net are, well, examples. Given a key the=
y=20
> return the entry for it. Neither returns master map entries.
OK, I understand they have different nature, so they can't have the
exact same naming scheme. But if auto.smb and auto.smb are exemple, they
should not get installed, and especially not among configuration files
whereas they are executables programs.

I'd rather have called ldap.master.map, smb.user.map and net.user.map,
or something similar, and have them installed in the same place.

> The master map and the maps that are contained in the master map have a=
=20
> different syntax.
>=20
>=20
>>Second, it's not clear why ldap and nis use are triggered from the
>>content of /etc/nsswitch.conf, while smb and net (simple rpcinfo
>>listing) use are triggered from content of /etc/auto.master. Shouldn't
>>all those syntax be available from both locations?
>=20
>=20
> Master vs client maps again.
According to my init script understanding, however, it seems you can't
refer to LDAP user maps from /etc/auto.master, whereas you can refer to
NIS user maps from there, using a syntax such as '+foobar', which is not
documented in auto.master man page.


--=20
The more work you have to get done, the more likely it is to rain.
		-- Precipitation Precepts n=B01
