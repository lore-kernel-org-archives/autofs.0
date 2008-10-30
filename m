From: Ian Kent <raven@themaw.net>
Subject: Re: autofs-5.0.3 segfaulting when HUP'ed
Date: Thu, 30 Oct 2008 11:44:26 +0900
Message-ID: <1225334666.3012.38.camel@zeus.themaw.net>
References: <Pine.LNX.4.64.0810291158340.1841@elr.eragrp.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0810291158340.1841@elr.eragrp.pbz>
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
To: Ryan Go <ryan@rentec.com>
Cc: autofs@linux.kernel.org

On Wed, 2008-10-29 at 12:48 -0400, Ryan Go wrote:
> Hello all,
> 
> We've been running into an issue where autofs would segfault when it gets 
> a HUP signal.
> 
> Here's the version details:
> 
> SuSE 11.0 (both suse kernels 2.6.25.5-1.1 & 2.6.25.16-0.1)
> autofs-5.0.3 (patched up to yesterday's patches except for the kernel 
> patch)
> using only LDAP for maps
> 
> I've can reliably reproduce the segfault with a very simplified master 
> map.
> 
> From /var/log/messages:
> Oct 29 12:22:13 monster1400 kernel: automount[8203]: segfault at 
> 7f98372985b0 ip 7f98372985b0 sp 415050f8 error 14 in 
> libresolv-2.8.so[7f9837a05000+11000]
> 
> Here's my map (output from ldapsearch):
> dn: ou=auto_master_linux_ryan,ou=Automount,dc=rentec,dc=com
> automountMapName: auto_master_linux_ryan
> objectClass: automountMap
> objectClass: top
> ou: auto_master_linux_ryan
> 
> AutomountInformation: 
> ldap:///ou=auto_home_ryan,ou=Automount,dc=rentec,dc=com -rw,hard,intr,nosuid,nodev,lock --timeout 43200
> automountKey: /home
> cn: /home
> objectClass: automount
> 
> $ ldapsearch -LLL -x -b ou=auto_home_ryan,ou=automount,dc=rentec,dc=com
> dn: ou=auto_home_ryan,ou=Automount,dc=rentec,dc=com
> automountMapName: auto_home_ryan
> objectClass: automountMap
> objectClass: top
> ou: auto_home_ryan
> 
> dn: cn=ryan,ou=auto_home_ryan,ou=Automount,dc=rentec,dc=com
> automountInformation: nfsserver:/vol/vol3/home/ryan
> automountKey: ryan
> cn: ryan
> objectClass: automount
> 
> 
> Here's the syslog output when ran with debug:
> Oct 29 12:22:09 monster1400 syslog-ng[2869]: last message repeated 2 times
> Oct 29 12:22:09 monster1400 automount[8192]: Starting automounter version 
> 5.0.3, master map auto_master_linux_ryan
> Oct 29 12:22:09 monster1400 automount[8192]: using kernel protocol version 
> 5.00
> Oct 29 12:22:09 monster1400 automount[8192]: lookup_nss_read_master: 
> reading master ldap auto_master_linux_ryan
> Oct 29 12:22:09 monster1400 automount[8192]: parse_server_string: 
> lookup(ldap): Attempting to parse LDAP information from string 
> "auto_master_linux_ryan".
> Oct 29 12:22:09 monster1400 automount[8192]: parse_server_string: 
> lookup(ldap): mapname auto_master_linux_ryan
> Oct 29 12:22:09 monster1400 automount[8192]: parse_ldap_config: 
> lookup(ldap): ldap authentication configured with the following options:
> Oct 29 12:22:09 monster1400 automount[8192]: parse_ldap_config: 
> lookup(ldap): use_tls: 0, tls_required: 0, auth_required: 1, sasl_mech: 
> (null)
> Oct 29 12:22:09 monster1400 automount[8192]: parse_ldap_config: 
> lookup(ldap): user: (null), secret: unspecified, client principal: (null) 
> credential cache: (null)
> Oct 29 12:22:09 monster1400 automount[8192]: do_bind: lookup(ldap): 
> auth_required: 1, sasl_mech (null)
> Oct 29 12:22:09 monster1400 automount[8192]: do_bind: lookup(ldap): ldap 
> anonymous bind returned 0
> Oct 29 12:22:09 monster1400 automount[8192]: get_query_dn: lookup(ldap): 
> found query dn ou=auto_master_linux_ryan,ou=Automount,dc=rentec,dc=com
> Oct 29 12:22:09 monster1400 automount[8192]: parse_init: parse(sun): init 
> gathered global options: (null)
> Oct 29 12:22:09 monster1400 automount[8192]: do_bind: lookup(ldap): 
> auth_required: 1, sasl_mech (null)
> Oct 29 12:22:09 monster1400 automount[8192]: do_bind: lookup(ldap): ldap 
> anonymous bind returned 0
> Oct 29 12:22:09 monster1400 automount[8192]: lookup_read_master: 
> lookup(ldap): searching for "(objectclass=automount)" under 
> "ou=auto_master_linux_ryan,ou=Automount,dc=rentec,dc=com"
> Oct 29 12:22:09 monster1400 automount[8192]: lookup_read_master: 
> lookup(ldap): examining entries
> Oct 29 12:22:09 monster1400 automount[8192]: /
> Oct 29 12:22:09 monster1400 syslog-ng[2869]: last message repeated 2 times
> Oct 29 12:22:09 monster1400 automount[8192]: master_do_mount: mounting 
> /home
> Oct 29 12:22:09 monster1400 automount[8192]: automount_path_to_fifo: fifo 
> name /var/run/autofs.fifo-home
> Oct 29 12:22:09 monster1400 automount[8192]: lookup_nss_read_map: reading 
> map ldap ldap:ou=auto_home_ryan,ou=Automount,dc=rentec,dc=com
> Oct 29 12:22:09 monster1400 automount[8192]: parse_server_string: 
> lookup(ldap): Attempting to parse LDAP information from string 
> "ldap:ou=auto_home_ryan,ou=Automount,dc=rentec,dc=com".
> Oct 29 12:22:09 monster1400 automount[8192]: parse_server_string: 
> lookup(ldap): server "(default)", base dn 
> "ou=auto_home_ryan,ou=Automount,dc=rentec,dc=com"
> Oct 29 12:22:09 monster1400 automount[8192]: parse_ldap_config: 
> lookup(ldap): ldap authentication configured with the following options:
> Oct 29 12:22:09 monster1400 automount[8192]: parse_ldap_config: 
> lookup(ldap): use_tls: 0, tls_required: 0, auth_required: 1, sasl_mech: 
> (null)
> Oct 29 12:22:09 monster1400 automount[8192]: parse_ldap_config: 
> lookup(ldap): user: (null), secret: unspecified, client principal: (null) 
> credential cache: (null)
> Oct 29 12:22:09 monster1400 automount[8192]: do_bind: lookup(ldap): 
> auth_required: 1, sasl_mech (null)
> Oct 29 12:22:09 monster1400 automount[8192]: do_bind: lookup(ldap): ldap 
> anonymous bind returned 0
> Oct 29 12:22:09 monster1400 automount[8192]: get_query_dn: lookup(ldap): 
> found query dn ou=auto_home_ryan,ou=Automount,dc=rentec,dc=com
> Oct 29 12:22:09 monster1400 automount[8192]: parse_init: parse(sun): init 
> gathered global options: rw,hard,intr,nosuid,nodev,lock
> Oct 29 12:22:09 monster1400 automount[8192]: mounted indirect mount for 
> /home with timeout 43200, freq 10800 seconds
> Oct 29 12:22:09 monster1400 automount[8192]: st_ready: st_ready(): state = 
> 0 path /home
> Oct 29 12:22:13 monster1400 automount[8192]: re-reading master map 
> auto_master_linux_ryan
> Oct 29 12:22:13 monster1400 automount[8192]: lookup_nss_read_master: 
> reading master ldap auto_master_linux_ryan
> Oct 29 12:22:13 monster1400 automount[8192]: parse_server_string: 
> lookup(ldap): Attempting to parse LDAP information from string 
> "auto_master_linux_ryan".
> Oct 29 12:22:13 monster1400 automount[8192]: parse_server_string: 
> lookup(ldap): mapname auto_master_linux_ryan
> Oct 29 12:22:13 monster1400 automount[8192]: parse_ldap_config: 
> lookup(ldap): ldap authentication configured with the following options:
> Oct 29 12:22:13 monster1400 automount[8192]: parse_ldap_config: 
> lookup(ldap): use_tls: 0, tls_required: 0, auth_required: 1, sasl_mech: 
> (null)
> Oct 29 12:22:13 monster1400 automount[8192]: parse_ldap_config: 
> lookup(ldap): user: (null), secret: unspecified, client principal: (null) 
> credential cache: (null)
> Oct 29 12:22:13 monster1400 automount[8192]: do_bind: lookup(ldap): 
> auth_required: 1, sasl_mech (null)
> Oct 29 12:22:13 monster1400 automount[8192]: do_bind: lookup(ldap): ldap 
> anonymous bind returned 0
> Oct 29 12:22:13 monster1400 automount[8192]: get_query_dn: lookup(ldap): 
> found query dn ou=auto_master_linux_ryan,ou=Automount,dc=rentec,dc=com
> Oct 29 12:22:13 monster1400 automount[8192]: parse_init: parse(sun): init 
> gathered global options: (null)
> Oct 29 12:22:13 monster1400 automount[8192]: do_bind: lookup(ldap): 
> auth_required: 1, sasl_mech (null)
> Oct 29 12:22:13 monster1400 automount[8192]: do_bind: lookup(ldap): ldap 
> anonymous bind returned 0
> Oct 29 12:22:13 monster1400 automount[8192]: lookup_read_master: 
> lookup(ldap): searching for "(objectclass=automount)" under 
> "ou=auto_master_linux_ryan,ou=Automount,dc=rentec,dc=com"
> Oct 29 12:22:13 monster1400 automount[8192]: lookup_read_master: 
> lookup(ldap): examining entries
> Oct 29 12:22:13 monster1400 automount[8192]: /
> 
> It segfaults whether there's an active mount or none.
> 
> I can install the debugging symbols rpm and provide a backtrace from gdb. 
> Please let me know if this would be helpful or if you would need more 
> information.
> 
> I appreciate any help you could provide.

Grab:
autofs-5.0.3-library-reload-fix.patch
autofs-5.0.3-expire-thread-create-cond-handling.patch

as well, uploaded to kernel.org just now, might take a while to sync to
the mirrors.

I'm not sure this solves the problem but an initial report was positive.
Let me know how it goes.

Ian
