From: "Young, Darren" <Darren.Young@chicagogsb.edu>
Subject: Re: LDAP Server
Date: Thu, 24 Apr 2008 14:54:25 -0500
Message-ID: <07A371D457B501478C1DB3C3DE8372D701783912@GSBHEX2V.gsb.uchicago.edu>
References: <07A371D457B501478C1DB3C3DE8372D701783790@GSBHEX2V.gsb.uchicago.edu>
	<x49wsmngmjq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017837DC@GSBHEX2V.gsb.uchicago.edu>
	<x49skxbgll7.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D70178387D@GSBHEX2V.gsb.uchicago.edu>
	<x49lk33giw0.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017838DA@GSBHEX2V.gsb.uchicago.edu>
	<x493apbghkr.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <x493apbghkr.fsf@segfault.boston.devel.redhat.com>
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

Apr 24 14:35:33 gsbtestfilervm automount[8138]: Starting automounter
version 5.0.1-0.rc2.55, master map auto.master

On:

[root@gsbtestfilervm log]# cat /etc/redhat-release 
Red Hat Enterprise Linux Server release 5.1 (Tikanga)

Added daemon.* to syslog and started autofs:

Apr 24 14:47:16 gsbtestfilervm automount[8283]: Starting automounter
version 5.0.1-0.rc2.55, master map auto.master
Apr 24 14:47:16 gsbtestfilervm automount[8283]: using kernel protocol
version 5.00
Apr 24 14:47:16 gsbtestfilervm automount[8283]: lookup_nss_read_master:
reading master files auto.master
Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_init: parse(sun):
init gathered global options: (null)
Apr 24 14:47:16 gsbtestfilervm automount[8283]: mount_init: mount(bind):
bind_works = 1
Apr 24 14:47:16 gsbtestfilervm automount[8283]: lookup_read_master:
lookup(file): read entry /misc
Apr 24 14:47:16 gsbtestfilervm automount[8283]: lookup_read_master:
lookup(file): read entry /net
Apr 24 14:47:16 gsbtestfilervm automount[8283]: lookup_read_master:
lookup(file): read entry +auto.master
Apr 24 14:47:16 gsbtestfilervm automount[8283]: lookup_nss_read_master:
reading master files auto.master
Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_init: parse(sun):
init gathered global options: (null)
Apr 24 14:47:16 gsbtestfilervm automount[8283]: lookup_nss_read_master:
reading master ldap auto.master
Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_server_string:
lookup(ldap): Attempting to parse LDAP information from string
"auto.master".
Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_server_string:
lookup(ldap): mapname auto.master
Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_ldap_config: ldap
authentication configured with the following options: 
Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_ldap_config:
use_tls: 0, tls_required: 0, auth_required: 2, sasl_mech: DIGEST-MD5 
Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_ldap_config: user:
cn=Directory Manager, secret: specified, client principal: (null) 
Apr 24 14:47:16 gsbtestfilervm automount[8283]: sasl_bind_mech:
Attempting sasl bind with mechanism DIGEST-MD5
Apr 24 14:47:16 gsbtestfilervm automount[8283]: sasl_log_func: No worthy
mechs found
Apr 24 14:47:16 gsbtestfilervm automount[8283]: sasl_bind_mech:
sasl_client start failed with error: SASL(-4): no mechanism available:
No worthy mechs found
Apr 24 14:47:16 gsbtestfilervm automount[8283]: unbind_ldap_connection:
use_tls: 0
Apr 24 14:47:16 gsbtestfilervm automount[8283]: lookup_init:
lookup(ldap): cannot initialize authentication setup
Apr 24 14:47:16 gsbtestfilervm automount[8283]: lookup_read_master:
lookup(file): failed to read included master map auto.master
Apr 24 14:47:16 gsbtestfilervm automount[8283]: master_do_mount:
mounting /misc
Apr 24 14:47:16 gsbtestfilervm automount[8283]: lookup_nss_read_map:
reading map file /etc/auto.misc
Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_init: parse(sun):
init gathered global options: (null)
Apr 24 14:47:17 gsbtestfilervm automount[8283]: mount_init: mount(bind):
bind_works = 1
Apr 24 14:47:17 gsbtestfilervm automount[8283]: mounted indirect mount
on /misc with timeout 300, freq 75 seconds
Apr 24 14:47:17 gsbtestfilervm automount[8283]: master_do_mount:
mounting /net
Apr 24 14:47:17 gsbtestfilervm automount[8283]: lookup_nss_read_map:
reading map hosts (null)
Apr 24 14:47:17 gsbtestfilervm automount[8283]: parse_init: parse(sun):
init gathered global options: (null)
Apr 24 14:47:17 gsbtestfilervm automount[8283]: mounted indirect mount
on /net with timeout 300, freq 75 seconds

> -----Original Message-----
> From: Jeff Moyer [mailto:jmoyer@redhat.com]
> Sent: Thursday, April 24, 2008 2:48 PM
> To: Young, Darren
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] LDAP Server
> 
> "Young, Darren" <Darren.Young@ChicagoGSB.edu> writes:
> 
> > Says:
> >
> > supportedSASLMechanisms: EXTERNAL
> > supportedSASLMechanisms: GSSAPI
> > supportedSASLMechanisms: DIGEST-MD5
> >
> > So I set autofs_ldap_auth.conf to:
> > <autofs_ldap_sasl_conf
> >         usetls="no"
> >         tlsrequired="no"
> >         authrequired="yes"
> >         authtype="DIGEST-MD5"
> >         user="cn=Directory Manager"
> >         secret="xxxxx"
> > />
> >
> > And get:
> > Apr 24 14:34:44 gsbtestfilervm automount[8097]: sasl_log_func: No
> worthy
> > mechs found
> > Apr 24 14:34:44 gsbtestfilervm automount[8097]: sasl_bind_mech:
> > sasl_client start failed with error: SASL(-4): no mechanism
> available:
> > No worthy mechs found
> > Apr 24 14:34:44 gsbtestfilervm automount[8097]: lookup_init:
> > lookup(ldap): cannot initialize authentication setup
> > Apr 24 14:34:44 gsbtestfilervm automount[8097]: lookup_read_master:
> > lookup(file): failed to read included master map auto.master
> 
> OK, what version of autofs are you running, and are you logging
> daemon.*
> to your log file?
> 
> Cheers,
> 
> Jeff
