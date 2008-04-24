From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: LDAP Server
Date: Thu, 24 Apr 2008 15:48:20 -0400
Message-ID: <x493apbghkr.fsf@segfault.boston.devel.redhat.com>
References: <07A371D457B501478C1DB3C3DE8372D701783790@GSBHEX2V.gsb.uchicago.edu>
	<x49wsmngmjq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017837DC@GSBHEX2V.gsb.uchicago.edu>
	<x49skxbgll7.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D70178387D@GSBHEX2V.gsb.uchicago.edu>
	<x49lk33giw0.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017838DA@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <07A371D457B501478C1DB3C3DE8372D7017838DA@GSBHEX2V.gsb.uchicago.edu>
	(Darren Young's message of "Thu, 24 Apr 2008 14:38:33 -0500")
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
To: "Young, Darren" <Darren.Young@chicagogsb.edu>
Cc: autofs@linux.kernel.org

"Young, Darren" <Darren.Young@ChicagoGSB.edu> writes:

> Says:
>
> supportedSASLMechanisms: EXTERNAL
> supportedSASLMechanisms: GSSAPI
> supportedSASLMechanisms: DIGEST-MD5
>
> So I set autofs_ldap_auth.conf to:
> <autofs_ldap_sasl_conf
>         usetls="no"
>         tlsrequired="no"
>         authrequired="yes"
>         authtype="DIGEST-MD5"
>         user="cn=Directory Manager"
>         secret="xxxxx"
> />
>
> And get:
> Apr 24 14:34:44 gsbtestfilervm automount[8097]: sasl_log_func: No worthy
> mechs found
> Apr 24 14:34:44 gsbtestfilervm automount[8097]: sasl_bind_mech:
> sasl_client start failed with error: SASL(-4): no mechanism available:
> No worthy mechs found
> Apr 24 14:34:44 gsbtestfilervm automount[8097]: lookup_init:
> lookup(ldap): cannot initialize authentication setup
> Apr 24 14:34:44 gsbtestfilervm automount[8097]: lookup_read_master:
> lookup(file): failed to read included master map auto.master

OK, what version of autofs are you running, and are you logging daemon.*
to your log file?

Cheers,

Jeff
