From: "Young, Darren" <Darren.Young@chicagogsb.edu>
Subject: Re: LDAP Server
Date: Thu, 24 Apr 2008 14:38:33 -0500
Message-ID: <07A371D457B501478C1DB3C3DE8372D7017838DA@GSBHEX2V.gsb.uchicago.edu>
References: <07A371D457B501478C1DB3C3DE8372D701783790@GSBHEX2V.gsb.uchicago.edu>
	<x49wsmngmjq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017837DC@GSBHEX2V.gsb.uchicago.edu>
	<x49skxbgll7.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D70178387D@GSBHEX2V.gsb.uchicago.edu>
	<x49lk33giw0.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <x49lk33giw0.fsf@segfault.boston.devel.redhat.com>
Content-class: urn:content-classes:message
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Says:

supportedSASLMechanisms: EXTERNAL
supportedSASLMechanisms: GSSAPI
supportedSASLMechanisms: DIGEST-MD5

So I set autofs_ldap_auth.conf to:
<autofs_ldap_sasl_conf
        usetls="no"
        tlsrequired="no"
        authrequired="yes"
        authtype="DIGEST-MD5"
        user="cn=Directory Manager"
        secret="xxxxx"
/>

And get:
Apr 24 14:34:44 gsbtestfilervm automount[8097]: sasl_log_func: No worthy
mechs found
Apr 24 14:34:44 gsbtestfilervm automount[8097]: sasl_bind_mech:
sasl_client start failed with error: SASL(-4): no mechanism available:
No worthy mechs found
Apr 24 14:34:44 gsbtestfilervm automount[8097]: lookup_init:
lookup(ldap): cannot initialize authentication setup
Apr 24 14:34:44 gsbtestfilervm automount[8097]: lookup_read_master:
lookup(file): failed to read included master map auto.master


GSSAPI says:

Apr 24 14:35:34 gsbtestfilervm pcscd: winscard.c:219:SCardConnect()
Reader E-Gate 0 0 Not Found
Apr 24 14:35:34 gsbtestfilervm last message repeated 3 times
Apr 24 14:35:34 gsbtestfilervm automount[8138]: sasl_do_kinit:
krb5_get_init_creds_keytab failed with error -1765328230
Apr 24 14:35:34 gsbtestfilervm automount[8138]: lookup_init:
lookup(ldap): cannot initialize authentication setup
Apr 24 14:35:34 gsbtestfilervm automount[8138]: lookup_read_master:
lookup(file): failed to read included master map auto.master

I would imagine that's because the host isn't setup for Kerberos in any
way shape or form.

> -----Original Message-----
> From: Jeff Moyer [mailto:jmoyer@redhat.com]
> Sent: Thursday, April 24, 2008 2:20 PM
> To: Young, Darren
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] LDAP Server
> 
> "Young, Darren" <Darren.Young@ChicagoGSB.edu> writes:
> 
> > Yep, sure can.
> >
> > ldapsearch -x -h <ldap_host> -D "cn=Directory Manager" -b
> > "o=gsb,dc=uchicago,dc=edu" -w <password>' uid=dyoung2 cn
> 
> The "-x" option tells ldapsearch to use simple authentication (not
> SASL).  Can you specify a SASL mechanism (using -Y)?  To get a list of
> supported mechanisms, you can look for 'supportedSASLMechanisms' in
> your
> directory root.
> 
> Cheers,
> 
> Jeff
