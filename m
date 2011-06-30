From: Mag Gam <magawake@gmail.com>
Subject: Re: [autofs] [ANNOUNCE] autofs 5.0.6 release
Date: Thu, 30 Jun 2011 07:05:02 -0400
Message-ID: <BANLkTi=MC-KnaUxZdqT9OfQzfWhojjwBnw@mail.gmail.com>
References: <1309397821.3183.2.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=m46eZWUY4r1t9jvHpZZzTZEnO0yrbajtL84Q7mPDioI=;
        b=bejWKZz0hsaBuo/HZu8SSq7pphkzVjUxB/zxWo8+MIUVs3trIWVKh+NjqXV4TIyKXi
         8Dv5M7J6jZZ2B+vtMjrB9Dg7utSaM0/2Qw6KG3i47srclCnHjrofrhME38MH5Kq8hyfN
         bdMenJVeksyiwVMWpItLjzGSmq2oj3P4ovehA=
In-Reply-To: <1309397821.3183.2.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Ian,

Keep up the good work and thanks again for maintaining this.

We will wait for our distribution (RHEL) to backport these changes.

On Wed, Jun 29, 2011 at 9:37 PM, Ian Kent <raven@themaw.net> wrote:
> Hi all,
>
> This is long overdue, even so, I think there are still some things
> that need fixing but aren't clear cut. However there are too many
> patches to delay any longer so here is release 5.0.6.
>
> The kernel patches are not being updated any more because of the
> introduction of the vfs-automount changes to the VFS. If there
> are needs in this area we will need to discuss how to deal with
> them on the mailing list.
>
> Known issues (haven't changed since 5.0.5)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Quoted strings in the master map are still not yet handled.
> - There is a problem with "mount --move" in some releases of SuSE
> =C2=A0(perhaps other distributions as well) =C2=A0which can cause mou=
nts to
> =C2=A0not be moved correctly resulting in /etc/mtab continually growi=
ng
> =C2=A0due to invalid entries.
> - When the active restart is being used it will happily re-connect a
> =C2=A0mount that is unresponsive, perhaps because the server is not
> =C2=A0responding. A forced expire (USR1 signal) should be enough to c=
lean
> =C2=A0up.
>
> autofs
> =3D=3D=3D=3D=3D=3D
>
> The package can be found at:
>
> ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5
>
> It is autofs-5.0.6.tar.[gz|bz2]
>
> No source rpm is there as it can be produced by using:
>
> rpmbuild -ts autofs-5.0.6.tar.gz
>
> and the binary rpm by using:
>
> rpmbuild -tb autofs-5.0.6.tar.gz
>
> See the INSTALL file for information about configure options and
> kernel requirements.
>
> Here are the entries from the CHANGELOG which outline the updates:
>
> 28/06/2011 autofs-5.0.6
> -----------------------
> - fix included map read fail handling.
> - refactor ldap sasl bind handling.
> - add mount wait timeout parameter.
> - special case cifs escapes.
> - fix compile fail with when LDAP is excluded.
> - more code analysis corrections (and fix a typo in an init script).
> - fix backwards #ifndef INET6.
> - fix stale initialization for file map instance.
> - add "preen" fsck for ext4 mounts.
> - don't use master_lex_destroy() to clear parse buffer.
> - make documentation for set-log-priority clearer.
> - fix timeout in connect_nb().
> - fix pidof init script usage.
> - check for path mount location in generic module.
> - dont fail mount on access fail.
> - fix rpc fail on large export list.
> - fix memory leak on reload.
> - update kernel patches for 2.6.18 and 2.6.19.
> - dont connect at ldap lookup module init.
> - fix random selection option.
> - fix disable timeout.
> - fix strdup() return value check (Leonardo Chiquitto).
> - fix reconnect get base dn.
> - add missing sasl mutex callbacks.
> - fix get query dn failure.
> - fix ampersand escape in auto.smb.
> - add locality as valid ldap master map attribute.
> - add locality as valid ldap master map attribute fix.
> - add simple bind authentication.
> - fix master map source server unavailable handling.
> - add autofs_ldap_auth.conf man page.
> - fix random selection for host on different network.
> - make redhat init script more lsb compliant.
> - don't hold lock for simple mounts.
> - fix remount locking.
> - fix wildcard map entry match.
> - fix parse_sun() module init.
> - dont check null cache on expire.
> - fix null cache race.
> - fix cache_init() on source re-read.
> - fix mapent becomes negative during lookup.
> - check each dc server individually.
> - fix negative cache included map lookup.
> - remove state machine timed wait.
> - remove extra read master map call.
> - fix error handing in do_mount_indirect().
> - expire thread use pending mutex.
> - remove ERR_remove_state() openssl call.
> - fix init script restart option.
> - fix init script status privilege error.
> - always read file maps mount lookup map read fix.
> - fix direct map not updating on reread.
> - add external bind method.
> - fix add simple bind auth.
> - add option to dump configured automount maps.
> - use weight only for server selection.
> - fix isspace() wild card substition.
> - auto adjust ldap page size.
> - fix prune cache valid check.
> - fix mountd vers retry.
> - fix expire race.
> - replace GPLv3 code.
> - fix paged ldap map read.
> - fix next task list update.
> - fix stale map read.
> - fix null cache clean.
> - automount(8) man page correction.
> - fix out of order locking in readmap.
> - include ip address in debug logging.
> - mount using address for DNS round robin host names.
> - reset negative status on cache prune.
> - remove master_mutex_unlock() leftover.
> - fix sanity checks for brackets in server name.
> - fix lsb service name in init script.
> - fix map source check in file lookup.
> - fix simple bind without SASL support.
> - fix sasl bind host name selection.
> - add nobind option.
> - add base64 password encode.
> - fix ipv6 name for lookup.
> - fix libtirpc ipv6 check.
>
> Ian
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
