From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: krb5 required when building with sasl support
Date: Fri, 06 Feb 2009 13:23:54 +0100
Message-ID: <498C2BDA.6070101@s3group.cz>
References: <n7xy6wmw3uu.fsf@sor.suse.de>
	<4989C939.7090106@s3group.cz>	<498B2F91.1090607@inria.fr>
	<n7xr62bx0fg.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

sasl could be (theoretically) built without GSSAPI support and in this
case it would not require Kerberos. But the facts are:
- sasl support in autofs can not be obviously compiled without gssapi
- in these days sasl is many times meant as synonym for sasl/gssapi so
it probably does not make any sense not to include gssapi once we
include sasl.

Ondrej

Matthias Koenig wrote:
> Guillaume Rousse <Guillaume.Rousse@inria.fr> writes:
>
>   
>> More seriously, I think the proper solution would rather be fixing 
>> underliking in SASL (http://wiki.mandriva.com/en/Underlinking).
>>     
>
> Hmm, are you really sure, that libsasl depends on kerberos symbols?
> In this case you would be right.
> I assumed that they're independent from each other and after
> a quick grep I couldn't find any krb5_* symbols in libsasl.
> At least the lookup_ldap.h header from autofs explicitly includes
> the krb5.h header.
>
> Matthias
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>   
