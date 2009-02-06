From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: krb5 required when building with sasl support
Date: Fri, 06 Feb 2009 14:18:40 +0100
Message-ID: <498C38B0.5010409@inria.fr>
References: <n7xy6wmw3uu.fsf@sor.suse.de>
	<4989C939.7090106@s3group.cz>	<498B2F91.1090607@inria.fr>
	<n7xr62bx0fg.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <n7xr62bx0fg.fsf@sor.suse.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Cc: autofs mailing list <autofs@linux.kernel.org>

Matthias Koenig a =E9crit :
> Guillaume Rousse <Guillaume.Rousse@inria.fr> writes:
> =

>> More seriously, I think the proper solution would rather be fixing =

>> underliking in SASL (http://wiki.mandriva.com/en/Underlinking).
> =

> Hmm, are you really sure, that libsasl depends on kerberos symbols?
> In this case you would be right.
> I assumed that they're independent from each other and after
> a quick grep I couldn't find any krb5_* symbols in libsasl.
> At least the lookup_ldap.h header from autofs explicitly includes
> the krb5.h header.
Indeed. I just checked libsasl is built with -Wl,--no-undefined flag, =

and doesn't have undefined symbols either.

I guess the issue (in my case) is not to detect SASL presence, but to =

add -lkrb5 when building autofs ldap plugin (which can't use =

-Wl,--no-undefined safety option, as it is a plugin).
