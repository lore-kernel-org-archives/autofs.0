From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: AutoFS / SASL support
Date: Tue, 06 Nov 2007 10:18:40 -0500
Message-ID: <x49wssvl7vz.fsf@segfault.boston.devel.redhat.com>
References: <E5F741E838FC2043A0B843E48181813806AB750D@MLNYC730MB.amrs.win.ml.com>
	<1194351777.9373.25.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1194351777.9373.25.camel@raven.themaw.net> (Ian Kent's message
	of "Tue\, 06 Nov 2007 21\:22\:57 +0900")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, "Newman, Edward (GTI)" <edward_newman@ml.com>

Ian Kent <raven@themaw.net> writes:

> On Tue, 2007-11-06 at 06:41 -0500, Newman, Edward (GTI) wrote:

>> One thing I noticed in reviewing code is that three files have to be
>> configured to set up LDAP - /etc/sysconfig/autofs,
>> /etc/auto_ldap_auth.conf and /etc/openldap/ldap.conf. Is there a reason
>> for this? Can I look at rationalising this? Not clear why there is made
>> a dependency on XML libraries.
>
> Not sure what to do about this fragmented configuration.
>
> The dependency on /etc/openldap/ldap.conf was because we couldn't
> specify servers to connect to or basedns to use for searching
> in /etc/sysconfig/autofs but that has changed now with this problematic
> enhancement (and another patch). I think allowing for the configuration

The openldap libraries use /etc/openldap/ldap.conf.  For the most
basic operations, you shouldn't have to setup anything ldap specific
in the autofs configuration.  We shouldn't break this.

> The /etc/auto_ldap_auth.conf being an XML file came along with the
> Kerberos code that I merged from Jeff. I'm not sure why he wanted to use
> XML and I wasn't really worried about it at the time. From memory it was
> decided to put the authentication information in a separate, locked down
> file, so it could be kept private while the general configuration could
> still be read by anyone who may need to know about it.

Yes, a stand-alone file that could be locked down was a requirement,
given that it could store passwords.  I used XML because I didn't want
to implement yet another parser.

-Jeff
