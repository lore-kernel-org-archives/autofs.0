From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: stat -L triggering mount (behavior change starting
	with 2.6.38-rc1)
Date: Wed, 3 Aug 2011 11:16:41 -0300
Message-ID: <CAEySpB6XfZ-tZsVsxQ5BtsVgq+1BGwisOGr8tAsG6JSh9_rAVQ@mail.gmail.com>
References: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
	<1301632038.2880.11.camel@perseus> <2355.1301649598@redhat.com>
	<AANLkTin0X+F15LxXu8f4SVZEV=twHO9kf7=K+w2xj1eO@mail.gmail.com>
	<6929.1301668045@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=gvj2FGdKUaI5DueT/UYNAaz3ez7jPyTEVSIWwWhhm2g=;
	b=fweyaLWrpN26s1d5kYRKqyNy1/Al3TrGd37vy7IUSsGQfMcVtGHKJVSNslwfdkJZ3n
	2zNK/TMCgvci9Ro9jReYvC9NC3nUGk+GSh9ggzOHHwGfqYT9ttznkjt1B9w6KLNmwGoJ
	mF69ViiQNSitRaK2RclG6sHAACzOSXCrQomoU=
In-Reply-To: <6929.1301668045@redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org
Cc: David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>

On Fri, Apr 1, 2011 at 11:27 AM, David Howells <dhowells@redhat.com> wrote:
> Leonardo Chiquitto <leonardo.lists@gmail.com> wrote:
>
>> open("/data", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) =3D 3
>> fcntl(3, F_GETFD) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x1 (f=
lags FD_CLOEXEC)
>> getdents64(3, /* 3 entries */, 32768) =A0 =3D 72
>> lstat("/data/isos", {st_mode=3DS_IFDIR|0555, st_size=3D0, ...}) =3D 0
>> lgetxattr("/data/isos", "security.selinux", 0x62ad60, 255) =3D -1 EOPNOT=
SUPP (Operation not supported)
>> getxattr("/data/isos", "system.posix_acl_access", 0x0, 0) =3D -1 EOPNOTS=
UPP (Operation not supported)
>> getdents64(3, /* 0 entries */, 32768) =A0 =3D 0
>
> Yeah, I suspect the getxattr() is the problem. =A0ls calls libacl to get =
the
> Posix ACL of the target file, but that uses the getxattr() which asserts
> LOOKUP_FOLLOW during the pathwalk, causing the automount unconditionally:=
-/
>
> I'm discussing this with the coreutils and acl package maintainers to see=
 if
> we can fix it in userspace.

Just for reference (in case someone's looking for a solution for this
in the archives),
the problem was fixed by the following changes:

1. libacl: Add acl_extended_file_nofollow()

http://git.savannah.gnu.org/gitweb/?p=3Dacl.git;a=3Dcommitdiff;h=3D6bf5e24d=
48077db58b389e90558100fc121b8134
http://git.savannah.gnu.org/gitweb/?p=3Dacl.git;a=3Dcommitdiff;h=3Dad4ca5aa=
ee96e98b2e8e8a4351fa5e6c58d65216
http://git.savannah.gnu.org/gitweb/?p=3Dacl.git;a=3Dcommitdiff;h=3Debfeee80=
d4bffcbcbebcffb2f2d3db0427d01e2d

2. coreutils/gnulib: use acl_extended_file_nofollow if available

http://git.savannah.gnu.org/gitweb/?p=3Dgnulib.git;a=3Dcommitdiff;h=3D95f7c=
57ff4090a5dee062044d2c7b99879077808

Fixed packages are already available at least in the development versions of
openSUSE and Fedora.

Leonardo
