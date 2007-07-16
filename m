From: Rich West <Rich.West@wesmo.com>
Subject: Re: autofs5 + ldap + ldap replication
Date: Mon, 16 Jul 2007 15:54:28 -0400
Message-ID: <469BCCF4.50608@wesmo.com>
References: <469985DF.9010607@wesmo.com>	<1184599068.3344.5.camel@raven.themaw.net>	<469BB868.4080603@wesmo.com>
	<x497ip0w4xj.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x497ip0w4xj.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Jeff Moyer wrote:
> ==> On Mon, 16 Jul 2007 14:26:48 -0400, Rich West <Rich.West@wesmo.com> said:
>
> Rich> Ian Kent wrote:
>   
>>> On Sat, 2007-07-14 at 22:26 -0400, Rich West wrote:
>>>
>>>       
>>>> We have an LDAP infrastructure where all of the automount maps 
>>>> (auto.master and auto.home) are pulled out of LDAP.  In this instance, 
>>>> we have two LDAP servers, one primary, and the other is a replica.  The 
>>>> clients are all Fedora/Redhat systems.  Most of them are running 
>>>> autofs4, and a few newer ones are running autofs5.
>>>>
>>>>         
>>> Version information for autofs would be good.
>>> I looks like we're not getting all the debug info in the log, are you
>>> sending all priorities of facility daemon to the log?
>>>
>>>       
>
> Rich> The Fedora Core 5 clients are using autofs 4.1.4, and the Fedora Core 6
> Rich> clients are using 5.0.1 (RC3).
>
> Rich> As far as logging goes, what is the log facility used for autofs?  I've
> Rich> got syslog splitting apart some of the messages to separate files
> Rich> (local2 is designated for named for us, with local4 designated to LDAP,
> Rich> &etc).
>
> Autofs uses the daemon facility.

Ok.. grabbed that and dropped that in to a file of its own..  Where the
heck is it getting the mapname of "ldap"?

Thanks!
-Rich



Jul 16 15:21:08 myhost automount[1852]: Starting automounter version
5.0.1-0.rc3.31, master map auto.master
Jul 16 15:21:08 myhost automount[1852]: using kernel protocol version 5.00
Jul 16 15:21:08 myhost automount[1852]: lookup_nss_read_master: reading
master files auto.master
Jul 16 15:21:08 myhost automount[1852]: parse_init: parse(sun): init
gathered global options: (null)
Jul 16 15:21:08 myhost automount[1852]: mount_init: mount(bind):
bind_works = 1 Jul 16 15:21:08 myhost automount[1852]:
lookup_read_master: lookup(file): read entry /misc
Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
lookup(file): read entry /net
Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
lookup(file): read entry +auto.master
Jul 16 15:21:08 myhost automount[1852]: lookup_nss_read_master: reading
master files auto.master
Jul 16 15:21:08 myhost automount[1852]: parse_init: parse(sun): init
gathered global options: (null)
Jul 16 15:21:08 myhost automount[1852]: lookup_nss_read_master: reading
master ldap auto.master
Jul 16 15:21:08 myhost automount[1852]: parse_server_string:
lookup(ldap): Attempting to parse LDAP information from string
"auto.master".
Jul 16 15:21:08 myhost automount[1852]: parse_server_string:
lookup(ldap): mapname auto.master
Jul 16 15:21:08 myhost automount[1852]: parse_ldap_config: ldap
authentication configured with the following options:
Jul 16 15:21:08 myhost automount[1852]: parse_ldap_config: use_tls: 0,
tls_required: 0, auth_required: 1, sasl_mech: (null)
Jul 16 15:21:08 myhost automount[1852]: parse_ldap_config: user: (null),
secret: unspecified, client principal: (null)
Jul 16 15:21:08 myhost automount[1852]: do_connect: auth_required: 1,
sasl_mech (null)
Jul 16 15:21:08 myhost automount[1852]: do_connect: lookup(ldap): ldap
anonymous bind returned 0
Jul 16 15:21:08 myhost automount[1852]: get_query_dn: lookup(ldap):
query dn ou=auto.master,dc=mydomain,dc=com
Jul 16 15:21:08 myhost automount[1852]: unbind_ldap_connection: use_tls: 0
Jul 16 15:21:08 myhost automount[1852]: parse_init: parse(sun): init
gathered global options: (null)
Jul 16 15:21:08 myhost automount[1852]: do_connect: auth_required: 1,
sasl_mech (null)
Jul 16 15:21:08 myhost automount[1852]: do_connect: lookup(ldap): ldap
anonymous bind returned 0
Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
lookup(ldap): searching for "(objectclass=automount)" under
"ou=auto.master,dc=mydomain,dc=com"
Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
lookup(ldap): examining entries
Jul 16 15:21:08 myhost automount[1852]: master_echo: .
Jul 16 15:21:08 myhost automount[1852]: master_echo: .
Jul 16 15:21:08 myhost automount[1852]: master_echo: :
Jul 16 15:21:08 myhost automount[1852]: master_echo: .
Jul 16 15:21:08 myhost automount[1852]: unbind_ldap_connection: use_tls: 0
Jul 16 15:21:08 myhost automount[1852]: master_do_mount: mounting /misc
Jul 16 15:21:08 myhost automount[1852]: lookup_nss_read_map: reading map
file /etc/auto.misc
Jul 16 15:21:08 myhost automount[1852]: parse_init: parse(sun): init
gathered global options: (null)
Jul 16 15:21:08 myhost automount[1852]: mount_init: mount(bind):
bind_works = 1
Jul 16 15:21:08 myhost automount[1852]: mounted indirect mount on /misc
with timeout 60, freq 15 seconds
Jul 16 15:21:08 myhost automount[1852]: master_do_mount: mounting /net
Jul 16 15:21:08 myhost automount[1852]: lookup_nss_read_map: reading map
hosts (null)
Jul 16 15:21:08 myhost automount[1852]: parse_init: parse(sun): init
gathered global options: (null)
Jul 16 15:21:08 myhost automount[1852]: mounted indirect mount on /net
with timeout 60, freq 15 seconds
Jul 16 15:21:08 myhost automount[1852]: master_do_mount: mounting /home
Jul 16 15:21:08 myhost automount[1852]: lookup_nss_read_map: reading map
files ldap
Jul 16 15:21:08 myhost automount[1852]: read_file_source_instance: file
map /etc/ldap not found
Jul 16 15:21:08 myhost automount[1852]: lookup_nss_read_map: reading map
ldap ldap
Jul 16 15:21:08 myhost automount[1852]: parse_server_string:
lookup(ldap): Attempting to parse LDAP information from string "ldap".
Jul 16 15:21:08 myhost automount[1852]: parse_server_string:
lookup(ldap): mapname ldap
Jul 16 15:21:08 myhost automount[1852]: parse_ldap_config: ldap
authentication configured with the following options:
Jul 16 15:21:08 myhost automount[1852]: parse_ldap_config: use_tls: 0,
tls_required: 0, auth_required: 1, sasl_mech: (null)
Jul 16 15:21:08 myhost automount[1852]: parse_ldap_config: user: (null),
secret: unspecified, client principal: (null)
Jul 16 15:21:08 myhost automount[1852]: do_connect: auth_required: 1,
sasl_mech (null)
Jul 16 15:21:08 myhost automount[1852]: do_connect: lookup(ldap): ldap
anonymous bind returned 0
Jul 16 15:21:08 myhost automount[1852]: get_query_dn: lookup(ldap):
query succeeded, no matches for (&(objectclass=automountMap)(ou=ldap))
Jul 16 15:21:08 myhost automount[1852]: unbind_ldap_connection: use_tls: 0
Jul 16 15:21:08 myhost automount[1852]: lookup_init: lookup(ldap):
failed to get query dn
Jul 16 15:21:08 myhost automount[1852]: do_read_map: lookup module ldap
failed
Jul 16 15:21:08 myhost automount[1852]: mount_autofs_indirect: failed to
read map for /home
Jul 16 15:21:08 myhost automount[1852]: handle_mounts: mount of /home
failed!
Jul 16 15:21:08 myhost automount[1852]: master_do_mount: failed to
startup mount
Jul 16 15:21:24 myhost automount[1852]: st_expire: state 1 path /net
Jul 16 15:21:24 myhost automount[1852]: expire_proc: exp_proc =
1077037376 path /net
Jul 16 15:21:24 myhost automount[1852]: expire_cleanup: got thid
1077037376 path /net stat 0
Jul 16 15:21:24 myhost automount[1852]: expire_cleanup: sigchld: exp
1077037376 finished, switching from 2 to 1
Jul 16 15:21:24 myhost automount[1852]: st_ready: st_ready(): state = 2
path /net
Jul 16 15:21:36 myhost automount[1852]: st_expire: state 1 path /misc
Jul 16 15:21:36 myhost automount[1852]: expire_proc: exp_proc =
1077037376 path /misc
Jul 16 15:21:36 myhost automount[1852]: expire_cleanup: got thid
1077037376 path /misc stat 0
Jul 16 15:21:36 myhost automount[1852]: expire_cleanup: sigchld: exp
1077037376 finished, switching from 2 to 1
Jul 16 15:21:36 myhost automount[1852]: st_ready: st_ready(): state = 2
path /misc
Jul 16 15:21:39 myhost automount[1852]: st_expire: state 1 path /net
Jul 16 15:21:39 myhost automount[1852]: expire_proc: exp_proc =
1077037376 path /net
Jul 16 15:21:39 myhost automount[1852]: expire_cleanup: got thid
1077037376 path /net stat 0
Jul 16 15:21:39 myhost automount[1852]: expire_cleanup: sigchld: exp
1077037376 finished, switching from 2 to 1
Jul 16 15:21:39 myhost automount[1852]: st_ready: st_ready(): state = 2
path /net
Jul 16 15:21:40 myhost automount[1852]: do_notify_state: signal 15
Jul 16 15:21:40 myhost automount[1852]: master_notify_state_change: sig
15 switching /misc from 1 to 5
Jul 16 15:21:40 myhost automount[1852]: st_prepare_shutdown: state 1
path /misc
Jul 16 15:21:40 myhost automount[1852]: expire_proc: exp_proc =
1078090048 path /misc
Jul 16 15:21:40 myhost automount[1852]: expire_cleanup: got thid
1078090048 path /misc stat 0
Jul 16 15:21:40 myhost automount[1852]: expire_cleanup: sigchld: exp
1078090048 finished, switching from 5 to 7
Jul 16 15:21:40 myhost automount[1852]: umount_multi: path /misc incl 0
Jul 16 15:21:40 myhost automount[1852]: master_notify_state_change: sig
15 switching /net from 1 to 5
Jul 16 15:21:40 myhost automount[1852]: st_prepare_shutdown: state 1
path /net
Jul 16 15:21:40 myhost automount[1852]: expire_proc: exp_proc =
1078090048 path /net
Jul 16 15:21:40 myhost automount[1852]: expire_cleanup: got thid
1078090048 path /net stat 0
Jul 16 15:21:40 myhost automount[1852]: expire_cleanup: sigchld: exp
1078090048 finished, switching from 5 to 7
Jul 16 15:21:40 myhost automount[1852]: umount_multi: path /net incl 0
Jul 16 15:21:40 myhost automount[1852]: umounted indirect mount /misc
Jul 16 15:21:40 myhost automount[1852]: umounted indirect mount /net
Jul 16 15:21:40 myhost automount[1852]: shut down path /misc
Jul 16 15:21:40 myhost automount[1852]: shut down path /net
