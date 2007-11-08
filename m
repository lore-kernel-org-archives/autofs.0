From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: Problem with autofs_home map
Date: Thu, 8 Nov 2007 14:17:13 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F041EE73A@permls05.wde.woodside.com.au>
References: <x49lk99gwoq.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org


Nope :) ONE_AUTO_MASTER is set to 0 (zero).

I just noticed these in /var/log/messages
--
Nov  8 13:09:14 las004 nsswitch: nsswitch: couldn't find map
autofs.global
Nov  8 13:09:14 las004 nsswitch: nsswitch: couldn't find map autofs.home
--

The reason for the /rhome entry is to workaround the annoying local
users that Satellite server creates under /home.  With autofs running
with our standard maps:
---
/home   autofs.home   --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
/-      autofs.global --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
---
Satellite server throws lots of errors because the homedirs (and hence
scripts and logs) used by nocpulse and nocops aren't available.

I'm hoping that once /rhome gets properly automounted, I can create some
symlinks so normal users can log in and get their NFS home dirs mounted.

Thanks

CC


-----Original Message-----
From: Jeff Moyer [mailto:jmoyer@redhat.com] 
Sent: Thursday, 8 November 2007 1:59 PM
To: Coe, Colin C. (Unix Engineer)
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Problem with autofs_home map

"Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au> writes:

> Hi Jeff
>
> No the direct map (autofs.global) doesn't have any maps in /home.
> Hopefully the below is useful.  Nothing (useful) ended up in
> /var/log/debug.

OK, I'm guessing you have ONE_AUTO_MASTER set to 1 in
/etc/sysconfig/autofs, is that right?

> [root@las004 images]# cat /etc/auto.master
> /-      autofs.global --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
> /rhome  autofs.home   --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
> --debug

Notice that the listing of your configured mount points does not
include those from your file map, /etc/auto.master:

> [root@las004 images]# service autofs status
> Configured Mount Points:
> ------------------------
> /usr/sbin/automount --timeout=60 --ghost /home ldap
> automountMapName=auto_home,o=unix,dc=woodside,dc=com,dc=au
> nfsvers=3,tcp,rsize=32768,wsize=32768
> /usr/sbin/automount --timeout=60 --ghost /- ldap
> automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au
> nfsvers=3,tcp,rsize=32768,wsize=32768

Which is why we also get no debug output in the log.

> [root@las004 images]# service autofs start
> Starting automount:                                        [  OK  ]
> [root@las004 images]# service autofs status
> Configured Mount Points:
> ------------------------
> /usr/sbin/automount --timeout=60 --ghost /home ldap
> automountMapName=auto_home,o=unix,dc=woodside,dc=com,dc=au
> nfsvers=3,tcp,rsize=32768,wsize=32768
> /usr/sbin/automount --timeout=60 --ghost /- ldap
> automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au
> nfsvers=3,tcp,rsize=32768,wsize=32768
>
> Active Mount Points:
> --------------------
> /usr/sbin/automount --timeout=60 --ghost /home ldap
> automountMapName=auto_home,o=unix,dc=woodside,dc=com,dc=au
> nfsvers=3,tcp,rsize=32768,wsize=32768
> /usr/sbin/automount --timeout=60 --ghost /- ldap
> automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au
> nfsvers=3,tcp,rsize=32768,wsize=32768
> /usr/sbin/automount --submount --ghost --timeout=60 /nfs ldap
> automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au nfsvers=3
> tcp rsize=32768 wsize=32768
> /usr/sbin/automount --submount --ghost --timeout=60 /hsm ldap
> automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au nfsvers=3
> tcp rsize=32768 wsize=32768

And now note that your direct map includes entries in the root level
of the file system.  This is not supported in autofs v4.  So, that's
the reason you're getting 0 length directories for /home, /nfs, and
/hsm.

Thanks so much for providing such detailed debug data.  It really
makes a difference when trying to figure out these configuration
issues!

-Jeff

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
