Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484F84409
	for <autofs@vger.kernel.org>; Fri, 28 Mar 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172555; cv=none; b=DxoHIYPS/qPxSxNg0M1URvtgLstJY5CP2wYz1TKdu848XVKSBoUhEvEW5F1lEVvfy3/2BUpA+yUdjduP/7rzU/zCZjeGMxeRWZnRUN6yP5qotMRkDJBLW4n+sbeK7ypQG6nEB+VwV6V5bz0b6V6R3kYuHCwt6WATO/nFfZnlNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172555; c=relaxed/simple;
	bh=QQjk7V08keGZmweqTHkAQOUv1KzpaE8TjLXAEKF/fbI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 In-Reply-To:To; b=pD4EdXRwvx0gw6pdj8X60MXJAap0wB2LZiCQ1Ss4O0SKHqFh8saQmphgTGXCzlGi4HrjuaFRx7YOtYfrQJ1P+xhO0ZBd0+QkvQgEfvK6jlpptwuba8OGyvxC12laL89ECE7DU6BhiFhmS5YkNe8k/9jCzTiDH6adGqxyHIXImgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benbuhse.email; spf=pass smtp.mailfrom=benbuhse.email; dkim=pass (2048-bit key) header.d=benbuhse.email header.i=@benbuhse.email header.b=NzXLDkAz; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benbuhse.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benbuhse.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benbuhse.email header.i=@benbuhse.email header.b="NzXLDkAz"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZPNNr46p3z9sDl
	for <autofs@vger.kernel.org>; Fri, 28 Mar 2025 15:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benbuhse.email;
	s=MBO0001; t=1743172540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCWfpUeyQ+XbmodXhBrswgh05E/F3TC+8/DdRHmeBTw=;
	b=NzXLDkAzq28erpQD7RaHyY8WubO6cqVeCHImEmvL8UokUiLHNrNyaiU0NF+rBkbrFb1eOl
	uxxwAkY6HCbW4BjpqLCJNKynUc+kc3DVJREzWIRnHiI23cckGJSh3MwHZmXlup0nmJOfCP
	p915BbkRpZKdpcTW2t02SkU0GmdSl/yiBvo6V8TtXHF3F1EcrToFUEkc5E+h6rykPrXozF
	dHIshkU3Jj/yBSfKhHqQA/H/v/zSmYJzZwOKLVEXy0XIAgeWB6uBNVPIh36q4R6/MF+1el
	luatMyaL5O5unkgFCB50BF7lOMl+stQSwF0RJtsIQzdD60TuzjrEKhqRK7zkkA==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Buhse <me@benbuhse.email>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] fix building on musl
Date: Fri, 28 Mar 2025 09:35:27 -0500
Message-Id: <B4BD04C2-EE56-4E81-97FA-8AE41292019A@benbuhse.email>
References: <20250221013910.13794-1-me@benbuhse.email>
In-Reply-To: <20250221013910.13794-1-me@benbuhse.email>
To: autofs@vger.kernel.org

Ping
Just wanted to check if this is something being considered at all, thanks.

> On Feb 20, 2025, at 19:40, Ben Buhse <me@benbuhse.email> wrote:
>=20
> =EF=BB=BFmusl 1.2.5 removed basename from string.h and only kept it in lib=
gen.h: https://git.musl-libc.org/cgit/musl/commit/?id=3D725e17ed6dff4d0cd224=
87bb64470881e86a92e7
> ---
> daemon/automount.c    | 20 +++++++++++++++-----
> daemon/master.c       |  1 +
> modules/lookup_file.c |  1 +
> 3 files changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/daemon/automount.c b/daemon/automount.c
> index 474b29a..5256426 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -21,6 +21,7 @@
>=20
> #include <dirent.h>
> #include <getopt.h>
> +#include <libgen.h>
> #include <signal.h>
> #include <stdio.h>
> #include <stdlib.h>
> @@ -2538,12 +2539,21 @@ int main(int argc, char *argv[])
>=20
>        lookup_nss_read_master(master_list, 0);
>        if (type) {
> -            const char *map =3D basename(name);
> -            if (!map)
> -                printf("%s: invalid map name %s\n",
> +            const char *map =3D NULL;
> +            char *name_dup =3D strdup(name);
> +            if (!name_dup) {
> +                printf("%s: failed to copy name %s for parsing\n",
>                    program, name);
> -            else
> -                dump_map(master_list, type, map);
> +            } else {
> +                map =3D basename(name_dup);
> +                if (!map)
> +                    printf("%s: invalid map name %s\n",
> +                        program, name);
> +                else
> +                    dump_map(master_list, type, map);
> +                free(name_dup);
> +                name_dup =3D NULL;
> +            }
>        } else
>            master_show_mounts(master_list);
>=20
> diff --git a/daemon/master.c b/daemon/master.c
> index f2c11e9..1455e40 100644
> --- a/daemon/master.c
> +++ b/daemon/master.c
> @@ -21,6 +21,7 @@
> #include <string.h>
> #include <memory.h>
> #include <limits.h>
> +#include <libgen.h>
> #include <signal.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> diff --git a/modules/lookup_file.c b/modules/lookup_file.c
> index 99f2e21..4914395 100644
> --- a/modules/lookup_file.c
> +++ b/modules/lookup_file.c
> @@ -15,6 +15,7 @@
>=20
> #include <stdio.h>
> #include <malloc.h>
> +#include <libgen.h>
> #include <stdlib.h>
> #include <string.h>
> #include <time.h>
> --
> 2.45.3
>=20
