From: "Young, Darren" <Darren.Young@chicagogsb.edu>
Subject: Re: LDAP Server
Date: Thu, 24 Apr 2008 14:03:10 -0500
Message-ID: <07A371D457B501478C1DB3C3DE8372D701783885@GSBHEX2V.gsb.uchicago.edu>
References: <07A371D457B501478C1DB3C3DE8372D701783790@GSBHEX2V.gsb.uchicago.edu>
	<x49wsmngmjq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017837DC@GSBHEX2V.gsb.uchicago.edu>
	<x49skxbgll7.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Just remembered the -x in there to disable SASL and go simple auth.

> -----Original Message-----
> From: Young, Darren
> Sent: Thursday, April 24, 2008 1:59 PM
> To: 'Jeff Moyer'
> Cc: autofs@linux.kernel.org
> Subject: RE: [autofs] LDAP Server
> 
> Yep, sure can.
> 
> ldapsearch -x -h <ldap_host> -D "cn=Directory Manager" -b
> "o=gsb,dc=uchicago,dc=edu" -w <password>' uid=dyoung2 cn
> 
> Gets me:
> 
> # extended LDIF
> #
> # LDAPv3
> # base <o=gsb,dc=uchicago,dc=edu> with scope subtree
> # filter: uid=dyoung2
> # requesting: cn
> #
> 
> # dyoung2, people, gsb, uchicago.edu
> dn: uid=dyoung2,ou=people,o=gsb,dc=uchicago,dc=edu
> cn: Darren Young
> 
> # search result
> search: 2
> result: 0 Success
> 
> # numResponses: 2
> # numEntries: 1
> 
> 
> Ldapsearch comes from:
> 
> # rpm -qilf /usr/bin/ldapsearch
> Name        : openldap-clients             Relocations: (not
> relocatable)
> Version     : 2.3.27                            Vendor: Red Hat, Inc.
> Release     : 8.el5_1.3                     Build Date: Thu 07 Feb
2008
> 10:36:14 AM CST
> Install Date: Thu 28 Feb 2008 05:39:30 PM CST      Build Host: hs20-
> bc2-4.build.redhat.com
> Group       : Applications/Internet         Source RPM: openldap-
> 2.3.27-8.el5_1.3.src.rpm
> Size        : 310928                           License: OpenLDAP
> Signature   : DSA/SHA1, Thu 21 Feb 2008 07:44:07 AM CST, Key ID
> 5326810137017186
> Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>
> URL         : http://www.openldap.org/
> Summary     : Client programs for OpenLDAP.
> 
> > -----Original Message-----
> > From: Jeff Moyer [mailto:jmoyer@redhat.com]
> > Sent: Thursday, April 24, 2008 1:22 PM
> > To: Young, Darren
> > Cc: autofs@linux.kernel.org
> > Subject: Re: [autofs] LDAP Server
> >
> > "Young, Darren" <Darren.Young@ChicagoGSB.edu> writes:
> >
> > > Getting there, have this one now:
> > >
> > > Apr 22 09:14:09 gsbtestfilervm automount[7775]: do_sasl_bind:
Error
> > > parsing response to sasl_bind request: Authentication method not
> > > supported.
> > > Apr 22 09:14:09 gsbtestfilervm automount[7775]: do_sasl_bind: The
> > LDAP
> > > server indicated that the LDAP SASL bind was incomplete, but did
> not
> > > provide the required data to proceed. LDAP SASL bind with
mechanism
> > > LOGIN failed.
> > > Apr 22 09:14:09 gsbtestfilervm automount[7775]: sasl_bind_mech:
> sasl
> > > bind with mechanism LOGIN failed
> > > Apr 22 09:14:09 gsbtestfilervm automount[7775]: lookup_init:
> > > lookup(ldap): cannot initialize authentication setup
> > >
> > > LDAP is Sun directory 5.2 and I thought it supported SASL. Tried
> > PLAIN
> > > and LOGIN methods, same thing. Anonymous bind is disabled on our
> LDAP
> > > hosts.
> >
> > First, can you do an authenticated search from the client machine
> > outside of autofs?  For example, can you come up with an incantation
> of
> > ldapsearch that returns results for you?
> >
> > If you can, then we can figure out how to configure your
> > /etc/autofs_ldap_auth.conf file.
> >
> > -Jeff
