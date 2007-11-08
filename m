From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs_home map
Date: Thu, 08 Nov 2007 23:15:02 +0900
Message-ID: <1194531302.25888.6.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F041EE737@permls05.wde.woodside.com.au>
	<x49lk99gwoq.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49lk99gwoq.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org, "Coe,
	Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>

On Wed, 2007-11-07 at 23:58 -0500, Jeff Moyer wrote:
> "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au> writes:
> 
> > Hi Jeff
> >
> > No the direct map (autofs.global) doesn't have any maps in /home.
> > Hopefully the below is useful.  Nothing (useful) ended up in
> > /var/log/debug.
> 
> OK, I'm guessing you have ONE_AUTO_MASTER set to 1 in
> /etc/sysconfig/autofs, is that right?
> 
> > [root@las004 images]# cat /etc/auto.master
> > /-      autofs.global --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
> > /rhome  autofs.home   --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
> > --debug
> 
> Notice that the listing of your configured mount points does not
> include those from your file map, /etc/auto.master:
> 
> > [root@las004 images]# service autofs status
> > Configured Mount Points:
> > ------------------------
> > /usr/sbin/automount --timeout=60 --ghost /home ldap
> > automountMapName=auto_home,o=unix,dc=woodside,dc=com,dc=au
> > nfsvers=3,tcp,rsize=32768,wsize=32768
> > /usr/sbin/automount --timeout=60 --ghost /- ldap
> > automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au
> > nfsvers=3,tcp,rsize=32768,wsize=32768
> 
> Which is why we also get no debug output in the log.
> 
> > [root@las004 images]# service autofs start
> > Starting automount:                                        [  OK  ]
> > [root@las004 images]# service autofs status
> > Configured Mount Points:
> > ------------------------
> > /usr/sbin/automount --timeout=60 --ghost /home ldap
> > automountMapName=auto_home,o=unix,dc=woodside,dc=com,dc=au
> > nfsvers=3,tcp,rsize=32768,wsize=32768
> > /usr/sbin/automount --timeout=60 --ghost /- ldap
> > automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au
> > nfsvers=3,tcp,rsize=32768,wsize=32768
> >
> > Active Mount Points:
> > --------------------
> > /usr/sbin/automount --timeout=60 --ghost /home ldap
> > automountMapName=auto_home,o=unix,dc=woodside,dc=com,dc=au
> > nfsvers=3,tcp,rsize=32768,wsize=32768
> > /usr/sbin/automount --timeout=60 --ghost /- ldap
> > automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au
> > nfsvers=3,tcp,rsize=32768,wsize=32768
> > /usr/sbin/automount --submount --ghost --timeout=60 /nfs ldap
> > automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au nfsvers=3
> > tcp rsize=32768 wsize=32768
> > /usr/sbin/automount --submount --ghost --timeout=60 /hsm ldap
> > automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au nfsvers=3
> > tcp rsize=32768 wsize=32768
> 
> And now note that your direct map includes entries in the root level
> of the file system.  This is not supported in autofs v4.  So, that's
> the reason you're getting 0 length directories for /home, /nfs, and
> /hsm.

Actually, I think Colins direct map (probably) doesn't have single level
mount entries (it didn't used to). So these mounts are just the result
of the pseudo direct mount implementation in v4 mounting the top level
directory of the tree defined by the entries in the map.

Ian
