From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with LDAP map syntax in 5.0.3.
Date: Sat, 31 Jan 2009 09:02:41 +0900
Message-ID: <1233360161.3065.9.camel@zeus.themaw.net>
References: <20090130150523.1416d116@fornix.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090130150523.1416d116@fornix.cl.cam.ac.uk>
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
To: Ian Grant <Ian.Grant@cl.cam.ac.uk>
Cc: autofs@linux.kernel.org

On Fri, 2009-01-30 at 15:05 +0000, Ian Grant wrote:
> me@mypc:/> ldapsearch -x -H ldap://nnn.nnn.nnn.nnn/ -b automountMapName=auto_master,dc=example,dc=com '(objectclass=automount)'
> # extended LDIF
> #
> # LDAPv3
> # base <automountMapName=auto_master,dc=example,dc=com> with scope subtree
> # filter: (objectclass=automount)
> # requesting: ALL
> #
> 
> # /auto/homes, auto_master, cl.cam.ac.uk
> dn: automountKey=/auto/homes,automountMapName=auto_master,dc=example,dc=com
> objectClass: top
> objectClass: automount
> automountKey: /auto/homes
> automountInformation: ldap:automountMapName=autofs_home,dc=example,dc=com

It's possibly autofs-5.0.3-map-type-in-map-name.patch patch that is
broken, have a look at autofs-5.0.3-map-type-in-map-name-fix.patch
patch.

> 
> # /auto/groups, auto_master, cl.cam.ac.uk
> dn: automountKey=/auto/groups,automountMapName=auto_master,dc=example,dc=com
> objectClass: top
> objectClass: automount
> automountKey: /auto/groups
> automountInformation: ldap:automountMapName=autofs_group,dc=example,dc=com
> 
> # /auto/userfiles, auto_master, cl.cam.ac.uk
> dn: automountKey=/auto/userfiles,automountMapName=auto_master,dc=example,dc=com
> objectClass: top
> objectClass: automount
> automountKey: /auto/userfiles
> automountInformation: ldap:automountMapName=autofs_userfile,dc=example,dc=com
> 
> # /auto/anfs, auto_master, cl.cam.ac.uk
> dn: automountKey=/auto/anfs,automountMapName=auto_master,dc=example,dc=com
> objectClass: top
> objectClass: automount
> automountKey: /auto/anfs
> automountInformation: ldap:automountMapName=autofs_anf,dc=example,dc=com
> 
> # /Nfs/Mounts, auto_master, cl.cam.ac.uk
> dn: automountKey=/Nfs/Mounts,automountMapName=auto_master,dc=example,dc=com
> objectClass: top
> objectClass: automount
> automountKey: /Nfs/Mounts
> automountInformation: ldap:automountMapName=autofs_Nfs,dc=example,dc=com
> 
> # search result
> search: 2
> result: 0 Success
> 
> # numResponses: 6
> # numEntries: 5
> me@mypc:/> ldapsearch -x -H ldap://nnn.nnn.nnn.nnn/ -b automountMapName=autofs_home,dc=example,dc=com \
>  '(objectclass=automount)' | head -22
> # extended LDIF
> #
> # LDAPv3
> # base <automountMapName=autofs_home,dc=example,dc=com> with scope subtree
> # filter: (objectclass=automount)
> # requesting: ALL
> #
> 
> # acn, autofs_home, cl.cam.ac.uk
> dn: automountKey=user1,automountMapName=autofs_home,dc=example,dc=com
> objectClass: automount
> automountKey: user1
> automountInformation: -rw,nosuid,noac,bg,vers=3,tcp,timeo=600,rsize=32768,wsiz
>  e=32768,hard,intr,sec=krb5 netappfiler:/vol/userfiles/user1/unix_home
> 
> # am, autofs_home, cl.cam.ac.uk
> dn: automountKey=user2,automountMapName=autofs_home,dc=example,dc=com
> objectClass: automount
> automountKey: user2
> automountInformation: -rw,nosuid,noac,bg,vers=3,tcp,timeo=600,rsize=32768,wsiz
>  e=32768,hard,intr,sec=krb5 netappfiler:/vol/userfiles/user2/unix_home
> 
> me@mypc:/> egrep -v "^$|^#" /etc/nsswitch.conf
> passwd: files ldap
> group:  files ldap
> hosts:  files mdns4_minimal [NOTFOUND=return] dns
> networks:       files dns
> services:       files
> protocols:      files
> rpc:    files
> ethers: files
> netmasks:       files
> netgroup:       files nis
> publickey:      files
> bootparams:     files
> automount:      files ldap
> aliases:        files
> me@mypc:/> egrep -v "^$|^#" /etc/openldap/ldap.conf
> TLS_REQCERT     allow
> host    128.232.x.x 128.232.y.y 128.232.z.z
> base    dc=example,dc=com
> me@mypc:/> egrep -v "^$|^#" /etc/ldap.conf
> host 128.232.x.x 128.232.y.y 128.232.z.z
> base dc=example,dc=com
> ldap_version 3
> scope one
> debug 0
> idle_timelimit 3600
> bind_timelimit 5
> timelimit 5
> bind_policy soft
> nss_initgroups_ignoreusers root
> nss_base_passwd ou=People,dc=cl,dc=cam,dc=ac,dc=uk?one
> nss_base_group  ou=Groups,dc=cl,dc=cam,dc=ac,dc=uk?one
> pam_groupdn cn=mypc,ou=HostGroups,dc=cl,dc=cam,dc=ac,dc=uk
> 
> me@mypc:/> tail /var/log/messages
> 
> Jan 30 11:28:08 mypc automount[9445]: Starting automounter version 5.0.3, master map auto.master
> Jan 30 11:28:08 mypc automount[9445]: using kernel protocol version 5.00
> Jan 30 11:28:08 mypc automount[9445]: lookup_nss_read_master: reading master files auto.master
> Jan 30 11:28:08 mypc automount[9445]: parse_init: parse(sun): init gathered global options: (null)
> Jan 30 11:28:08 mypc automount[9445]: lookup_read_master: lookup(file): read entry /net
> Jan 30 11:28:08 mypc automount[9445]: lookup_read_master: lookup(file): read entry +auto_master
> Jan 30 11:28:08 mypc automount[9445]: lookup_nss_read_master: reading master files auto_master
> Jan 30 11:28:08 mypc automount[9445]: lookup(file): file map /etc/auto_master missing or not readable
> Jan 30 11:28:08 mypc automount[9445]: lookup_nss_read_master: reading master ldap auto_master
> Jan 30 11:28:08 mypc automount[9445]: parse_server_string: lookup(ldap): Attempting to parse LDAP information from string "auto_master".
> Jan 30 11:28:08 mypc automount[9445]: parse_server_string: lookup(ldap): mapname auto_master
> Jan 30 11:28:08 mypc automount[9445]: parse_ldap_config: lookup(ldap): ldap authentication configured with the following options:
> Jan 30 11:28:08 mypc automount[9445]: parse_ldap_config: lookup(ldap): use_tls: 0, tls_required: 0, auth_required: 1, sasl_mech: (null)
> Jan 30 11:28:08 mypc automount[9445]: parse_ldap_config: lookup(ldap): user: (null), secret: unspecified, client principal: (null) credential cache: (null)
> Jan 30 11:28:08 mypc automount[9445]: do_bind: lookup(ldap): auth_required: 1, sasl_mech (null)
> Jan 30 11:28:08 mypc automount[9445]: do_bind: lookup(ldap): ldap anonymous bind returned 0
> Jan 30 11:28:09 mypc automount[9445]: get_query_dn: lookup(ldap): found query dn automountMapName=auto_master,dc=example,dc=com
> Jan 30 11:28:09 mypc automount[9445]: parse_init: parse(sun): init gathered global options: (null)
> Jan 30 11:28:09 mypc automount[9445]: do_bind: lookup(ldap): auth_required: 1, sasl_mech (null)
> Jan 30 11:28:09 mypc automount[9445]: do_bind: lookup(ldap): ldap anonymous bind returned 0
> Jan 30 11:28:09 mypc automount[9445]: lookup_read_master: lookup(ldap): searching for "(objectclass=automount)" under "automountMapName=auto_master,dc=example,dc=com"
> Jan 30 11:28:09 mypc automount[9445]: lookup_read_master: lookup(ldap): examining entries
> Jan 30 11:28:09 mypc automount[9445]: syntax error in map near [ /auto/homes ]
> Jan 30 11:28:09 mypc automount[9445]: syntax error while parsing map.
> Jan 30 11:28:09 mypc automount[9445]: syntax error while parsing map.
> Jan 30 11:28:09 mypc automount[9445]: syntax error while parsing map.
> Jan 30 11:28:09 mypc automount[9445]: syntax error while parsing map.
> Jan 30 11:28:09 mypc automount[9445]: master_do_mount: mounting /net
> Jan 30 11:28:09 mypc automount[9445]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-net
> Jan 30 11:28:09 mypc automount[9445]: lookup_nss_read_map: reading map file /etc/auto.net
> Jan 30 11:28:09 mypc automount[9445]: parse_init: parse(sun): init gathered global options: (null)
> Jan 30 11:28:09 mypc automount[9445]: mounted indirect mount for /net with timeout 600, freq 150 seconds
> Jan 30 11:28:09 mypc automount[9445]: st_ready: st_ready(): state = 0 path /net
> Jan 30 11:28:09 mypc automount[9445]: ghosting enabled
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
