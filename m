From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: krb5 required when building with sasl support
Date: Fri, 06 Feb 2009 14:09:29 +0100
Message-ID: <498C3689.2080403@inria.fr>
References: <n7xy6wmw3uu.fsf@sor.suse.de>	<4989C939.7090106@s3group.cz>	<498B2F91.1090607@inria.fr>	<n7xr62bx0fg.fsf@sor.suse.de>
	<498C2BDA.6070101@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <498C2BDA.6070101@s3group.cz>
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

Ondrej Valousek a =E9crit :
> sasl could be (theoretically) built without GSSAPI support and in this
> case it would not require Kerberos. But the facts are:
> - sasl support in autofs can not be obviously compiled without gssapi
> - in these days sasl is many times meant as synonym for sasl/gssapi so
> it probably does not make any sense not to include gssapi once we
> include sasl.

But you should be able to link against SASL without prior knowledge of =

its own dependencies. That's the point of avoiding distributing =

underlinked libraries.
