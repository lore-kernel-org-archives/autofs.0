From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Autofs 5.0.1-0rc2.102 failing to query LDAP (Windows
 2008	AD)
Date: Thu, 03 Sep 2009 08:06:32 +0200
Message-ID: <4A9F5CE8.7050509@s3group.cz>
References: <4A9EA5C8.8010301@ocsl.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A9EA5C8.8010301@ocsl.co.uk>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jack Challen <jack_challen@ocsl.co.uk>
Cc: autofs@linux.kernel.org

There is no problem with autofs - the real problem is, that windoze do 
not follow RFC's in subsequent authentication (which autofs is using).
I have reported the problem to Microsoft and they agreed (internal 
bugreport was generated).
The workaround is to use GSSAPI authentication instead - more at 
ondarnfs.blogspot.com
Ondrej

Jack Challen wrote:
> Hello,
>
> My problem appears to be very similar to:
> http://www.opensubscriber.com/message/autofs@linux.kernel.org/11281928.html 
>
>
> I'm trying to make autofs get its information from LDAP (stored on a 
> Windows 2008 AD). I believe autofs is failing to authenticate 
> properly. It appears that the sasl_log_func function is doing the 
> authentication steps in the wrong order (based on reading of the log 
> files).
>
> (FWIW, I've made this work storing info in OpenLDAP, and doing 
> anonymous binds, but I plan to use AD's LDAP functionality).
>
> Here's what works (in that it gets some information):
>
> ldapsearch -h addns -Y DIGEST-MD5 -U ldap.query -w secret -b 
> "cn=auto.master,dc=cm,dc=domain,dc=com"
>
> When I configure /etc/autofs_ldap_auth.conf to contain the following:
> ====
> <autofs_ldap_sasl_conf
>         authtype="DIGEST-MD5"
>         authrequired="yes"
>         user="ldap.query"
>         secret="Secret"
>         usetls="no"
>         tlsrequired="no"
> />
> ====
>
> I get the following logs
> ====
> Sep  2 17:42:10 rhelbase automount[14835]: autofs stopped
> Sep  2 17:42:10 rhelbase automount[14866]: Starting automounter 
> version 5.0.1-0.rc2.102, master map ldap://addns/
> Sep  2 17:42:10 rhelbase automount[14866]: using kernel protocol 
> version 5.00
> Sep  2 17:42:10 rhelbase automount[14866]: lookup_nss_read_master: 
> reading master ldap //addns/
> Sep  2 17:42:10 rhelbase automount[14866]: parse_server_string: 
> lookup(ldap): Attempting to parse LDAP information from string 
> "ldap://addns/".
> Sep  2 17:42:10 rhelbase automount[14866]: parse_server_string: 
> lookup(ldap): mapname
> Sep  2 17:42:10 rhelbase automount[14866]: parse_ldap_config: 
> lookup(ldap): ldap authentication configured with the following options:
> Sep  2 17:42:10 rhelbase automount[14866]: parse_ldap_config: 
> lookup(ldap): use_tls: 1, tls_required: 0, auth_required: 2, 
> sasl_mech: DIGEST-MD5
> Sep  2 17:42:10 rhelbase automount[14866]: parse_ldap_config: 
> lookup(ldap): user: ldap.query, secret: specified, client principal: 
> (null) credential cache: (null)
> Sep  2 17:42:10 rhelbase automount[14866]: sasl_bind_mech: Attempting 
> sasl bind with mechanism DIGEST-MD5
> Sep  2 17:42:10 rhelbase automount[14866]: sasl_log_func: DIGEST-MD5 
> client step 2
> Sep  2 17:42:10 rhelbase automount[14866]: getuser_func: called with 
> context (nil), id 16386.
> Sep  2 17:42:10 rhelbase automount[14866]: getuser_func: called with 
> context (nil), id 16385.
> Sep  2 17:42:10 rhelbase automount[14866]: getpass_func: context 
> (nil), id 16388
> Sep  2 17:42:10 rhelbase automount[14866]: sasl_log_func: DIGEST-MD5 
> client step 3
> Sep  2 17:42:10 rhelbase automount[14866]: sasl_bind_mech: sasl bind 
> with mechanism DIGEST-MD5 succeeded
> Sep  2 17:42:10 rhelbase automount[14866]: do_bind: lookup(ldap): 
> auth_required: 2, sasl_mech DIGEST-MD5
> Sep  2 17:42:10 rhelbase automount[14866]: sasl_bind_mech: Attempting 
> sasl bind with mechanism DIGEST-MD5
> Sep  2 17:42:10 rhelbase automount[14866]: sasl_log_func: DIGEST-MD5 
> client step 1
> Sep  2 17:42:10 rhelbase automount[14866]: getuser_func: called with 
> context (nil), id 16386.
> Sep  2 17:42:10 rhelbase automount[14866]: getuser_func: called with 
> context (nil), id 16385.
> ====
>
> The bit that makes me wonder is the DIGEST-MD5 client steps go in the 
> order 2,3,2,1. It also says the bind succeeded at one point, but 
> appears to carry on.
>
> If I use a deliberately wrong user, I get this:
>
> ====
> Sep  2 17:41:10 rhelbase automount[14771]: autofs stopped
> Sep  2 17:41:10 rhelbase automount[14803]: Starting automounter 
> version 5.0.1-0.rc2.102, master map ldap://addns/
> Sep  2 17:41:10 rhelbase automount[14803]: using kernel protocol 
> version 5.00
> Sep  2 17:41:10 rhelbase automount[14803]: lookup_nss_read_master: 
> reading master ldap //addns/
> Sep  2 17:41:10 rhelbase automount[14803]: parse_server_string: 
> lookup(ldap): Attempting to parse LDAP information from string 
> "ldap://addns/".
> Sep  2 17:41:10 rhelbase automount[14803]: parse_server_string: 
> lookup(ldap): mapname
> Sep  2 17:41:10 rhelbase automount[14803]: parse_ldap_config: 
> lookup(ldap): ldap authentication configured with the following options:
> Sep  2 17:41:10 rhelbase automount[14803]: parse_ldap_config: 
> lookup(ldap): use_tls: 1, tls_required: 0, auth_required: 2, 
> sasl_mech: DIGEST-MD5
> Sep  2 17:41:10 rhelbase automount[14803]: parse_ldap_config: 
> lookup(ldap): user: 1ldap.query, secret: specified, client principal: 
> (null) credential cache: (null)
> Sep  2 17:41:10 rhelbase automount[14803]: sasl_bind_mech: Attempting 
> sasl bind with mechanism DIGEST-MD5
> Sep  2 17:41:10 rhelbase automount[14803]: sasl_log_func: DIGEST-MD5 
> client step 6
> Sep  2 17:41:10 rhelbase automount[14803]: getuser_func: called with 
> context (nil), id 16386.
> Sep  2 17:41:10 rhelbase automount[14803]: getuser_func: called with 
> context (nil), id 16385.
> Sep  2 17:41:10 rhelbase automount[14803]: getpass_func: context 
> (nil), id 16388
> Sep  2 17:41:10 rhelbase automount[14803]: Error parsing response to 
> sasl_bind request: Invalid credentials.
> Sep  2 17:41:10 rhelbase automount[14803]: The LDAP server indicated 
> that the LDAP SASL bind was incomplete, but did not provide the 
> required data to proceed. LDAP SASL bind with mechanism DIGEST-MD5 
> failed.
> Sep  2 17:41:10 rhelbase automount[14803]: sasl bind with mechanism 
> DIGEST-MD5 failed
> Sep  2 17:41:10 rhelbase automount[14803]: connect_to_server: 
> lookup(ldap): cannot initialize authentication setup
> Sep  2 17:41:10 rhelbase automount[14803]: no mounts in table
> ====
>
> This is on a RHEL 5.3 system, and I get the same on an just-updated 
> CentOS 5.3 machine.
>
> Should I be looking at a later autofs package (I couldn't see any 
> indication of that in web searches)?
>
> Has anyone got any clues as to why the ldapsearch works, but the 
> autofs version doesn't?
> Is there anything else I should be trying?
>
>
> cheers
> jack
>
