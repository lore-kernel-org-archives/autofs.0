From: elw@stderr.org
Subject: Re: AFS + LDAP
Date: Sun, 9 Jul 2006 20:01:31 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0607092000200.5353@illuminati.stderr.org>
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
Content-Type: MULTIPART/MIXED; BOUNDARY="-163628792-414781352-1152493291=:5353"
Return-path: <autofs-bounces@linux.kernel.org>
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
To: Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>
Cc: autofs@linux.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---163628792-414781352-1152493291=:5353
Content-Type: TEXT/PLAIN; charset=unknown-8bit; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id k6DCv3db020320



>> I was hoping for something more along the lines of an extension to=20
>> the=AF=AB standard NIS schema. (It's common for AFS sites to have each=
=20
>> user's home=AF=AB directory be a separately mountable volume, so havin=
g=20
>> some sort of=AF=AB user-volume equivalence in LDAP is reasonable.)=AB
>
> If I understand this correctly (I'm not familiar with AFS), this is=20
> pretty much the reason why I started to patch lookup_ldap.c in the firs=
t=20
> place: to pull automount information from user account entries (rather=20
> than from an independent hierarchy), with the "uid" attribute used as=20
> the autmountKey, when mounting user directories. Seems the natural way=20
> of doing it to me.


The same problem is going to emerge with sites where home directories are=
=20
on Solaris ZFS volumes.

I'm probably going to handle it with a programmatic map, here, both on ou=
r=20
Solaris and Linux machines.  Hacking the program map we use now is easier=
=20
than reinventing the whole wheel, axle, and car....

--elijah
---163628792-414781352-1152493291=:5353
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

---163628792-414781352-1152493291=:5353--

