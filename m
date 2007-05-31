From: Ian Kent <raven@themaw.net>
Subject: Re: [Fwd: autofs5 and ldap again]
Date: Fri, 01 Jun 2007 00:15:04 +0800
Message-ID: <1180628104.3563.16.camel@raven.themaw.net>
References: <465EACBD.6030600@quadriga.com>  <465EB556.6070002@quadriga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <465EB556.6070002@quadriga.com>
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
To: Nicholas Byrne <nicholas.byrne@quadriga.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-05-31 at 12:45 +0100, Nicholas Byrne wrote:
> I did this yesterday and sent this morning, with a fresh head today i
> noticed i didn't have any automountmap objectclass entries in my
> auto.mnt and auto.home ou's (although this seems to work fine for autofs
> v4). I've added them and tested which gets me a little bit further,
> automount starts correctly and it finds more, but won't mount anything
> yet. Progress, as i see -
> 
> cat /proc/mounts  | grep auto
> ds01.tech:ou=auto.home,ou=autofs,ou=services,dc=tech /nfshome autofs
> rw,fd=6,pgrp=6513,timeout=60,minproto=5,maxproto=5,indirect 0 0
> ds01.tech:ou=auto.mnt,ou=autofs,ou=services,dc=tech /mnt/nfs autofs
> rw,fd=11,pgrp=6513,timeout=60,minproto=5,maxproto=5,indirect 0 0
> 
> But trying to mount my /mnt/nfs/repository shows in debug log:
> May 31 12:40:41 build01 automount[6513]: handle_packet: type = 3
> May 31 12:40:41 build01 automount[6513]: handle_packet_missing_indirect:
> token 83, name repository, request pid 6648
> May 31 12:40:41 build01 automount[6513]: attempting to mount entry
> /mnt/nfs/repository
> May 31 12:40:41 build01 automount[6513]: lookup_mount: lookup(ldap):
> looking up repository
> May 31 12:40:41 build01 automount[6513]: lookup_one: lookup(ldap):
> searching for "(&(objectclass=automount)(|(cn=repository)(cn=/)))" under
> "ou=auto.mnt,ou=autofs,ou=services,dc=tech"
> May 31 12:40:41 build01 automount[6513]: do_connect: auth_required: 1,
> sasl_mech (null)
> May 31 12:40:41 build01 automount[6513]: do_connect: lookup(ldap): ldap
> anonymous bind returned 0
> May 31 12:40:41 build01 automount[6513]: lookup_one: lookup(ldap):
> getting first entry for cn="repository"
> May 31 12:40:41 build01 automount[6513]: lookup_one: lookup(ldap):
> examining first entry
> May 31 12:40:41 build01 automount[6513]: unbind_ldap_connection: use_tls: 0
> May 31 12:40:41 build01 automount[6513]: lookup_mount: lookup(ldap):
> repository -> rw,proto=tcp,port=2049 fs01.giga:/export/repository

Looks like you don't have a minus in front of your options in the mount
entry. In maps you must introduce options with a "-".

> May 31 12:40:41 build01 automount[6513]: parse_mount: parse(sun):
> expanded entry: rw,proto=tcp,port=2049 fs01.giga:/export/repository
> May 31 12:40:41 build01 automount[6513]: parse_mount: parse(sun):
> gathered options:
> May 31 12:40:41 build01 automount[6513]: parse_mount: parse(sun):
> invalid location
> May 31 12:40:41 build01 automount[6513]: send_fail: token = 83
> May 31 12:40:41 build01 automount[6513]: failed to mount /mnt/nfs/repository
> 
> Any ideas?
> Thanks
> Nick
> 
> Nicholas Byrne wrote:
> > Hi,
> >  
> > I've been through recent posts regarding problems similar to this but
> > couldn't find a solution. Autofs 4 works with this schema and setup.
> > Autofs 5 does not mount/start, details of config and errors below. What
> > have i done wrong, i've looked at the debug log but it's not obvious
> > whats going wrong to me at least.
> > Thanks in advance
> > Nick
> >  
> > /etc/nsswitch.conf | grep auto
> > automount:  ldap
> >  
> > ===
> >  
> > /etc/openldap/ldap.conf:
> > URI ldap://ds01.tech/
> > BASE dc=tech
> > TLS_CACERTDIR /etc/openldap/cacerts
> >  
> > ===
> > rpm -q autofs
> > autofs-5.0.1-0.rc2.43.0.2
> >  
> > ===
> >  
> > more /etc/redhat-release
> > CentOS release 5 (Final)
> >  
> > ===
> >  
> > more /etc/sysconfig/autofs  | grep -v ^#
> > DEFAULT_TIMEOUT=300
> > DEFAULT_BROWSE_MODE="no"
> > DEFAULT_LOGGING="debug"
> > DEFAULT_MAP_OBJECT_CLASS="automountmap"
> > DEFAULT_ENTRY_OBJECT_CLASS="automount"
> > DEFAULT_MAP_ATTRIBUTE="ou"
> > DEFAULT_ENTRY_ATTRIBUTE="cn"
> > DEFAULT_VALUE_ATTRIBUTE="automountInformation"
> >  
> > ===
> >  
> > more /var/log/debug.log
> > May 30 16:05:37 build01 automount[4242]: Starting automounter version
> > 5.0.1-0.rc2.43.0.2, master map auto.master
> > May 30 16:05:37 build01 automount[4242]: using kernel protocol version 5.00
> > May 30 16:05:37 build01 automount[4242]: lookup_nss_read_master: reading
> > master ldap auto.master
> > May 30 16:05:37 build01 automount[4242]: parse_server_string:
> > lookup(ldap): Attempting to parse LDAP information from string
> > "auto.master".
> > May 30 16:05:37 build01 automount[4242]: parse_server_string:
> > lookup(ldap): mapname auto.master
> > May 30 16:05:37 build01 automount[4242]: parse_ldap_config: ldap
> > authentication configured with the following options:
> > May 30 16:05:37 build01 automount[4242]: parse_ldap_config: use_tls: 0,
> > tls_required: 0, auth_required: 1, sasl_mech: (null)
> > May 30 16:05:37 build01 automount[4242]: parse_ldap_config: user:
> > (null), secret: unspecified, client principal: (null)
> > May 30 16:05:37 build01 automount[4242]: do_connect: auth_required: 1,
> > sasl_mech (null)
> > May 30 16:05:37 build01 automount[4242]: do_connect: lookup(ldap): ldap
> > anonymous bind returned 0
> > May 30 16:05:37 build01 automount[4242]: get_query_dn: lookup(ldap):
> > query dn ou=auto.master,ou=autofs,ou=services,dc=tech
> > May 30 16:05:37 build01 automount[4242]: unbind_ldap_connection: use_tls: 0
> > May 30 16:05:37 build01 automount[4242]: parse_init: parse(sun): init
> > gathered global options: (null)
> > May 30 16:05:37 build01 automount[4242]: mount_init: mount(bind):
> > bind_works = 1
> > May 30 16:05:37 build01 automount[4242]: do_connect: auth_required: 1,
> > sasl_mech (null)
> > May 30 16:05:37 build01 automount[4242]: do_connect: lookup(ldap): ldap
> > anonymous bind returned 0
> > May 30 16:05:37 build01 automount[4242]: lookup_read_master:
> > lookup(ldap): searching for "(objectclass=automount)" under
> > "ou=auto.master,ou=autofs,ou=services,dc=tech"
> > May 30 16:05:37 build01 automount[4242]: lookup_read_master:
> > lookup(ldap): examining entries
> > May 30 16:05:37 build01 automount[4242]: unbind_ldap_connection: use_tls: 0
> > May 30 16:05:37 build01 automount[4242]: master_do_mount: mounting /nfshome
> > May 30 16:05:37 build01 automount[4242]: lookup_nss_read_map: reading
> > map ldap ds01.tech:ou=auto.home,ou=autofs,ou=services,dc=tech
> > May 30 16:05:37 build01 automount[4242]: parse_server_string:
> > lookup(ldap): Attempting to parse LDAP information from string
> > "ds01.tech:ou=auto.home,ou=autofs,ou=services,dc=tech".
> > May 30 16:05:37 build01 automount[4242]: parse_server_string:
> > lookup(ldap): server "ds01.tech", base dn
> > "ou=auto.home,ou=autofs,ou=services,dc=tech"
> > May 30 16:05:37 build01 automount[4242]: parse_ldap_config: ldap
> > authentication configured with the following options:
> > May 30 16:05:37 build01 automount[4242]: parse_ldap_config: use_tls: 0,
> > tls_required: 0, auth_required: 1, sasl_mech: (null)
> > May 30 16:05:37 build01 automount[4242]: parse_ldap_config: user:
> > (null), secret: unspecified, client principal: (null)
> > May 30 16:05:37 build01 automount[4242]: do_connect: auth_required: 1,
> > sasl_mech (null)
> > May 30 16:05:37 build01 automount[4242]: do_connect: lookup(ldap): ldap
> > anonymous bind returned 0
> > May 30 16:05:37 build01 automount[4242]: get_query_dn: lookup(ldap):
> > query succeeded, no matches for (objectclass=automountmap)
> > May 30 16:05:37 build01 automount[4242]: unbind_ldap_connection: use_tls: 0
> > May 30 16:05:37 build01 automount[4242]: lookup_init: lookup(ldap):
> > failed to get query dn
> > May 30 16:05:37 build01 automount[4242]: do_read_map: lookup module ldap
> > failed
> > May 30 16:05:37 build01 automount[4242]: mount_autofs_indirect: failed
> > to read map for /nfshome
> > May 30 16:05:37 build01 automount[4242]: handle_mounts: mount of
> > /nfshome failed!
> > May 30 16:05:37 build01 automount[4242]: master_do_mount: failed to
> > startup mount
> > May 30 16:05:37 build01 automount[4242]: master_do_mount: mounting /mnt/nfs
> > May 30 16:05:37 build01 automount[4242]: lookup_nss_read_map: reading
> > map ldap ds01.tech:ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > May 30 16:05:37 build01 automount[4242]: parse_server_string:
> > lookup(ldap): Attempting to parse LDAP information from string
> > "ds01.tech:ou=auto.mnt,ou=autofs,ou=services,dc=tech".
> > May 30 16:05:37 build01 automount[4242]: parse_server_string:
> > lookup(ldap): server "ds01.tech", base dn
> > "ou=auto.mnt,ou=autofs,ou=services,dc=tech"
> > May 30 16:05:37 build01 automount[4242]: parse_ldap_config: ldap
> > authentication configured with the following options:
> > May 30 16:05:37 build01 automount[4242]: parse_ldap_config: use_tls: 0,
> > tls_required: 0, auth_required: 1, sasl_mech: (null)
> > May 30 16:05:37 build01 automount[4242]: parse_ldap_config: user:
> > (null), secret: unspecified, client principal: (null)
> > May 30 16:05:37 build01 automount[4242]: do_connect: auth_required: 1,
> > sasl_mech (null)
> > May 30 16:05:37 build01 automount[4242]: do_connect: lookup(ldap): ldap
> > anonymous bind returned 0
> > May 30 16:05:37 build01 automount[4242]: get_query_dn: lookup(ldap):
> > query succeeded, no matches for (objectclass=automountmap)
> > May 30 16:05:37 build01 automount[4242]: unbind_ldap_connection: use_tls: 0
> > May 30 16:05:37 build01 automount[4242]: lookup_init: lookup(ldap):
> > failed to get query dn
> > May 30 16:05:37 build01 automount[4242]: do_read_map: lookup module ldap
> > failed
> > May 30 16:05:37 build01 automount[4242]: mount_autofs_indirect: failed
> > to read map for /mnt/nfs
> > May 30 16:05:37 build01 automount[4242]: handle_mounts: mount of
> > /mnt/nfs failed!
> > May 30 16:05:37 build01 automount[4242]: master_do_mount: failed to
> > startup mount
> > May 30 16:05:37 build01 automount[4242]: master_read_master: no mounts
> > in table
> > ===
> >
> > ldapsearch -x '(objectclass=automountmap)':
> >
> > dn: ou=auto.master,ou=autofs,ou=services,dc=tech
> > ou: auto.master
> > objectClass: top
> > objectClass: organizationalunit
> > objectClass: automountmap
> >  
> > ===
> >  
> > ldapsearch -x '(objectclass=automount)':
> >
> > dn: cn=/nfshome,ou=auto.master,ou=autofs,ou=services,dc=tech
> > objectClass: automount
> > objectClass: top
> > cn: /nfshome
> > automountInformation:
> > ldap:ds01.tech:ou=auto.home,ou=autofs,ou=services,dc=tec
> >  h --timeout 60
> >
> > dn: cn=*,ou=auto.home,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049 fs01.tech:/export/home/&
> > cn: *
> > objectClass: automount
> > objectClass: top
> >
> > dn: cn=/mnt/nfs,ou=auto.master,ou=autofs,ou=services,dc=tech
> > objectClass: automount
> > objectClass: top
> > cn: /mnt/nfs
> > automountInformation:
> > ldap:ds01.tech:ou=auto.mnt,ou=autofs,ou=services,dc=tech
> >   --timeout 60
> >
> > dn: cn=repository,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049 fs01.giga:/export/repository
> > cn: repository
> > objectClass: automount
> > objectClass: top
> >
> > dn: cn=cvs,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: fs01.giga:/export/cvs
> > cn: cvs
> > objectClass: automount
> > objectClass: top
> >
> > dn: cn=svn,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049 fs01.giga:/export/svn
> > cn: svn
> > objectClass: automount
> > objectClass: top
> >  
> > dn: cn=builds,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049
> > fs01.giga:/export/builds/binary_r
> >  epository
> > cn: builds
> > objectClass: automount
> > objectClass: top
> >
> > dn: cn=fingerprint,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049 fs01.giga:/export/fingerprint
> > cn: fingerprint
> > objectClass: automount
> > objectClass: top
> >  
> > dn: cn=sms,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049 fs01.giga:/export/sms
> > cn: sms
> > objectClass: automount
> > objectClass: top
> >
> > dn: cn=xen,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049 fs01.giga:/export/xen
> > cn: xen
> > objectClass: automount
> > objectClass: top
> >
> > dn: cn=quadriga,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > cn: quadriga
> > automountInformation: rw,proto=tcp,port=2049 fs01.giga:/export/quadriga
> > objectClass: automount
> > objectClass: top
> >
> > dn: cn=tools,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049 fs01.giga:/export/tools
> > cn: tools
> > objectClass: automount
> > objectClass: top
> >  
> > dn: cn=nagioscmds,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049 fs01.giga:/export/nagioscmds
> > cn: nagioscmds
> > objectClass: automount
> > objectClass: top
> >  
> > dn: cn=BINARY_REPOSITORY,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049
> > fs01.giga:/export/builds/binary_r
> >  epository
> > cn: BINARY_REPOSITORY
> > objectClass: automount
> > objectClass: top
> >
> > dn: cn=tmp,ou=auto.mnt,ou=autofs,ou=services,dc=tech
> > automountInformation: rw,proto=tcp,port=2049 fs01.giga:/export/tmp
> > cn: tech
> > cn: tmp
> > objectClass: automount
> > objectClass: top
> >
> >
> >
> >
> > This e-mail is the property of Quadriga Worldwide Ltd, intended for the addressee only and confidential.  Any dissemination, copying or distribution of this message or any attachments is strictly prohibited.
> >
> > If you have received this message in error, please notify us immediately by replying to the message and deleting it from your computer.
> >
> > Messages sent to and from Quadriga may be monitored.
> >
> > Quadriga cannot guarantee any message delivery method is secure or error-free.  Information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses.
> >
> > We do not accept responsibility for any errors or omissions in this message and/or attachment that arise as a result of transmission.
> >
> > You should carry out your own virus checks before opening any attachment.
> >
> > Any views or opinions presented are solely those of the author and do not necessarily represent those of Quadriga.
> >
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
> >
> >   
> 
> 
> 
> This e-mail is the property of Quadriga Worldwide Ltd, intended for the addressee only and confidential.  Any dissemination, copying or distribution of this message or any attachments is strictly prohibited.
> 
> If you have received this message in error, please notify us immediately by replying to the message and deleting it from your computer.
> 
> Messages sent to and from Quadriga may be monitored.
> 
> Quadriga cannot guarantee any message delivery method is secure or error-free.  Information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses.
> 
> We do not accept responsibility for any errors or omissions in this message and/or attachment that arise as a result of transmission.
> 
> You should carry out your own virus checks before opening any attachment.
> 
> Any views or opinions presented are solely those of the author and do not necessarily represent those of Quadriga.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
