From: Ian Kent <raven@themaw.net>
Subject: [PATCH 09/34] autofs-5.1.2 - honor last rw in mount options when
 doing a bind mount
Date: Mon, 24 Apr 2017 09:00:59 +0800
Message-ID: <149299565953.23475.5917060313247272073.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=gH/3hvQ9ditgyfgbE/
        SmYXXjNLl0mTqsCePdUKdv9ME=; b=caxnUv655inKzTI83NnVM3j1iJuXBwlFLr
        DX2NUsq7U+xmlHPHsHLn4bW057dhOlKUCN+miKW8eQkxheNFs9iHk9FsShOL7v89
        VCWB4azZATcNSlN114xIPVhtFbh8ywx3HiyPv4L78G/TQCb2zc33S6nHV1BBhY1p
        /K1nQZ6e8hV0LDE6XWLcHqTcajKDT96ggCT+SWLi4U+o+ZNuJQLHQy015guPQmNi
        FaqnqkZyCPS4uxfav9mJwt5dlAjcA7oGdLCACVGDZfGQGeCpu4lHEp6CHUJhnycy
        kIjA+3rl7x5BWyv2dGrfukbiwDMMsFJeVlYRiJ+Bl/6iUHfx8bkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=gH/3hvQ9ditgyfgbE/SmYXXjNLl0mTqsCePdUKdv9ME=; b=j88BgElE
        Ili5dATVyL8WIgzBOpWdcqTmw3YIR2NSbyMRuESoS1kTW3Y9A1Pg1WU19aa5L1Zn
        2JN33L32dOnxnwd/BjPOrYdUNb7gd67zTTNV9+/tjBoB22VN0ysYgdogq6Sdyz18
        DFi2soRL5eJz3D0zN5OD5jC6biVvJtOqCwp70YF4izLbKLMfCloHzWYC6porQgDv
        rtaWHLkHYy/4LJ1vOg1i1R+rJS4WlHg4+Hj4BPGP+Ca9eDXFdnUTsS+maewDTnqN
        ru55wa7kZBDLVdCXzPSeU0kX9t36WOTaJq0yJGSfwBJeSOUpKT7DiyE0kLSjLS0J
        PCaD35/WufzqGA==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: David Jeffery <djeffery@redhat.com>

mount(8) will use the last ro/rw option in its options list.
e.g. "mount -o ro,rw" will make a read-write mount while
"mount -o rw,ro" will make a read-only mount.

The patch changes the option parsing for mount_mount() in
modules/mount_nfs.c to clear the ro variable when a "rw"
option is seen. This will handle occurrences of both "ro"
and "rw" options, resulting in a read-only option being
passed to a bind mount only if the option order would also
have resulted in an nfs mount being read-only.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/mount_nfs.c |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 8eedad3..f841eaa 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -35,6 +35,7 @@ xx/xx/2016 autofs-5.1.3
 - check NFS server availability on local mount fallback.
 - make set_direct_mount_catatonic() more general.
 - set autofs mounts catatonic at exit.
+- honor last rw in mount options when doing a bind mount.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 2712140..c558a73 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -180,6 +180,8 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 				   with bind mounts */
 				else if (_strncmp("ro", cp, o_len) == 0)
 					ro = 1;
+				else if (_strncmp("rw", cp, o_len) == 0)
+					ro = 0;
 				/* and jump over trailing white space */
 				memcpy(nfsp, cp, comma - cp + 1);
 				nfsp += comma - cp + 1;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
