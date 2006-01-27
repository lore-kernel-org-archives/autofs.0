From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: some questions about the configuration
Date: Fri, 27 Jan 2006 15:38:47 +0100
Message-ID: <43DA3077.7090008@inria.fr>
References: <43D4F1E0.2060201@inria.fr>	<Pine.LNX.4.64.0601242036050.3037@eagle.themaw.net>	<43D8F3DE.5080003@inria.fr>
	<17369.661.597510.89926@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17369.661.597510.89926@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> Guillaume.Rousse> OK, I understand they have different nature, so they
> Guillaume.Rousse> can't have the exact same naming scheme. But if auto.=
smb
> Guillaume.Rousse> and auto.smb are exemple, they should not get install=
ed,
> Guillaume.Rousse> and especially not among configuration files whereas =
they
> Guillaume.Rousse> are executables programs.
>=20
> Guillaume.Rousse> I'd rather have called ldap.master.map, smb.user.map =
and
> Guillaume.Rousse> net.user.map, or something similar, and have them
> Guillaume.Rousse> installed in the same place.
>=20
> You can modify auto.net or auto.smb to suit your needs.  In that sense,
> they are user-configurable automounter maps, and belong with the other
> maps.  I understand that autofs configuration is a bit overwhelming, an=
d
> the documentation is lacking.  Perhaps we should focus on improving the
> documentation.
This does still look like a poor hack: if they are supposed to be=20
adaptable to specific user needs, they should use a configuration file.=20
And if the not flexible enough, be kept as exemples in congifuration,=20
not installed by default (especially if not automatically used).

And yes, documentation could get improved :)

>>>The master map and the maps that are contained in the master map have =
a
>>>different syntax.
>>>
>>>
>>>
>>>>Second, it's not clear why ldap and nis use are triggered from the
>>>>content of /etc/nsswitch.conf, while smb and net (simple rpcinfo
>>>>listing) use are triggered from content of /etc/auto.master. Shouldn'=
t
>>>>all those syntax be available from both locations?
>>>
>>>
>>>Master vs client maps again.
>=20
> Guillaume.Rousse> According to my init script understanding, however, i=
t
> Guillaume.Rousse> seems you can't refer to LDAP user maps from
> Guillaume.Rousse> /etc/auto.master, whereas you can refer to NIS user m=
aps
> Guillaume.Rousse> from there, using a syntax such as '+foobar', which i=
s
> Guillaume.Rousse> not documented in auto.master man page.
>=20
> Your understanding is wholly incorrect.  The following web sites are go=
od
> references that I use frequently.  I hope they are helpful to you.
>=20
> http://docs.sun.com/app/docs/doc/805-3479/6j3agk1v5?q=3Dautofs&a=3Dview
> http://docs.sun.com/app/docs/doc/816-0211/6m6nc66nc?a=3Dview
> http://www.ldapguru.com/modules/newbb/viewtopic.php?topic_id=3D2029&for=
um=3D6
Thanks for the explanation, I understand better. Let me rephrase:
- it is possible to refer to additional NIS master map from=20
/etc/auto.master, using a syntax not described in auto.master man page.
- it is not possible to do the same with ldap
Is this more correct ?


BTW, the default init script is quite ugly, it calls catnismap with each=20
additional NIS master map each time a line is found beginning with '+'.

I'd suggest instead something as:
if [ -f /etc/auto.master ] ; then
         awk '/^[^#]/{print $0}' /etc/auto.master | (
         while read line
         do
             if [[ "$line" =3D=3D +* ]]; then
                 catnismap ${line:1}
             else
                 echo $line
             fi
         done
         )
fi
It uses bash-specific constructs, but this is a bash script after all.
--=20
After assembly, it will always be observed that the gasket is on the benc=
h
		-- Assembly General Shefields Corollaries n=B04
