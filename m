From: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Subject: Re: autofs {3, 4,
 5} and bind mounts which point to other automount points
Date: Fri, 25 Aug 2006 15:49:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0608251540530.14075@frank.dcs.qmul.ac.uk>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk> 
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net> 
	<Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk> 
	<Pine.LNX.4.64.0608251506180.25004@raven.themaw.net> 
	<Pine.LNX.4.64.0608251917030.30523@raven.themaw.net> 
	<Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk>
	<1156516142.30971.35.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1156516142.30971.35.camel@raven.themaw.net>
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

At 22:29 +0800 Ian Kent wrote:

>> Aug 25 14:07:19 laurel automount[17416]: attempting to mount entry /homes/mb
>> Aug 25 14:07:19 laurel automount[17416]: mount(nfs): nfs: mount failure :/home/cream/home71/mb on /homes/mb
>
> This was broken for sure but I tested the usual cases.
>
> Did the patch apply cleanly?

Yup :) (see my update)

> And where's the rest of the output that will tell us the mount command
> that was actually used.
>
> Send daemon.* to a log and run with debug enabled.

Aug 25 15:42:18 laurel automount[22501]: handle_packet: type = 3
Aug 25 15:42:18 laurel automount[22501]: handle_packet_missing_indirect: token 3489, name mb, request pid 22628
Aug 25 15:42:18 laurel automount[22501]: attempting to mount entry /homes/mb
Aug 25 15:42:18 laurel automount[22501]: lookup_mount: lookup(ldap): looking up mb
Aug 25 15:42:18 laurel automount[22501]: lookup_one: lookup(ldap): searching for "(&(objectclass=automount)(|(cn=mb)(cn=/)))" under "ou=auto.homes,dc=dcs,dc=qmul,dc=ac,dc=uk"
Aug 25 15:42:18 laurel automount[22501]: do_connect: auth_required: 1, sasl_mech (null)
Aug 25 15:42:18 laurel automount[22501]: do_connect: lookup(ldap): ldap anonymous bind returned 0
Aug 25 15:42:18 laurel automount[22501]: lookup_one: lookup(ldap): getting first entry for cn="mb"
Aug 25 15:42:18 laurel automount[22501]: lookup_one: lookup(ldap): examining first entry
Aug 25 15:42:18 laurel automount[22501]: unbind_ldap_connection: use_tls: 2
Aug 25 15:42:18 laurel automount[22501]: lookup_mount: lookup(ldap): mb -> :/home/cream/home71/mb
Aug 25 15:42:18 laurel automount[22501]: parse_mount: parse(sun): expanded entry: :/home/cream/home71/mb
Aug 25 15:42:18 laurel automount[22501]: parse_mount: parse(sun): gathered options:
Aug 25 15:42:18 laurel automount[22501]: parse_mount: parse(sun): dequote(":/home/cream/home71/mb") -> :/home/cream/home71/mb
Aug 25 15:42:18 laurel automount[22501]: parse_mount: parse(sun): core of entry: options=, loc=:/home/cream/home71/mb
Aug 25 15:42:18 laurel automount[22501]: sun_mount: parse(sun): mounting root /homes, mountpoint mb, what :/home/cream/home71/mb, fstype nfs, options (null)
Aug 25 15:42:18 laurel automount[22501]: mount_mount: mount(nfs): root=/homes name=mb what=:/home/cream/home71/mb, fstype=nfs, options=(null)
Aug 25 15:42:18 laurel automount[22501]: mount_mount: mount(nfs): calling mkdir_path /homes/mb
Aug 25 15:42:18 laurel automount[22501]: mount_mount: mount(nfs): mb is local, attempt bind mount
Aug 25 15:42:18 laurel automount[22501]: mount_mount: mount(bind): calling mkdir_path /homes/mb
Aug 25 15:42:18 laurel automount[22501]: mount_mount: mount(bind): calling mount --bind -s  -o defaults /home/cream/home71/mb /homes/mb
Aug 25 15:42:18 laurel automount[22501]: >> mount: special device /home/cream/home71/mb does not exist
Aug 25 15:42:18 laurel automount[22501]: mount(nfs): nfs: mount failure :/home/cream/home71/mb on /homes/mb
Aug 25 15:42:18 laurel automount[22501]: send_fail: token = 3489
Aug 25 15:42:18 laurel automount[22501]: failed to mount /homes/mb

The desired "nested" behaviour is:

 	/homes/mb binds /home/cream/home71/mb
 		/home/cream/home71 binds /server/cream/export71
 			/server/cream/export71 nfsmounts cream:/export71

This way:
- my apps always use /homes/mb
- my infrastructure db knows I'm /home/x/y/mb 
- the actual nfs server can also be looked up
