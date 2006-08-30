From: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Subject: Re: autofs {3, 4,
 5} and bind mounts which point to other automount points
Date: Wed, 30 Aug 2006 20:44:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0608302028550.4441@frank.dcs.qmul.ac.uk>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk> 
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net> 
	<Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk> 
	<Pine.LNX.4.64.0608251506180.25004@raven.themaw.net> 
	<Pine.LNX.4.64.0608251917030.30523@raven.themaw.net> 
	<Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk> 
	<Pine.LNX.4.64.0608251417500.14075@frank.dcs.qmul.ac.uk> 
	<1156516669.30971.43.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608271549370.21043@raven.themaw.net>
	<1156849871.15241.9.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1156849871.15241.9.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org

On Aug 29 Ian Kent wrote:

>> Can you try this patch in addition to the previous patch please.
>
> There was a mistake in this patch.
> Use this one instead please.

Sorry for the delay, I've been away singing..

Your patch applied cleanlyish (just line wrapping to deal with), and now 
it does *most* of the right things.

Aug 30 20:09:31 laurel automount[12035]: handle_packet: type = 3
Aug 30 20:09:31 laurel automount[12035]: handle_packet_missing_indirect: token 1, name mb, request pid 12055
Aug 30 20:09:31 laurel automount[12035]: attempting to mount entry /homes/mb
Aug 30 20:09:31 laurel automount[12035]: lookup_mount: lookup(ldap): looking up mb
Aug 30 20:09:31 laurel automount[12035]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(cn=mb)(cn=/)))" under "ou=auto.homes,dc=dcs,dc=qmul,dc=ac,dc=uk"
Aug 30 20:09:31 laurel automount[12035]: do_connect: auth_required: 1, sasl_mech (null)
Aug 30 20:09:31 laurel automount[12035]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug 30 20:09:31 laurel automount[12035]: lookup_one: lookup(ldap): getting first entry for cn="mb"
Aug 30 20:09:31 laurel automount[12035]: lookup_one: lookup(ldap): examining first entry
Aug 30 20:09:31 laurel automount[12035]: unbind_ldap_connection: use_tls: 2
Aug 30 20:09:31 laurel automount[12035]: lookup_mount: lookup(ldap): mb -> :/home/cream/home71/mb
Aug 30 20:09:31 laurel automount[12035]: parse_mount: parse(sun): expanded entry: :/home/cream/home71/mb
Aug 30 20:09:31 laurel automount[12035]: parse_mount: parse(sun): gathered options: 
Aug 30 20:09:31 laurel automount[12035]: parse_mount: parse(sun): dequote(":/home/cream/home71/mb") -> :/home/cream/home71/mb
Aug 30 20:09:31 laurel automount[12035]: parse_mount: parse(sun): core of entry: options=, loc=:/home/cream/home71/mb
Aug 30 20:09:31 laurel automount[12035]: sun_mount: parse(sun): mounting root /homes, mountpoint mb, what :/home/cream/home71/mb, fstype nfs, options (null)
Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(nfs): root=/homes name=mb what=:/home/cream/home71/mb, fstype=nfs, options=(null)
Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(nfs): calling mkdir_path /homes/mb
Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(nfs): mb is local, attempt bind mount

[so far, so good]

Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(bind): calling mkdir_path /homes/mb
Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(bind): calling mount --bind -s  -o defaults /home/cream/home71/mb /homes/mb
Aug 30 20:09:31 laurel automount[12035]: handle_packet: type = 3
Aug 30 20:09:31 laurel automount[12035]: handle_packet_missing_indirect: token 2, name home71, request pid 12057
Aug 30 20:09:31 laurel automount[12035]: attempting to mount entry /home/cream/home71
Aug 30 20:09:31 laurel automount[12035]: lookup_mount: lookup(ldap): looking up home71
Aug 30 20:09:31 laurel automount[12035]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(cn=home71)(cn=/)))" under "ou=auto.home.cream,dc=dcs,dc=qmul,dc=ac,dc=uk"
Aug 30 20:09:31 laurel automount[12035]: do_connect: auth_required: 1, sasl_mech (null)
Aug 30 20:09:31 laurel automount[12035]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug 30 20:09:31 laurel automount[12035]: lookup_one: lookup(ldap): getting first entry for cn="home71"
Aug 30 20:09:31 laurel automount[12035]: lookup_one: lookup(ldap): examining first entry
Aug 30 20:09:31 laurel automount[12035]: unbind_ldap_connection: use_tls: 2
Aug 30 20:09:31 laurel automount[12035]: lookup_mount: lookup(ldap): home71 -> :/server/cream/export71/users
Aug 30 20:09:31 laurel automount[12035]: parse_mount: parse(sun): expanded entry: :/server/cream/export71/users
Aug 30 20:09:31 laurel automount[12035]: parse_mount: parse(sun): gathered options: 
Aug 30 20:09:31 laurel automount[12035]: parse_mount: parse(sun): dequote(":/server/cream/export71/users") -> :/server/cream/export71/users
Aug 30 20:09:31 laurel automount[12035]: parse_mount: parse(sun): core of entry: options=, loc=:/server/cream/export71/users
Aug 30 20:09:31 laurel automount[12035]: sun_mount: parse(sun): mounting root /home/cream, mountpoint home71, what :/server/cream/export71/users, fstype nfs, options (null)
Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(nfs): root=/home/cream name=home71 what=:/server/cream/export71/users, fstype=nfs, options=(null)
Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(nfs): calling mkdir_path /home/cream/home71
Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(nfs): home71 is local, attempt bind mount
Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(bind): calling mkdir_path /home/cream/home71
Aug 30 20:09:31 laurel automount[12035]: mount_mount: mount(bind): calling mount --bind -s  -o defaults /server/cream/export71/users /home/cream/home71
Aug 30 20:09:31 laurel automount[12035]: handle_packet: type = 3
Aug 30 20:09:31 laurel automount[12035]: handle_packet_missing_indirect: token 3, name export71, request pid 12059
Aug 30 20:09:31 laurel automount[12035]: attempting to mount entry /server/cream/export71
Aug 30 20:09:32 laurel automount[12035]: lookup_mount: lookup(ldap): looking up export71
Aug 30 20:09:32 laurel automount[12035]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(cn=export71)(cn=/)))" under "ou=auto.server.cream,dc=dcs,dc=qmul,dc=ac,dc=uk"
Aug 30 20:09:32 laurel automount[12035]: do_connect: auth_required: 1, sasl_mech (null)
Aug 30 20:09:32 laurel automount[12035]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug 30 20:09:32 laurel automount[12035]: lookup_one: lookup(ldap): getting first entry for cn="export71"
Aug 30 20:09:32 laurel automount[12035]: lookup_one: lookup(ldap): examining first entry
Aug 30 20:09:32 laurel automount[12035]: unbind_ldap_connection: use_tls: 2
Aug 30 20:09:32 laurel automount[12035]: lookup_mount: lookup(ldap): export71 -> -rw,rsize=8192,wsize=8192,nosuid,hard,intr,lock,proto=udp,nfsvers=3 cream:/export71
Aug 30 20:09:32 laurel automount[12035]: parse_mount: parse(sun): expanded entry: -rw,rsize=8192,wsize=8192,nosuid,hard,intr,lock,proto=udp,nfsvers=3 cream:/export71
Aug 30 20:09:32 laurel automount[12035]: parse_mount: parse(sun): gathered options: rw,rsize=8192,wsize=8192,nosuid,hard,intr,lock,proto=udp,nfsvers=3
Aug 30 20:09:32 laurel automount[12035]: parse_mount: parse(sun): dequote("cream:/export71") -> cream:/export71
Aug 30 20:09:32 laurel automount[12035]: parse_mount: parse(sun): core of entry: options=rw,rsize=8192,wsize=8192,nosuid,hard,intr,lock,proto=udp,nfsvers=3, loc=cream:/export71
Aug 30 20:09:32 laurel automount[12035]: sun_mount: parse(sun): mounting root /server/cream, mountpoint export71, what cream:/export71, fstype nfs, options rw,rsize=8192,wsize=8192,nosuid,hard,intr,lock,proto=udp,nfsvers=3
Aug 30 20:09:32 laurel automount[12035]: mount_mount: mount(nfs): root=/server/cream name=export71 what=cream:/export71, fstype=nfs, options=rw,rsize=8192,wsize=8192,nosuid,hard,intr,lock,proto=udp,nfsvers=3
Aug 30 20:09:32 laurel automount[12035]: mount_mount: mount(nfs): nfs options="rw,rsize=8192,wsize=8192,nosuid,hard,intr,lock,proto=udp,nfsvers=3", nosymlink=0, ro=0
Aug 30 20:09:32 laurel automount[12035]: mount_mount: mount(nfs): calling mkdir_path /server/cream/export71
Aug 30 20:09:32 laurel automount[12035]: mount_mount: mount(nfs): calling mount -t nfs -s -o rw,rsize=8192,wsize=8192,nosuid,hard,intr,lock,proto=udp,nfsvers=3 cream:/export71 /server/cream/export71
Aug 30 20:09:32 laurel automount[12035]: mount(nfs): mounted cream:/export71 on /server/cream/export71
Aug 30 20:09:32 laurel automount[12035]: send_ready: token = 3
Aug 30 20:09:32 laurel automount[12035]: mounted /server/cream/export71
Aug 30 20:09:32 laurel automount[12035]: mount_mount: mount(bind): mounted /server/cream/export71/users type bind on /home/cream/home71
Aug 30 20:09:32 laurel automount[12035]: send_ready: token = 2
Aug 30 20:09:32 laurel automount[12035]: mounted /home/cream/home71

[so far, so good, I think]

Aug 30 20:09:32 laurel automount[12035]: mount(nfs): nfs: mount failure :/home/cream/home71/mb on /homes/mb
Aug 30 20:09:32 laurel automount[12035]: send_fail: token = 1
Aug 30 20:09:32 laurel automount[12035]: failed to mount /homes/mb

Not sure why it wants to nfs-mount something it previously thought should 
be a bind mount. Hope the log is useful, though.

Thanks

Matt
