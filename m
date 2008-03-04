From: "Colin Simpson" <Colin.Simpson@iongeo.com>
Subject: Authenticated LDAP changed or broken in F8 5.0.2-27?
Date: Tue, 04 Mar 2008 11:08:25 +0000
Message-ID: <1204628905.26396.48.camel@cowie.iouk.ioroot.tld>
Reply-To: Colin.Simpson@iongeo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Class: urn:content-classes:message
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
To: autofs@linux.kernel.org

Hi,

Did something change that has broken the authenticated LDAP
functionality in the last update pushed to Fedora? I would have pushed
this downstream but the upstream and downstream with Fedora seem very
close for this project.

Did I see someone saying that hardly anyone was using this
functionality? We thought we'd test this functionality and try and move
towards getting rid of anonymous binds from our LDAP servers. It seems
the right thing to do.

We were using a setup like this:

<autofs_ldap_sasl_conf
        usetls="yes"
        tlsrequired="yes"
        authrequired="yes"
        authtype="LOGIN"
/>

But this seemed to break when we last upgraded our Fedora systems to
5.0.2-26 to 5.0.2-27. So we thought we'd really do it properly and use
GSSAPI and our Kerberos setup. 

<?xml version="1.0" ?>
         <autofs_ldap_sasl_conf
                 usetls="yes"
                 tlsrequired="yes"
                 authrequired="yes"
                 authtype="GSSAPI"
                 clientprinc="tstpr@UNIXION.UK"
         />

But on starting it gets so far then it seg faults (the debug is below).

So we downgraded to the base version 5.0.2-16 (it's was the easiest one to get hold of). This works!!
But it seems to let the kerberos ticket expire and not grab a new one. Are we doing something wrong or is 
this just a bug too? (output below):

Mar  4 09:52:33 cog automount[21657]: attempting to mount entry /user/tstock
Mar  4 09:52:33 cog automount[21657]: GSSAPI Error: Unspecified GSS failure.  Minor code may provide more information (Ticket expired)
Mar  4 09:52:33 cog automount[21657]: sasl_bind_mech: sasl_client start failed with error: SASL(-1): generic failure: GSSAPI Error: 
Unspecified GSS failure.  Minor code may provide more information (Ticket expired)

Debug of 5.0.2-27 with segfault at the end:

Mar  3 17:31:41 cog automount[21362]: Starting automounter version
5.0.2-27, master map auto.master
Mar  3 17:31:41 cog automount[21362]: using kernel protocol version 5.00
Mar  3 17:31:41 cog automount[21362]: lookup_nss_read_master: reading
master files auto.master
Mar  3 17:31:41 cog automount[21362]: parse_init: parse(sun): init
gathered global options: (null)
Mar  3 17:31:41 cog automount[21362]: lookup_read_master: lookup(file):
read entry +auto.master
Mar  3 17:31:41 cog automount[21362]: lookup_nss_read_master: reading
master files auto.master
Mar  3 17:31:41 cog automount[21362]: parse_init: parse(sun): init
gathered global options: (null)
Mar  3 17:31:41 cog automount[21362]: lookup_nss_read_master: reading
master ldap auto.master
Mar  3 17:31:41 cog automount[21362]: parse_server_string: lookup(ldap):
Attempting to parse LDAP information from string "auto.master".
Mar  3 17:31:41 cog automount[21362]: parse_server_string: lookup(ldap):
mapname auto.master
Mar  3 17:31:41 cog automount[21362]: parse_ldap_config: lookup(ldap):
ldap authentication configured with the following options:
Mar  3 17:31:41 cog automount[21362]: parse_ldap_config: lookup(ldap):
use_tls: 1, tls_required: 1, auth_required: 2, sasl_mech: GSSAPI
Mar  3 17:31:41 cog automount[21362]: parse_ldap_config: lookup(ldap):
user: (null), secret: unspecified, client principal: tstpr@UNIXION.UK
credential cache: (null)
Mar  3 17:31:41 cog automount[21362]: sasl_do_kinit: initializing
kerberos ticket: client principal tstpr@UNIXION.UK
Mar  3 17:31:41 cog automount[21362]: sasl_do_kinit: calling
krb5_parse_name on client principal tstpr@UNIXION.UK
Mar  3 17:31:41 cog automount[21362]: sasl_do_kinit: Using tgs name
krbtgt/UNIXION.UK@UNIXION.UK
Mar  3 17:31:41 cog automount[21362]: sasl_do_kinit: Kerberos
authentication was successful!
Mar  3 17:31:41 cog automount[21362]: sasl_bind_mech: Attempting sasl
bind with mechanism GSSAPI
Mar  3 17:31:41 cog automount[21362]: getuser_func: called with context
(nil), id 16385.
Mar  3 17:31:41 cog automount[21362]: getuser_func: called with context
(nil), id 16385.
Mar  3 17:31:41 cog automount[21362]: sasl_bind_mech: sasl bind with
mechanism GSSAPI succeeded
Mar  3 17:31:41 cog automount[21362]: do_bind: lookup(ldap):
auth_required: 2, sasl_mech GSSAPI
Mar  3 17:31:41 cog automount[21362]: sasl_bind_mech: Attempting sasl
bind with mechanism GSSAPI
Mar  3 17:31:41 cog automount[21362]: getuser_func: called with context
(nil), id 16385.
Mar  3 17:31:41 cog automount[21362]: getuser_func: called with context
(nil), id 16385.
Mar  3 17:31:41 cog automount[21362]: sasl_bind_mech: sasl bind with
mechanism GSSAPI succeeded
Mar  3 17:31:41 cog automount[21362]: do_bind: lookup(ldap):
autofs_sasl_bind returned 0
Mar  3 17:31:41 cog automount[21362]: get_query_dn: lookup(ldap): found
query dn nisMapName=auto.master,ou=csl,dc=ion,dc=uk
Mar  3 17:31:41 cog automount[21362]: parse_init: parse(sun): init
gathered global options: (null)
Mar  3 17:31:41 cog automount[21362]: do_bind: lookup(ldap):
auth_required: 2, sasl_mech GSSAPI
Mar  3 17:31:41 cog automount[21362]: sasl_bind_mech: Attempting sasl
bind with mechanism GSSAPI
Mar  3 17:31:41 cog automount[21362]: getuser_func: called with context
(nil), id 16385.
Mar  3 17:31:41 cog automount[21362]: getuser_func: called with context
(nil), id 16385.
Mar  3 17:31:41 cog automount[21362]: sasl_bind_mech: sasl bind with
mechanism GSSAPI succeeded
Mar  3 17:31:41 cog automount[21362]: do_bind: lookup(ldap):
autofs_sasl_bind returned 0
Mar  3 17:31:41 cog automount[21362]: lookup_read_master: lookup(ldap):
searching for "(objectclass=nisObject)" under
"nisMapName=auto.master,ou=csl,dc=ion,dc=uk"
Mar  3 17:31:41 cog automount[21362]: lookup_read_master: lookup(ldap):
examining entries
Mar  3 17:31:41 cog automount[21362]: master_do_mount: mounting /user
Mar  3 17:31:41 cog automount[21362]: automount_path_to_fifo: fifo
name /var/run/autofs.fifo-user
Mar  3 17:31:41 cog automount[21362]: lookup_nss_read_map: reading map
ldap ldap:nisMapName=auto.user,ou=csl,dc=ion,dc=uk
Mar  3 17:31:41 cog automount[21362]: parse_server_string: lookup(ldap):
Attempting to parse LDAP information from string
"ldap:nisMapName=auto.user,ou=csl,dc=ion,dc=uk".
Mar  3 17:31:41 cog automount[21362]: parse_server_string: lookup(ldap):
server "(default)", base dn "nisMapName=auto.user,ou=csl,dc=ion,dc=uk"
Mar  3 17:31:41 cog automount[21362]: parse_ldap_config: lookup(ldap):
ldap authentication configured with the following options:
Mar  3 17:31:41 cog automount[21362]: parse_ldap_config: lookup(ldap):
use_tls: 1, tls_required: 1, auth_required: 2, sasl_mech: GSSAPI
Mar  3 17:31:41 cog automount[21362]: parse_ldap_config: lookup(ldap):
user: (null), secret: unspecified, client principal: tstpr@UNIXION.UK
credential cache: (null)
Mar  3 17:31:41 cog automount[21362]: sasl_do_kinit: initializing
kerberos ticket: client principal tstpr@UNIXION.UK
Mar  3 17:31:41 cog automount[21362]: sasl_do_kinit: calling
krb5_parse_name on client principal tstpr@UNIXION.UK
Mar  3 17:31:41 cog automount[21362]: sasl_do_kinit: Using tgs name
krbtgt/UNIXION.UK@UNIXION.UK
Mar  3 17:31:41 cog automount[21362]: sasl_do_kinit: Kerberos
authentication was successful!
Mar  3 17:31:41 cog automount[21362]: sasl_bind_mech: Attempting sasl
bind with mechanism GSSAPI
Mar  3 17:31:41 cog kernel: automount[21367]: segfault at 00338680 eip
0039eb9f esp b7f15cc0 error 4

Thanks

Colin

-- 
Colin Simpson
Manager of Information Technology Europe
ION 

www.iongeo.com    

This email and any files transmitted with it are confidential and are intended solely for the use of the individual or entity to whom they are addressed.  If you are not the original recipient or the person responsible for delivering the email to the intended recipient, be advised that you have received this email in error, and that any use, dissemination, forwarding, printing, or copying of this email is strictly prohibited. If you received this email in error, please immediately notify the sender and delete the original.
