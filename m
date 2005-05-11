From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs and dollar sign in hidden NT volumes
Date: Wed, 11 May 2005 15:05:02 -0400
Message-ID: <17026.22366.16278.577510@segfault.boston.redhat.com>
References: <428233B9.8080401@riu.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <428233B9.8080401@riu.com>
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
To: =?ISO-8859-1?Q?Xisco_Fern=E1ndez?= <fjfernandez@riu.com>
Cc: autofs@linux.kernel.org

=3D=3D> Regarding [autofs] autofs and dollar sign in hidden NT volumes; X=
isco Fern=E1ndez <fjfernandez@riu.com> adds:

fjfernandez> Hello list, I'm having some sort of problem w/ automount. I'=
m
fjfernandez> trying to automount hidden windows volumes (volume$), but th=
e
fjfernandez> dollar sign isn't being recognized by autofs.

fjfernandez> I am able to mount that share manually with mount.smbfs.  I =
am
fjfernandez> able to mount other non hidden shares with automount.

fjfernandez> It's not a credentials problem:

fjfernandez> auto.master:

fjfernandez> /mnt/auto /etc/auto.sgil --timeout=3D2

fjfernandez> auto.sgil:

fjfernandez> cdrom -fstype=3Diso9660,ro,nosuid,nodev :/dev/cdrom sgil
fjfernandez> -fstype=3Dsmbfs,username=3Druben,password=3Dtosidad,codepage=
=3Dcp850
fjfernandez> ://192.168.2.57/SGIL$

Please take a look at the "Filing bug reports" section of this page:

  http://people.redhat.com/jmoyer

Please provide the requested information, as it will  help us to debug yo=
ur
problem more easily.

Thanks,

Jeff
