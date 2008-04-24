From: Ian Kent <raven@themaw.net>
Subject: Re: LDAP Server
Date: Fri, 25 Apr 2008 03:02:59 +0800
Message-ID: <1209063785.3286.0.camel@raven.themaw.net>
References: <07A371D457B501478C1DB3C3DE8372D701783790@GSBHEX2V.gsb.uchicago.edu>
	<x49wsmngmjq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017837D8@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <07A371D457B501478C1DB3C3DE8372D7017837D8@GSBHEX2V.gsb.uchicago.edu>
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


On Thu, 2008-04-24 at 13:07 -0500, Young, Darren wrote:
> Thanks, RedHat seems to use /etc/ldap.conf for everything.

No, that's the configuration file for nss_ldap not the OpenLDAP
libraries.

> 
> > -----Original Message-----
> > From: Jeff Moyer [mailto:jmoyer@redhat.com]
> > Sent: Thursday, April 24, 2008 1:01 PM
> > To: Young, Darren
> > Cc: autofs@linux.kernel.org
> > Subject: Re: [autofs] LDAP Server
> > 
> > "Young, Darren" <Darren.Young@chicagogsb.edu> writes:
> > 
> > > Getting the following on a RHEL 5 system:
> > >
> > > Apr 22 08:47:29 gsbtestfilervm automount[7607]: using kernel
> protocol
> > > version 5.00
> > > Apr 22 08:47:30 gsbtestfilervm automount[7607]: do_sasl_bind: Error
> > > sending sasl_bind request to the server: Can't contact LDAP server
> > > Apr 22 08:47:30 gsbtestfilervm automount[7607]: sasl_bind_mech: sasl
> > > bind with mechanism PLAIN failed
> > > Apr 22 08:47:30 gsbtestfilervm automount[7607]: lookup_init:
> > > lookup(ldap): cannot initialize authentication setup
> > > Apr 22 08:47:30 gsbtestfilervm automount[7607]: lookup_read_master:
> > > lookup(file): failed to read included master map auto.master
> > >
> > > Where does autofs obtain the server to connect to from? Ldap.conf?
> > 
> > If no server is specified in your automounter configuration, it uses
> > the
> > defaults (which depend on the library used).  For openldap, this will
> > be
> > /etc/openldap/ldap.conf.
> > 
> > Cheers,
> > 
> > Jeff
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
