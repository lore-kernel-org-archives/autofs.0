From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: sasl support breaks ldap module
Date: Mon, 12 Nov 2007 17:25:51 -0500
Message-ID: <x49ejev3xu8.fsf@segfault.boston.devel.redhat.com>
References: <4738CEFC.5000700@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4738CEFC.5000700@inria.fr> (Guillaume Rousse's message of "Mon\,
	12 Nov 2007 23\:09\:00 +0100")
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
Cc: autofs@linux.kernel.org

Guillaume Rousse <Guillaume.Rousse@inria.fr> writes:

> Hello.
>
> I just found out than enabling sasl support caused lookup_ldap to be
> non-functionnal, because of unresolved symbols:
> Nov  7 11:31:10 etoile automount[2743]: open_lookup: cannot open lookup
> module
> ldap (/usr/lib/autofs/lookup_ldap.so: undefined symbol:
> krb5_get_init_creds_keytab)
>
> Shouldn't this module get linked to kerberos lib, in addition to sasl lib ?

Yes.

-Jeff
