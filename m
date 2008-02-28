From: Fabio Olive Leite <fleite@redhat.com>
Subject: Re: [autofs] [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
Date: Thu, 28 Feb 2008 09:31:50 -0300
Message-ID: <20080228123150.GA3915@sleipnir.redhat.com>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net> <Pine.LNX.4.64.0802261208400.8490@raven.themaw.net> <20080227204546.72e16e8d.akpm@linux-foundation.org> <1204179747.3501.21.camel@raven.themaw.net> <20080227223734.caab0165.akpm@linux-foundation.org> <1204182500.3501.49.camel@raven.themaw.net> <47C667EC.6060700@openvz.org> <20080227235952.70a31d9f.akpm@linux-foundation.org> <1204185971.3501.87.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1204185971.3501.87.camel@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Emelyanov <xemul@openvz.org>

On Thu, Feb 28, 2008 at 05:06:11PM +0900, Ian Kent wrote:
>=20
> Dumb old me, I really only need the uid.
> The gid can come from the get user info functions of glibc.

In case the process was executed from a setgid executable, you might
have a different gid from what the user has. In fact, I don't know why
you may need more than the pid, since with the pid you can get to the
task's effective uid/gid and maybe other such information you need.

Cheers,
=46=E1bio Oliv=E9
--=20
ex sed lex awk yacc, e pluribus unix, amem
-
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
