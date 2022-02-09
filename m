From: "NeilBrown" <neilb@suse.de>
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
Date: Thu, 10 Feb 2022 08:59:48 +1100
Message-ID: <164444398868.27779.4643380819577932837@noble.neil.brown.name>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644443994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+pQpKmfzlL4KZk9ukchLsiAEhY7uRcrMQ98+/U4mU0=;
        b=eKSAQfQCWZPpF8fWc7728iUVKDG/8xR98p8nDijBvNvt52pynaLXqeR6sY965pMDlBeCSh
        y47AGd3E19xzvuYK3hmsDY2vyt8q82lsVhZ1yLRek+hq1U7Q9GqSagKaUoKQprx2Og5o1X
        P0UXuWCIwOPdupwNPVBjFWKy+D0lNzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644443994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+pQpKmfzlL4KZk9ukchLsiAEhY7uRcrMQ98+/U4mU0=;
        b=aTjHNUkIup75+LiMJuwnyqbqEqC8SAf4w30ZJjgGNhYFY3PSAwLywS8ZNNRUw+IYYeC5oZ
        OoIds/Y2hxOgKbCQ==
In-reply-to: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021, Ian Kent wrote:
> Hi all,
>=20
> It's time for a release, autofs-5.1.8.
>=20
...
> - also require TCP_REQUESTED when setting NFS port.

Unfortunately that last patch is buggy.  TCP_REQUESTED is masked out in
the caller.

Maybe the following is best.

NeilBrown

From: NeilBrown <neilb@suse.de>
Subject: [PATCH] Test TCP request correctly in nfs_get_info()

The TCP_REQUESTED flag is masked out by the caller, so it never gets to
nfs_get_info().
We can test if TCP was requested by examining the 'proto' parameter.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/modules/replicated.c b/modules/replicated.c
index 09075dd0c1b4..3ac7ee432e73 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -291,7 +291,7 @@ static unsigned int get_nfs_info(unsigned logopt, struct =
host *host,
=20
 	rpc_info->proto =3D proto;
 	if (port < 0) {
-		if ((version & NFS4_REQUESTED) && (version & TCP_REQUESTED))
+		if ((version & NFS4_REQUESTED) && (proto =3D=3D IPPROTO_TCP))
 			rpc_info->port =3D NFS_PORT;
 		else
 			port =3D 0;

