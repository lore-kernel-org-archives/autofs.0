Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89117A305
	for <autofs@vger.kernel.org>; Fri, 22 May 2026 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429759; cv=none; b=cTFLcunTdklKIPKo0kDbc5/zhy6ZhC2KfdIWATzgf/E97rF2eOtRpmHlyobJguPp4PiWpzS8Tqca41vMVR3atqv6ytUTgSgDx9ubcZ4Y5lrY6y7mEWOHryu8XqzoXL/VDdRrCCfPyW31uxH+5YjI0KzQmGis+R6kTUkqM2AUeqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429759; c=relaxed/simple;
	bh=FtiKT+pNeRI0u6uhILI0subX8lgcGzhhRFqBdRXVadc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMsPfi0kvAMq8DPvaS/MvPeGcucVIgrK/ajdIb6crd4Y3D/950VrUJTZ/B2JC9+luZrHNHvUsF2aycJkA1eMOlwdsEKJ4MAgJxIxVxw2rRJ3FwuduEaAfg5VsfsWDQYwC9y+eWo0rspVOZI+XXD30OWUo2eGhrTy4HtLVRgNCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=NNWWYm5n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U3ZG3nDc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="NNWWYm5n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U3ZG3nDc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B98E7EC00AC;
	Fri, 22 May 2026 02:02:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 22 May 2026 02:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779429755;
	 x=1779516155; bh=FtiKT+pNeRI0u6uhILI0subX8lgcGzhhRFqBdRXVadc=; b=
	NNWWYm5nisZytCCfQ6ykXjlBpz2/CeKRzCM9lwegUNZsNpGCyPEl9dhlGVP8djfy
	R+vr7mow/QOTZaadRycg4MPd52yK/jYQS3PIBhRJOrUhtOvwN+8sTy552d/yE3g/
	smySO2pT8SlTXiPb/7UffeusLX280sWg55mJQszO0mKENJm8mkUf58kIJtDtAX/+
	cjT4v1LwXqigF5lTTQCcGR/JgSrsvxpXOqmn2VLSyQ3PtnKbSDnYF3ZJx02QZiPz
	YQmOGvbBDPL7Q8bLxa2A5JsbmP8Jqqnfqma2uqM4nbxo9dNsK9TIn8NJiuLBGT3l
	1/aNji3iYj8gmm11tTX3PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779429755; x=
	1779516155; bh=FtiKT+pNeRI0u6uhILI0subX8lgcGzhhRFqBdRXVadc=; b=U
	3ZG3nDc/HqHMNwunbcbm/LO500jhDWFkfPteXlr572kbzNEiqz/QsRJoH0m2W4tv
	MquKOnawN0E7fK129EHxb0o9o+6asrI+1VvswDySjw4NHvaUpm2L/hEJJkoF0h3F
	9QlG8+ry01uvkeevTf37TaAwlL9LL37AZtH6rE7p0K7SwS3Q0LMuAgs6WN6XN0yr
	TL/bUc80XCS+3+FxTL0hyVs2fz0zgBPNAjAflSmyJKnXp0pgvdijpOszAZyO0Z6O
	nHlHJgQRkXnN6TT+K4SIRZcAuXyaejWa41N7sAW3Ky0pdTGRgu3gSuCqA5w9kuvI
	udZSM2Yzk0dVsiWqZv/7g==
X-ME-Sender: <xms:e_EPangH0MIwKmS65AyvhpQEXpozXb6HQ-MLvb5QbDFSud33LdLHPg>
    <xme:e_EParC-Fy9cU5z53irUKWXOlOFs-dL6MPgIjkao4yXu27a7h-UmzNcPrJ7hT-YjJ
    eP3hhtsdlGBpHTLgm3Pm977iJT1QGpO3kFyS7gtzs1rFco>
X-ME-Received: <xmr:e_EPasFemDolPO1m8LxMzBxGHy7vPxc_RihbQivswZryEdAWESOyEVMkDs8REqtDO2VQIb2j5Lp1n8rC_YqRIndFFpsHHClaiO7oeJuQJ5oUmE6lUdDqat_ShQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnheptd
    evhfehtdeiffevfeeiteejveefieehtddvieeukeekgfeifeduueegfedtieejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegutghlihhnghgvrhesqhhurghltghomhhmrdgtohhmpdhrtghpthhtoh
    eprhhgohhlugifhihnsehsuhhsvgdruggvpdhrtghpthhtoheprghuthhofhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhiughonhhgrdiihhhonhhgsehsuh
    hsvgdrtghomh
X-ME-Proxy: <xmx:e_EPajLMDWkXjZnE-Lcb2v5NeuwTkrWFSThsxu9yUPFW0zt9ii4Zpw>
    <xmx:e_EPagkTrmea_8yl_RZ1AqwiP6VWIVQaM3q4zGBFnU0MCFJo2DyhiA>
    <xmx:e_EParR-GjN1zKllz8yqkM1B8qZQxpves19cxzppBVP5EKMyCkn25g>
    <xmx:e_EPaiK--P3MFGJBm-ybucrm24-oWF8oPvBBrw0M-1flSUehdvHDlw>
    <xmx:e_EPaoeEgKGcTPayZ7Jkk0XyDIm6l7ONfdnzGYpBESHldXu0WMQ7fZEE>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 02:02:33 -0400 (EDT)
Message-ID: <9887ef418082ea716e09337d28a2d0ec39480001.camel@themaw.net>
Subject: Re: Unable to set log priority for all direct mounts
From: Ian Kent <raven@themaw.net>
To: Deke Clinger <dclinger@qualcomm.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, autofs@vger.kernel.org, 
	lidong.zhong@suse.com
Date: Fri, 22 May 2026 14:02:29 +0800
In-Reply-To: <a1be8d50-dddb-2297-1e7f-512c37ca9214@qualcomm.com>
References: <agYonWw9_WVrWyub@zuko.lan>
	 <5047369f-b05b-402c-96a8-c957573a3ce3@themaw.net>
	 <a1be8d50-dddb-2297-1e7f-512c37ca9214@qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44app2) 
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-21 at 17:41 -0700, Deke Clinger wrote:
> Hi Ian,
>=20
> Thanks for fixing this, it was my request originally. It is super
> useful to be able to change the log level for the whole direct map
> with one command when that map is tens of thousands of entries long.

No problem Deke, it was a regression after all.

Goldwyn, I'll push this to the autofs repo. then.


Ian
>=20
> Regards,
>=20
> -Deke
>=20
> On Mon, 18 May 2026, Ian Kent wrote:
>=20
> > WARNING: This email originated from outside of Qualcomm. Please be
> > wary of any
> > links or attachments, and do not enable macros.
> >=20
> > On 15/5/26 04:01, Goldwyn Rodrigues wrote:
> > > Hello,
> > >=20
> > > Since the work to have a single FIFO file for setting log
> > > priority
> > > (16ea4156 ("autofs-5.1.8 - switch to application wide command
> > > pipe"), to
> > > be more precise 16ea4156 (autofs-5.1.8 - switch to application
> > > wide
> > > command pipe), automount has lost the ability to set the log
> > > priority of
> > > all direct mounts using the path "/-".
> > >=20
> > >=20
> > > # sudo automount -l info /-
> > > Could not find device id for mount /-
> > >=20
> > > This is because automount attempts to mount and get verifies the
> > > real
> > > path which is non-existent in case of direct mounts "/-".
> > >=20
> > > In the automount program, the log priority is set pretty early
> > > and much
> > > before the master map is setup. So we cannot check on the autofs
> > > dev
> > > either.
> > >=20
> > > What would be the best way to solve this? Should we just document
> > > it
> > > as a feature loss?
> > >=20
> >=20
> > Haven't actually tested this but it should work to fix the log
> > priority
> >=20
> > for /-.
> >=20
> > Could you give it a try please.
> >=20
> >=20
> > autofs-5.1.9 - fix handling of direct mount path in command handler
> >=20
> > From: Ian Kent <raven@themaw.net>
> >=20
> > Commit 16ea4156471e ("autofs-5.1.8 - switch to application wide
> > command
> > pipe") broke the ability to set the log priority from the command
> > line
> > for all direct mounts.
> >=20
> > As Goldwyn Rodrigues points out the autofs_point structure for
> > direct
> > mounts doesn't have a real mount associated with it so it needs
> > special
> > handling which was ommitted in commit 16ea4156471e.
> >=20
> > Fixes: 16ea4156471e ("autofs-5.1.8 - switch to application wide
> > command pipe")
> > Reported-By: Goldwyn Rodrigues <rgoldwyn@suse.de>
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> > =C2=A0CHANGELOG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 1 +
> > =C2=A0daemon/automount.c |=C2=A0=C2=A0 17 +++++++++++++++--
> > =C2=A0daemon/master.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +++++++++++
> > =C2=A0include/master.h=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 ++-
> > =C2=A04 files changed, 29 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/CHANGELOG b/CHANGELOG
> > index d6d594e9e..0fc529f32 100644
> > --- a/CHANGELOG
> > +++ b/CHANGELOG
> > @@ -89,6 +89,7 @@
> > =C2=A0- do_reconnect() expiry check of dclist BEFORE lookup using it.
> > =C2=A0- fix mailing list subscription address.
> > =C2=A0- fix table_lookup_ino() fd reference.
> > +- fix handling of direct mount path in command handler.
> >=20
> > =C2=A002/11/2023 autofs-5.1.9
> > =C2=A0- fix kernel mount status notification.
> > diff --git a/daemon/automount.c b/daemon/automount.c
> > index 517764119..a01d176ae 100644
> > --- a/daemon/automount.c
> > +++ b/daemon/automount.c
> > @@ -1487,7 +1487,13 @@ static void handle_cmd_pipe_fifo_message(int
> > fd)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ap =3D master_find_mapent_by_devi=
d(devid);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* There's no "real" devid for th=
e top level direct mount
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * container so we use -1.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (devid =3D=3D -1)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ap =3D master_find_mapent_by_path("/-");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ap =3D master_find_mapent_by_devid(devid);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ap) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 error(LOGOPT_ANY, "can't locate autofs_point for
> > device id
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 %ld.", devid);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> > @@ -1548,7 +1554,14 @@ static int set_log_priority(const char
> > *path, int
> > priority)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ops) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "Could not get ioctl ops\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -1;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* There's no "real" devid for th=
e top level direct mount
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * container so we use -1.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strcmp(path, "/-"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 devid =3D -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D ops->mount_device(LOGOPT_ANY, path, 0,
> > &devid);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret =3D=3D -1 || ret =3D=3D 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err,
> > diff --git a/daemon/master.c b/daemon/master.c
> > index d85dd8975..8b7450e73 100644
> > --- a/daemon/master.c
> > +++ b/daemon/master.c
> > @@ -711,6 +711,17 @@ struct master_mapent *master_find_mapent(const
> > char
> > *path)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > =C2=A0}
> >=20
> > +struct autofs_point *master_find_mapent_by_path(const char *path)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct autofs_point *ap =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct master_mapent *entry;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D master_find_mapent(path=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (entry)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ap =3D entry->ap;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ap;
> > +}
> > +
> > =C2=A0struct autofs_point *master_find_mapent_by_devid(dev_t devid)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct master *master =3D master_l=
ist;
> > diff --git a/include/master.h b/include/master.h
> > index 71610611f..3ca7ad8d6 100644
> > --- a/include/master.h
> > +++ b/include/master.h
> > @@ -105,7 +105,8 @@ void master_source_readlock(struct
> > master_mapent *);
> > =C2=A0void master_source_unlock(struct master_mapent *);
> > =C2=A0void master_source_lock_cleanup(void *);
> > =C2=A0struct master_mapent *master_find_mapent(const char *);
> > -struct autofs_point *master_find_mapent_by_devid(dev_t devid);
> > +struct autofs_point *master_find_mapent_by_path(const char *);
> > +struct autofs_point *master_find_mapent_by_devid(dev_t);
> > =C2=A0struct master_mapent *master_new_mapent(const char *, time_t);
> > =C2=A0void master_add_mapent(struct master_mapent *);
> > =C2=A0void master_remove_mapent(struct master_mapent *);
> >=20
> >=20
> >=20
> >=20
