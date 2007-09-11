From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: sasl compilation error
Date: Tue, 11 Sep 2007 10:44:34 -0400
Message-ID: <x49ir6h9s8d.fsf@segfault.boston.devel.redhat.com>
References: <46E5B0C3.9090903@inria.fr>
	<x49abruysx6.fsf@segfault.boston.devel.redhat.com>
	<46E6A6C4.1060705@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46E6A6C4.1060705@inria.fr> (Guillaume Rousse's message of "Tue\,
	11 Sep 2007 16\:31\:32 +0200")
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

> Jeff Moyer a =E9crit :
>> Do you have krb5 development libraries and headers installed?  It's
>> looking for this:
>> =

>> typedef struct krb5_principal_data {
>>     krb5_magic magic;
>>     krb5_data realm;
>>     krb5_data *data;            /* An array of strings */
>>     krb5_int32 length;
>>     krb5_int32 type;
>> } krb5_principal_data;
>> =

>> typedef krb5_principal_data * krb5_principal;
> Actually, I had heimdal libraries, instead of mit kerberos, and the lack
> of error message for missing header file confused me. Despite having the
> same include file name (krb5.h), heimdal does not have the same
> structure defined. It would be wise to add a configure test for this issu=
e.
>
> Installing MIT kerberos solved the issue, thanks.

OK.  Clearly, I haven't tried using the Heimdal implementation.  I'll
add it to my ever-growing list.  ;)

Cheers,

Jeff
