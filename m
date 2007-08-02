From: Jim Summers <jsummers@bachman.cs.ou.edu>
Subject: Re: AutoFS5 Ldap base strangeness
Date: Thu, 02 Aug 2007 16:31:01 -0500
Message-ID: <46B24D15.4070306@cs.ou.edu>
References: <46B23DFB.7060200@cs.ou.edu>	<x49odhpek9z.fsf@segfault.boston.devel.redhat.com>	<46B247E7.3020902@cs.ou.edu>
	<x498x8tej4o.fsf@segfault.boston.devel.redhat.com>
Reply-To: jsummers@bachman.cs.ou.edu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050300060306080801050105"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x498x8tej4o.fsf@segfault.boston.devel.redhat.com>
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

This is a multi-part message in MIME format.
--------------050300060306080801050105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Moyer wrote:
> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
> 
>> Jeff Moyer wrote:
>>> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
>>>
>>>> hello all,
>>>>
>>>> I am just about to get my automounting working with autofs5 and my ldap.  I am
>>>> able to start the automount daemon and it loads and reads /home map, which
>>>> points at ou=auto.home for the user's home directory location and options.
>>>>
>>>> but when i attempt to su - <user> it can not mount the user's home.  here is
>>>> what i see in the ldap server's access log:
>>>> ===
>>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 SRCH
>>>> base="cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu" scope=2
>>>> filter="(&(objectClass=automount)(|(automountKey=tmac)(automountKey=/)))"
>>>> attrs="automountKey automountInformation"
>>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 RESULT err=0 tag=101 nentries=0
>>>> etime=0
>>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=2 UNBIND
>>>> ===
>>>>
>>>> the weird part of the above is, in the first line it says "cn=sfu" but then
>>>> also says automountKey=tmac
>>>>
>>>> the su command is:  su - tmac
>>>>
>>>> so the correct username is tmac not sfu.
>>>>
>>>> any ideas where the sfu thing is coming from??
>>>>
>>>> is the info cached somewhere?  I ask because when I start the daemon, i can
>>>> see in the logs where it does:
>>>> ===
>>>> [31/Jul/2007:15:35:40 -0500] conn=8536 op=1 SRCH
>>>> base="ou=auto.home,dc=it,dc=ou,dc=edu" scope=2
>>>> filter="(objectClass=automount)" attrs="1.1"
>>>> [31/Jul/2007:15:35:40 -0500] conn=8536 op=1 RESULT err=0 tag=101 nentries=617
>>>> etime=0
>>>> ===
>>>> which is returning 617 entries.
>>>>
>>>> not sure what i have wroong here??
>>> Please send a debug log:
>>>   http://people.redhat.com/jmoyer
>> Will do Jeff.  Just to cut some time out how can i generate the debug
>> log?  In /etc/sysconfig/autofs, i have set:
>>
>> LOGGING="debug"
>> and
>> OPTIONS="-v"
>>
>> but that seems to only increase the noise in /var/log/messages a little.
>>
>> i do have the following installed:
>>
>> autofs-5.0.1-20
>> autofs-debuginfo-5.0.1-20
> 

>>From the web page to which I pointed you:
> 
> ---
> debug output.
> 
>     * Add a line like the following to your /etc/syslog.conf:
> 
>       daemon.*			/var/log/debug
> 
> Restart syslogd (or send it a HUP signal).
> ---
> 
> -Jeff

Sorry Jeff.  Got it done.  i have attached the debug file.  let me know if I 
should inline it or what works best.

from what i can decipher it appears to be trying to pull the auto.home stuff 
from under the cn=sfu.  but that doesn't make sense to me.

thanks again.

> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------

--------------050300060306080801050105
Content-Type: text/plain;
 name="debug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug"

Aug  2 16:21:44 leech automount[13929]: Starting automounter version 5.0.1-20, master map auto.master
Aug  2 16:21:44 leech automount[13929]: using kernel protocol version 5.00
Aug  2 16:21:44 leech automount[13929]: lookup_nss_read_master: reading master files auto.master
Aug  2 16:21:44 leech automount[13929]: parse_init: parse(sun): init gathered global options: (null)
Aug  2 16:21:44 leech automount[13929]: mount_init: mount(bind): bind_works = 1
Aug  2 16:21:44 leech automount[13929]: lookup_read_master: lookup(file): read entry /misc
Aug  2 16:21:44 leech automount[13929]: lookup_read_master: lookup(file): read entry /net
Aug  2 16:21:44 leech automount[13929]: lookup_read_master: lookup(file): read entry /home
Aug  2 16:21:44 leech automount[13929]: master_do_mount: mounting /misc
Aug  2 16:21:44 leech automount[13929]: lookup_nss_read_map: reading map file /etc/auto.misc
Aug  2 16:21:44 leech automount[13929]: parse_init: parse(sun): init gathered global options: (null)
Aug  2 16:21:44 leech automount[13929]: mount_init: mount(bind): bind_works = 1
Aug  2 16:21:44 leech automount[13929]: mounted indirect mount on /misc with timeout 300, freq 75 seconds
Aug  2 16:21:44 leech automount[13929]: master_do_mount: mounting /net
Aug  2 16:21:44 leech automount[13929]: lookup_nss_read_map: reading map hosts (null)
Aug  2 16:21:44 leech automount[13929]: parse_init: parse(sun): init gathered global options: (null)
Aug  2 16:21:44 leech automount[13929]: mounted indirect mount on /net with timeout 300, freq 75 seconds
Aug  2 16:21:44 leech automount[13929]: master_do_mount: mounting /home
Aug  2 16:21:44 leech automount[13929]: lookup_nss_read_map: reading map ldap //landin/ou=auto.home,dc=it,dc=ou,dc=edu
Aug  2 16:21:44 leech automount[13929]: parse_server_string: lookup(ldap): Attempting to parse LDAP information from string "//landin/ou=auto.home,dc=it,dc=ou,dc=edu".
Aug  2 16:21:44 leech automount[13929]: parse_server_string: lookup(ldap): server "landin", base dn "ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:21:44 leech automount[13929]: parse_ldap_config: ldap authentication configured with the following options: 
Aug  2 16:21:44 leech automount[13929]: parse_ldap_config: use_tls: 0, tls_required: 0, auth_required: 1, sasl_mech: (null) 
Aug  2 16:21:44 leech automount[13929]: parse_ldap_config: user: (null), secret: unspecified, client principal: (null) 
Aug  2 16:21:44 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:21:44 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:21:44 leech automount[13929]: get_query_dn: lookup(ldap): query dn cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu
Aug  2 16:21:44 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:21:44 leech automount[13929]: parse_init: parse(sun): init gathered global options: (null)
Aug  2 16:21:44 leech automount[13929]: mounted indirect mount on /home with timeout 300, freq 75 seconds
Aug  2 16:22:52 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:52 leech automount[13929]: handle_packet_missing_indirect: token 100, name tmac, request pid 13941
Aug  2 16:22:52 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:52 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:52 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:52 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:52 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:52 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:52 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:52 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:52 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:52 leech automount[13929]: send_fail: token = 100
Aug  2 16:22:52 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:52 leech automount[13929]: handle_packet_missing_indirect: token 101, name tmac, request pid 13941
Aug  2 16:22:52 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:52 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:52 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:52 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:52 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:52 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:52 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:52 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:52 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:52 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 101
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 102, name tmac, request pid 13941
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 102
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 103, name tmac, request pid 13941
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 103
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 104, name tmac, request pid 13947
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 104
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 105, name tmac, request pid 13947
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 105
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 106, name tmac, request pid 13941
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 106
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 107, name tmac, request pid 13941
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 107
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 108, name tmac, request pid 13941
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 108
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 109, name tmac, request pid 13941
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 109
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 110, name tmac, request pid 13941
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 110
Aug  2 16:22:53 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:53 leech automount[13929]: handle_packet_missing_indirect: token 111, name tmac, request pid 13941
Aug  2 16:22:53 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:53 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:53 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:53 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:53 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:53 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:53 leech automount[13929]: send_fail: token = 111
Aug  2 16:22:53 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:54 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:54 leech automount[13929]: handle_packet_missing_indirect: token 112, name tmac, request pid 13941
Aug  2 16:22:54 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:54 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:54 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:54 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:54 leech automount[13929]: send_fail: token = 112
Aug  2 16:22:54 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:54 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:54 leech automount[13929]: handle_packet_missing_indirect: token 113, name tmac, request pid 13941
Aug  2 16:22:54 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:54 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:54 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:54 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:54 leech automount[13929]: send_fail: token = 113
Aug  2 16:22:54 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:54 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:54 leech automount[13929]: handle_packet_missing_indirect: token 114, name tmac, request pid 13941
Aug  2 16:22:54 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:54 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:54 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:54 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:54 leech automount[13929]: send_fail: token = 114
Aug  2 16:22:54 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:54 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:54 leech automount[13929]: handle_packet_missing_indirect: token 115, name tmac, request pid 13941
Aug  2 16:22:54 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:54 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:54 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:54 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:54 leech automount[13929]: send_fail: token = 115
Aug  2 16:22:54 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:54 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:54 leech automount[13929]: handle_packet_missing_indirect: token 116, name tmac, request pid 13941
Aug  2 16:22:54 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:54 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:54 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:54 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:54 leech automount[13929]: send_fail: token = 116
Aug  2 16:22:54 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:54 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:54 leech automount[13929]: handle_packet_missing_indirect: token 117, name tmac, request pid 13941
Aug  2 16:22:54 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:54 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:54 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:54 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:54 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:54 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:54 leech automount[13929]: send_fail: token = 117
Aug  2 16:22:54 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:57 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:57 leech automount[13929]: handle_packet_missing_indirect: token 118, name tmac, request pid 13941
Aug  2 16:22:57 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:57 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:57 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:57 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:57 leech automount[13929]: send_fail: token = 118
Aug  2 16:22:57 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:57 leech automount[13929]: handle_packet_missing_indirect: token 119, name tmac, request pid 13941
Aug  2 16:22:57 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:57 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:57 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:57 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:57 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:57 leech automount[13929]: send_fail: token = 119
Aug  2 16:22:57 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:57 leech automount[13929]: handle_packet_missing_indirect: token 120, name tmac, request pid 13941
Aug  2 16:22:57 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:57 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:57 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:57 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:57 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:57 leech automount[13929]: send_fail: token = 120
Aug  2 16:22:57 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:57 leech automount[13929]: handle_packet_missing_indirect: token 121, name tmac, request pid 13941
Aug  2 16:22:57 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:57 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:57 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:57 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:57 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:57 leech automount[13929]: send_fail: token = 121
Aug  2 16:22:57 leech automount[13929]: handle_packet: type = 3
Aug  2 16:22:57 leech automount[13929]: handle_packet_missing_indirect: token 122, name tmac, request pid 13941
Aug  2 16:22:57 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:22:57 leech automount[13929]: attempting to mount entry /home/tmac
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): looking up tmac
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))" under "cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu"
Aug  2 16:22:57 leech automount[13929]: do_connect: auth_required: 1, sasl_mech (null)
Aug  2 16:22:57 leech automount[13929]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): getting first entry for automountKey="tmac"
Aug  2 16:22:57 leech automount[13929]: lookup_one: lookup(ldap): got answer, but no entry for (&(objectclass=automount)(|(automountKey=tmac)(automountKey=/)))
Aug  2 16:22:57 leech automount[13929]: unbind_ldap_connection: use_tls: 0
Aug  2 16:22:57 leech automount[13929]: lookup_mount: lookup(ldap): check indirect map failure
Aug  2 16:22:57 leech automount[13929]: send_fail: token = 122
Aug  2 16:22:57 leech automount[13929]: failed to mount /home/tmac
Aug  2 16:23:02 leech automount[13929]: do_notify_state: signal 15
Aug  2 16:23:02 leech automount[13929]: master_notify_state_change: sig 15 switching /misc from 1 to 5
Aug  2 16:23:02 leech automount[13929]: st_prepare_shutdown: state 1 path /misc
Aug  2 16:23:02 leech automount[13929]: expire_proc: exp_proc = 3082414992 path /misc
Aug  2 16:23:02 leech automount[13929]: expire_cleanup: got thid 3082414992 path /misc stat 0
Aug  2 16:23:02 leech automount[13929]: expire_cleanup: sigchld: exp 3082414992 finished, switching from 5 to 7
Aug  2 16:23:02 leech automount[13929]: umount_multi: path /misc incl 0
Aug  2 16:23:02 leech automount[13929]: master_notify_state_change: sig 15 switching /net from 1 to 5
Aug  2 16:23:02 leech automount[13929]: st_prepare_shutdown: state 1 path /net
Aug  2 16:23:02 leech automount[13929]: expire_proc: exp_proc = 3082414992 path /net
Aug  2 16:23:02 leech automount[13929]: expire_cleanup: got thid 3082414992 path /net stat 0
Aug  2 16:23:02 leech automount[13929]: expire_cleanup: sigchld: exp 3082414992 finished, switching from 5 to 7
Aug  2 16:23:02 leech automount[13929]: umount_multi: path /net incl 0
Aug  2 16:23:02 leech automount[13929]: master_notify_state_change: sig 15 switching /home from 1 to 5
Aug  2 16:23:02 leech automount[13929]: st_prepare_shutdown: state 1 path /home
Aug  2 16:23:02 leech automount[13929]: expire_proc: exp_proc = 3082414992 path /home
Aug  2 16:23:02 leech automount[13929]: expire_cleanup: got thid 3082414992 path /home stat 0
Aug  2 16:23:02 leech automount[13929]: expire_cleanup: sigchld: exp 3082414992 finished, switching from 5 to 7
Aug  2 16:23:02 leech automount[13929]: umount_multi: path /home incl 0
Aug  2 16:23:02 leech automount[13929]: umounted indirect mount /home
Aug  2 16:23:02 leech automount[13929]: umounted indirect mount /misc
Aug  2 16:23:02 leech automount[13929]: umounted indirect mount /net
Aug  2 16:23:02 leech automount[13929]: shut down path /home
Aug  2 16:23:02 leech automount[13929]: shut down path /misc
Aug  2 16:23:02 leech automount[13929]: shut down path /net

--------------050300060306080801050105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------050300060306080801050105--

