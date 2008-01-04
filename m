From: Ian Kent <raven@themaw.net>
Subject: Re: master_notify: syntax error in map near [ bogus	option
	]
Date: Fri, 04 Jan 2008 10:45:44 +0900
Message-ID: <1199411144.3288.15.camel@raven.themaw.net>
References: <477CD7B8.1070002@3ds.com>  <477CFF21.20309@3ds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <477CFF21.20309@3ds.com>
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
To: Manfred.KNOPS@3ds.com
Cc: autofs@linux.kernel.org

On Thu, 2008-01-03 at 16:28 +0100, Knops, Manfred wrote:
> Knops, Manfred wrote:
> > (...)
> > # /home, auto.master, automount, abaqus.de
> > dn: 
> > automountKey=/home,automountMapName=auto.master,ou=automount,dc=abaqus,dc=de
> > objectClass: top
> > objectClass: automount
> > automountKey: /home
> > automountInformation: ldap 
> > 192.168.1.2:automountMapName=auto.home,ou=automount,dc=abaqus,dc=de 
> > --timeout=60
> [root@kerberos ~]# tail /tmp/automount.ldif
> dn: 
> automountKey=/home,automountMapName=auto.master,ou=automount,dc=abaqus,dc=de
> objectClass: top
> objectClass: automount
> automountKey: /home
> automountInformation: 
> ldap://192.168.1.2/automountMapName=auto.home,ou=automount,dc=abaqus,dc=de
> 
> I found one mistake by myself. I changed the automountInformation for /home.
> I changed from "ldap 192.168.1.2:auto..." to "ldap://192.168.1.2/auto...".

Not really a mistake. Version 5 is more strict about this but don't be
surprised if it starts to work again in later revisions because lot of
people do seem to use this even though it's not specified as valid.

The valid formats are ldap:[server:]dn or, more recently,
ldap:[//server/]dn, although the man page seems a little unclear now I
look at it. There are further restrictions on the dn in that it needs to
be either a map name alone or a full dn string including the base.

> 
> Now I have a sasl problem.
> Jan  3 16:18:55 hostB automount[12904]: Starting automounter version 
> 5.0.1-31, master map auto.master
> Jan  3 16:18:55 hostB automount[12904]: using kernel protocol version 5.00
> Jan  3 16:18:55 hostB automount[12904]: No worthy mechs found
> Jan  3 16:18:55 hostB automount[12904]: sasl_bind_mech: sasl_client 
> start failed with error: SASL(-4): no mechanism available: No worthy 
> mechs found
> Jan  3 16:18:55 hostB automount[12904]: lookup_init: lookup(ldap): 
> cannot initialize authentication setup
> Jan  3 16:18:55 hostB automount[12904]: mount_autofs_indirect: failed to 
> read map for /home
> Jan  3 16:18:55 hostB automount[12904]: handle_mounts: mount of /home 
> failed!
> Jan  3 16:18:55 hostB automount[12904]: master_do_mount: failed to 
> startup mount
> Jan  3 16:18:55 hostB automount[12904]: mounted indirect mount on /net 
> with timeout 60, freq 15 seconds
> Jan  3 16:18:55 hostB automount[12904]: ghosting enabled
> Jan  3 16:19:56 hostB automount[12904]: attempting to mount entry /net/gnome
> Jan  3 16:19:56 hostB automount[12904]: mounted /net/gnome
> Jan  3 16:20:09 hostB automount[12904]: mount still busy /net
> Jan  3 16:20:40 hostB last message repeated 2 times
> Jan  3 16:21:11 hostB last message repeated 2 times
> Jan  3 16:21:26 hostB automount[12904]: expiring path /net/gnome
> Jan  3 16:21:26 hostB automount[12904]: umounted offset mount 
> /net/gnome/backup/opt-abaqus/server
> Jan  3 16:21:26 hostB automount[12904]: expired /net/gnome
> 
> If someone has an idea, please feel free to help me.

Does this same connection information work OK for ldapsearch?

Ian
