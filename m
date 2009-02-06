From: Matthias Koenig <mkoenig@suse.de>
Subject: Re: krb5 required when building with sasl support
Date: Fri, 06 Feb 2009 12:35:47 +0100
Message-ID: <n7xr62bx0fg.fsf@sor.suse.de>
References: <n7xy6wmw3uu.fsf@sor.suse.de> <4989C939.7090106@s3group.cz>
	<498B2F91.1090607@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <498B2F91.1090607@inria.fr> (Guillaume Rousse's message of "Thu\, 
	05 Feb 2009 19\:27\:29 +0100")
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs mailing list <autofs@linux.kernel.org>

Guillaume Rousse <Guillaume.Rousse@inria.fr> writes:

> More seriously, I think the proper solution would rather be fixing 
> underliking in SASL (http://wiki.mandriva.com/en/Underlinking).

Hmm, are you really sure, that libsasl depends on kerberos symbols?
In this case you would be right.
I assumed that they're independent from each other and after
a quick grep I couldn't find any krb5_* symbols in libsasl.
At least the lookup_ldap.h header from autofs explicitly includes
the krb5.h header.

Matthias
