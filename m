From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: auto.master in ldap + simple bind
Date: Mon, 19 Jan 2009 12:26:25 +0100
Message-ID: <49746361.5010509@s3group.cz>
References: <49709FA6.1040203@s3group.cz>	<1232122347.3166.102.camel@zeus.themaw.net>	<1232168581.3072.0.camel@zeus.themaw.net>	<4608.82.208.2.231.1232305306.squirrel@webmail.s3group.com>
	<1232332943.3136.28.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232332943.3136.28.camel@zeus.themaw.net>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>


> Show us the logs.
>
>   
Hi Ian,

I did some digging around and found this:
1. autofs 5 as shipped with RHEL 5.2 does not seem to support simple
bind (i.e. something like ldapsearch -x .....) to a LDAP server not
supporting anonymous access - like Active Directory (note for the
record: Autofs 4 does only support anonymous ldap server)
2. The only other thing autofs 5 can do is various SASL authentication
schemes (GSSAPI, PLAIN,.....).
3. Active Directory can do SASL and the common mechanisms that both can
do is GSSAPI and DIGEST-MD5.
4. I tried with DIGEST-MD5:

[root@dorado_v1 etc]# cat /etc/sysconfig/autofs
LDAP_URI="ldap://WIN-UG29HR9IEGY"
SEARCH_BASE="cn=praguetest,cn=prague,dc=ad,dc=s3group,dc=cz"
....
[root@dorado_v1 etc]# cat /etc/autofs_ldap_auth.conf
<autofs_ldap_sasl_conf
        usetls="no"
        tlsrequired="no"
        authrequired="yes"
        authtype="DIGEST-MD5"
        user="ldapproxy"
        secret="1234proxy$"
/>
Verified with ldapsearch its functionality:
[root@dorado_v1 etc]# ldapsearch -H ldap://WIN-UG29HR9IEGY -Y DIGEST-MD5
-U ldapproxy -w 1234proxy$ -b
"cn=praguetest,cn=prague,dc=ad,dc=s3group,dc=cz" objectClass=nisMap
SASL/DIGEST-MD5 authentication started
SASL username: ldapproxy
SASL SSF: 128
SASL installing layers
# extended LDIF
#
# LDAPv3
# base <cn=praguetest,cn=prague,dc=ad,dc=s3group,dc=cz> with scope subtree
# filter: objectClass=nisMap
# requesting: ALL
#

# auto.master, praguetest, prague, ad.s3group.cz
dn: CN=auto.master,CN=praguetest,CN=prague,DC=ad,DC=s3group,DC=cz
objectClass: top
objectClass: nisMap
cn: auto.master
distinguishedName:
CN=auto.master,CN=praguetest,CN=prague,DC=ad,DC=s3group,DC=
 cz
instanceType: 4
whenCreated: 20090116124656.0Z
whenChanged: 20090116124656.0Z
uSNCreated: 20610
uSNChanged: 20610
showInAdvancedViewOnly: TRUE
name: auto.master
objectGUID:: 2T1wg8oG70G3VpHKlieoWQ==
objectCategory: CN=NisMap,CN=Schema,CN=Configuration,DC=ad,DC=s3group,DC=cz
dSCorePropagationData: 16010101000000.0Z
nisMapName: auto.master
....
eheeej should for with the automounter, ok? But it does not:

Jan 19 11:55:41 dorado_v1 automount[22886]: Starting automounter version
5.0.1-0.rc2.88.el5_2.1, master map auto.master
Jan 19 11:55:41 dorado_v1 automount[22886]: using kernel protocol
version 5.00
Jan 19 11:55:41 dorado_v1 automount[22886]: lookup_nss_read_master:
reading master files auto.master
Jan 19 11:55:41 dorado_v1 automount[22886]: parse_init: parse(sun): init
gathered global options: (null)
Jan 19 11:55:41 dorado_v1 automount[22886]: lookup_read_master:
lookup(file): read entry /misc
Jan 19 11:55:41 dorado_v1 automount[22886]: lookup_read_master:
lookup(file): read entry /net
Jan 19 11:55:41 dorado_v1 automount[22886]: lookup_read_master:
lookup(file): read entry +auto.master
Jan 19 11:55:41 dorado_v1 automount[22886]: lookup_nss_read_master:
reading master files auto.master
Jan 19 11:55:41 dorado_v1 automount[22886]: parse_init: parse(sun): init
gathered global options: (null)
Jan 19 11:55:41 dorado_v1 automount[22886]: lookup_nss_read_master:
reading master ldap auto.master
Jan 19 11:55:41 dorado_v1 automount[22886]: parse_server_string:
lookup(ldap): Attempting to parse LDAP information from string
"auto.master".
Jan 19 11:55:41 dorado_v1 automount[22886]: parse_server_string:
lookup(ldap): mapname auto.master
Jan 19 11:55:41 dorado_v1 automount[22886]: parse_ldap_config:
lookup(ldap): ldap authentication configured with the following options:
Jan 19 11:55:41 dorado_v1 automount[22886]: parse_ldap_config:
lookup(ldap): use_tls: 0, tls_required: 0, auth_required: 2, sasl_mech:
DIGEST-MD5
Jan 19 11:55:41 dorado_v1 automount[22886]: parse_ldap_config:
lookup(ldap): user: ldapproxy, secret: specified, client principal:
(null) credential cache: (null)
Jan 19 11:55:41 dorado_v1 automount[22886]: find_server: trying server
ldap://WIN-UG29HR9IEGY
Jan 19 11:55:41 dorado_v1 automount[22886]: sasl_bind_mech: Attempting
sasl bind with mechanism DIGEST-MD5
Jan 19 11:55:41 dorado_v1 automount[22886]: sasl_log_func: DIGEST-MD5
client step 2
Jan 19 11:55:41 dorado_v1 automount[22886]: getuser_func: called with
context (nil), id 16386.
Jan 19 11:55:41 dorado_v1 automount[22886]: getuser_func: called with
context (nil), id 16385.
Jan 19 11:55:41 dorado_v1 automount[22886]: getpass_func: context (nil),
id 16388
Jan 19 11:55:41 dorado_v1 automount[22886]: sasl_log_func: DIGEST-MD5
client step 3
Jan 19 11:55:41 dorado_v1 automount[22886]: sasl_bind_mech: sasl bind
with mechanism DIGEST-MD5 succeeded
Jan 19 11:55:41 dorado_v1 automount[22886]: do_bind: lookup(ldap):
auth_required: 2, sasl_mech DIGEST-MD5
Jan 19 11:55:41 dorado_v1 automount[22886]: sasl_bind_mech: Attempting
sasl bind with mechanism DIGEST-MD5
Jan 19 11:55:41 dorado_v1 automount[22886]: sasl_log_func: DIGEST-MD5
client step 1
Jan 19 11:55:41 dorado_v1 automount[22886]: getuser_func: called with
context (nil), id 16386.
Jan 19 11:55:41 dorado_v1 automount[22886]: getuser_func: called with
context (nil), id 16385.
Jan 19 11:55:41 dorado_v1 automount[22886]: getpass_func: context (nil),
id 16388
Jan 19 11:55:41 dorado_v1 automount[22886]: Error parsing response to
sasl_bind request: Invalid credentials.
Jan 19 11:55:41 dorado_v1 automount[22886]: The LDAP server indicated
that the LDAP SASL bind was incomplete, but did not provide the required
data to proceed. LDAP SASL bind with mechanism DIGEST-MD5 failed.
Jan 19 11:55:41 dorado_v1 automount[22886]: sasl bind with mechanism
DIGEST-MD5 failed
Jan 19 11:55:41 dorado_v1 automount[22886]: do_bind: lookup(ldap):
autofs_sasl_bind returned -1
Jan 19 11:55:41 dorado_v1 automount[22886]: connect_to_server:
lookup(ldap): cannot bind to server
Jan 19 11:55:41 dorado_v1 automount[22886]: lookup_init: lookup(ldap):
failed to find available server

Now tell me - it looks good at the beginning, but then something goes
wrong...
Please advise...
Thanks,

Ondrej
