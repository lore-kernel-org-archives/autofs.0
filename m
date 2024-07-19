Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CD2913;
	Fri, 19 Jul 2024 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721352118; cv=none; b=fxqRVObII0l6WXZARNA97Ko+T0tTMDftQqIotBNRawaz1XJATv8P0hZydhFy5SjV8s3uDBMYFLOlCkwhYeZ5961V7MaQ5jKdNK5klKTtejS+rllcrBzInimiY4QbObe5t05mVTjTgwTPn7DykfsQYTaMg/X862rao6gOcIfEytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721352118; c=relaxed/simple;
	bh=E6oWbOjNtxqq/FWjAPQTzR0lneD+kp4p2M7q3oaH46g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdPxYUVBRExEIf8bsXdIZxMDN/7xyMKvpVfGOT3i5efS2keuX6eL3RSMeRoKkUOG3fV1X7BVZGOGX2n/en17vqmwfk4wSFJrtTIyGrKKLIdkLP+ywBlLqE2Qevp92lW4UDPqvvdNB+ljxIOXitdOvGh53kHz+usRraVqmSWVwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Sjij+jX/; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Sjij+jX/"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQBj62YyXz9stk;
	Fri, 19 Jul 2024 03:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1721352106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okbCHMpQFuxS3MErnCyY7unMZHEQPK4nYhZrC+nCYm4=;
	b=Sjij+jX/KNY9M9EDBvCvgVlvpIxhXJG/h8xQwcZf5fOiN+XQCbvgXaDWNzhZTjiUyNaiTL
	vNFYvYCZTuxmqOFry/ty55PUajPNTP+J0JqefP3yhgbeGRc+MUpZkQh9ALnQNaidNEiEOJ
	+aBtkmWYJSo0+7E0BQHvznD3ZXrfGy627Jcom84OLBP4B5zy7HvlXH4ZXJSkHex265dIeY
	jP5Vm76vYVPXADz9F525OdyanwO2V02HPRq8keVVUBhgNCARxkJLHLSY+EvBcwFXvrpmYM
	8yDdMVh5tjH2HNgBgC0BupOdY57TsQa4GgKauUogHorcSP9hzdJgxPLKgjYcjA==
Date: Fri, 19 Jul 2024 11:21:31 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: kernel test robot <lkp@intel.com>
Cc: Ian Kent <raven@themaw.net>, Bill O'Donnell <bodonnel@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Eric Sandeen <sandeen@redhat.com>, David Howells <dhowells@redhat.com>, 
	oe-kbuild-all@lists.linux.dev, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	codalist@coda.cs.cmu.edu
Subject: Re: [PATCH 2/2] coda: support FSCONFIG_SET_FD for fd mount flag
Message-ID: <20240719.012054-sad.combo.frozen.vibe-iRGqBcI4zDQb@cyphar.com>
References: <20240719-fsconfig-fsparam_fd-fixes-v1-2-7ccd315c2ad4@cyphar.com>
 <202407190741.8fA9KJbt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="do7lc52poc6dkn2n"
Content-Disposition: inline
In-Reply-To: <202407190741.8fA9KJbt-lkp@intel.com>
X-Rspamd-Queue-Id: 4WQBj62YyXz9stk


--do7lc52poc6dkn2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-19, kernel test robot <lkp@intel.com> wrote:
> Hi Aleksa,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on b80cc4df1124702c600fd43b784e423a30919204]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Aleksa-Sarai/autof=
s-fix-missing-fput-for-FSCONFIG_SET_FD/20240718-230056
> base:   b80cc4df1124702c600fd43b784e423a30919204
> patch link:    https://lore.kernel.org/r/20240719-fsconfig-fsparam_fd-fix=
es-v1-2-7ccd315c2ad4%40cyphar.com
> patch subject: [PATCH 2/2] coda: support FSCONFIG_SET_FD for fd mount flag
> config: arm-randconfig-003-20240719 (https://download.01.org/0day-ci/arch=
ive/20240719/202407190741.8fA9KJbt-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240719/202407190741.8fA9KJbt-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407190741.8fA9KJbt-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    fs/coda/inode.c: In function 'coda_parse_fd':
> >> fs/coda/inode.c:129:13: error: 'param' undeclared (first use in this f=
unction); did you mean 'parameq'?
>      129 |         if (param->type =3D=3D fs_value_is_file) {
>          |             ^~~~~
>          |             parameq
>    fs/coda/inode.c:129:13: note: each undeclared identifier is reported o=
nly once for each function it appears in
> >> fs/coda/inode.c:133:29: error: 'result' undeclared (first use in this =
function); did you mean 'mf_result'?
>      133 |                 file =3D fget(result->uint_32);
>          |                             ^~~~~~
>          |                             mf_result

D'oh. I compile tested it but this fs wasn't enabled in my config...

My bad.

> vim +129 fs/coda/inode.c
>=20
>    121=09
>    122	static int coda_parse_fd(struct fs_context *fc, int fd)
>    123	{
>    124		struct coda_fs_context *ctx =3D fc->fs_private;
>    125		struct file *file;
>    126		struct inode *inode;
>    127		int idx;
>    128=09
>  > 129		if (param->type =3D=3D fs_value_is_file) {
>    130			file =3D param->file;
>    131			param->file =3D NULL;
>    132		} else {
>  > 133			file =3D fget(result->uint_32);
>    134		}
>    135		if (!file)
>    136			return -EBADF;
>    137=09
>    138		inode =3D file_inode(file);
>    139		if (!S_ISCHR(inode->i_mode) || imajor(inode) !=3D CODA_PSDEV_MAJO=
R) {
>    140			fput(file);
>    141			return invalf(fc, "code: Not coda psdev");
>    142		}
>    143=09
>    144		idx =3D iminor(inode);
>    145		fput(file);
>    146=09
>    147		if (idx < 0 || idx >=3D MAX_CODADEVS)
>    148			return invalf(fc, "coda: Bad minor number");
>    149		ctx->idx =3D idx;
>    150		return 0;
>    151	}
>    152=09
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--do7lc52poc6dkn2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZpm/mwAKCRAol/rSt+lE
b95FAP4gdjRQXK5CbTmJcPujw06DkpWycW9hxPhlrHgb7FwyxAEA1vD9yI4XGgEl
48BqfCvUda6dVlyBk4J9L/JBLdF1jwk=
=5Uys
-----END PGP SIGNATURE-----

--do7lc52poc6dkn2n--
