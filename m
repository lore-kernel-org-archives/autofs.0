From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: Problem with autofs_home map
Date: Thu, 8 Nov 2007 13:27:55 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F041EE737@permls05.wde.woodside.com.au>
References: <x49abpqj76v.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <x49abpqj76v.fsf@segfault.boston.devel.redhat.com>
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

Hi Jeff

No the direct map (autofs.global) doesn't have any maps in /home.
Hopefully the below is useful.  Nothing (useful) ended up in
/var/log/debug.

CC

---
[root@las004 images]# > /var/log/debug
[root@las004 images]# ls -l /
total 215
lrwxrwxrwx    1 root   root      9 Oct 15 10:35 appl -> /nfs/appl
drwxr-xr-x    2 root   root   3072 Oct 12 16:01 bin
drwxr-xr-x    4 root   root   1024 Nov  5 10:07 boot
drwxr-xr-x    2 oracle root   4096 Nov  7 18:10 db_backup
drwxr-xr-x   10 root   root   6080 Nov  8 13:05 dev
drwxr-xr-x   83 root   root   8192 Nov  8 13:07 etc
drwxr-xr-x    3 root   root   1024 Oct 15 14:43 export
drwxr-xr-x    4 root   root   1024 Oct 12 11:05 home
dr-xr-xr-x    2 root   root   1024 Oct 15 10:33 hsm
drwxr-xr-x    2 root   root   1024 Aug 13  2004 initrd
drwxr-xr-x   12 root   root   6144 Nov  4 04:02 lib
drwx------    2 root   root  12288 Oct 12 10:16 lost+found
drwxr-xr-x    8 root   root   1024 Nov  7 12:17 media
drwxr-xr-x    2 root   root   1024 Apr 12  2007 misc
drwxr-xr-x    3 root   root   1024 Oct 24 08:29 mnt
dr-xr-xr-x    3 root   root   1024 Oct 25 12:49 nfs
drwxr-xr-x    4 root   root   1024 Oct 12 11:06 nocpulse
drwxr-xr-x    8 root   root   4096 Oct 12 11:06 opt
dr-xr-xr-x  351 root   root      0 Nov  7 12:15 proc
drwxr-xr-x    5 oracle dba    4096 Oct 15 14:21 rhnsat
drwxr-x---    6 root   root   1024 Nov  8 11:33 root
drwxr-xr-x    2 root   root   8192 Oct 12 16:01 sbin
drwxrwxrwx   78 wopr3w exo1 106496 Nov  8 13:08 scratch
drwxr-xr-x    2 root   root   1024 Oct 12 10:18 selinux
drwxr-xr-x    2 root   root   1024 Aug 13  2004 srv
drwxr-xr-x    9 root   root      0 Nov  7 12:16 sys
drwxr-xr-x    3 root   root   1024 Oct 15 14:56 tftpboot
drwxrwxrwt   12 root   root   4096 Nov  8 13:08 tmp
-rw-r--r--    1 root   root   2564 Oct 12 14:24 tmpsat.cert
drwxr-xr-x   17 root   root   4096 Oct 24 11:49 usr
drwxr-xr-x   22 root   root   4096 Oct 26 08:59 var
[root@las004 images]# cat /etc/auto.master
/-      autofs.global --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
/rhome  autofs.home   --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
--debug

[root@las004 images]# cat /etc/syslog.conf
# Log all kernel messages to the console.
# Logging much else clutters up the screen.
#kern.*                                                 /dev/console

# Log anything (except mail) of level info or higher.
# Don't log private authentication messages!
*.info;mail.none;authpriv.none;cron.none
/var/log/messages

# The authpriv file has restricted access.
authpriv.*                                              /var/log/secure

# Log all the mail messages in one place.
mail.*
-/var/log/maillog


# Log cron stuff
cron.*                                                  /var/log/cron

# Everybody gets emergency messages
*.emerg                                                 *

# Save news errors of level crit and higher in a special file.
uucp,news.crit                                          /var/log/spooler

# Save boot messages also to boot.log
local7.*
/var/log/boot.log


daemon.*                        /var/log/debug
[root@las004 images]# service syslog restart
Shutting down kernel logger:                               [  OK  ]
Shutting down system logger:                               [  OK  ]
Starting system logger:                                    [  OK  ]
Starting kernel logger:                                    [  OK  ]
[root@las004 images]# service autofs status
Configured Mount Points:
------------------------
/usr/sbin/automount --timeout=60 --ghost /home ldap
automountMapName=auto_home,o=unix,dc=woodside,dc=com,dc=au
nfsvers=3,tcp,rsize=32768,wsize=32768
/usr/sbin/automount --timeout=60 --ghost /- ldap
automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au
nfsvers=3,tcp,rsize=32768,wsize=32768

Active Mount Points:
--------------------
[root@las004 images]# service autofs start
Starting automount:                                        [  OK  ]
[root@las004 images]# service autofs status
Configured Mount Points:
------------------------
/usr/sbin/automount --timeout=60 --ghost /home ldap
automountMapName=auto_home,o=unix,dc=woodside,dc=com,dc=au
nfsvers=3,tcp,rsize=32768,wsize=32768
/usr/sbin/automount --timeout=60 --ghost /- ldap
automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au
nfsvers=3,tcp,rsize=32768,wsize=32768

Active Mount Points:
--------------------
/usr/sbin/automount --timeout=60 --ghost /home ldap
automountMapName=auto_home,o=unix,dc=woodside,dc=com,dc=au
nfsvers=3,tcp,rsize=32768,wsize=32768
/usr/sbin/automount --timeout=60 --ghost /- ldap
automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au
nfsvers=3,tcp,rsize=32768,wsize=32768
/usr/sbin/automount --submount --ghost --timeout=60 /nfs ldap
automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au nfsvers=3
tcp rsize=32768 wsize=32768
/usr/sbin/automount --submount --ghost --timeout=60 /hsm ldap
automountMapName=auto_global,o=unix,dc=woodside,dc=com,dc=au nfsvers=3
tcp rsize=32768 wsize=32768
[root@las004 images]# ls -l /
total 211
lrwxrwxrwx    1 root   root      9 Oct 15 10:35 appl -> /nfs/appl
drwxr-xr-x    2 root   root   3072 Oct 12 16:01 bin
drwxr-xr-x    4 root   root   1024 Nov  5 10:07 boot
drwxr-xr-x    2 oracle root   4096 Nov  7 18:10 db_backup
drwxr-xr-x   10 root   root   6080 Nov  8 13:09 dev
drwxr-xr-x   83 root   root   8192 Nov  8 13:09 etc
drwxr-xr-x    3 root   root   1024 Oct 15 14:43 export
drwxr-xr-x   16 root   root      0 Nov  8 13:09 home
drwxr-xr-x    3 root   root      0 Nov  8 13:09 hsm
drwxr-xr-x    2 root   root   1024 Aug 13  2004 initrd
drwxr-xr-x   12 root   root   6144 Nov  4 04:02 lib
drwx------    2 root   root  12288 Oct 12 10:16 lost+found
drwxr-xr-x    8 root   root   1024 Nov  7 12:17 media
drwxr-xr-x    2 root   root   1024 Apr 12  2007 misc
drwxr-xr-x    3 root   root   1024 Oct 24 08:29 mnt
drwxr-xr-x   92 root   root      0 Nov  8 13:09 nfs
drwxr-xr-x    4 root   root   1024 Oct 12 11:06 nocpulse
drwxr-xr-x    8 root   root   4096 Oct 12 11:06 opt
dr-xr-xr-x  356 root   root      0 Nov  7 12:15 proc
drwxr-xr-x    5 oracle dba    4096 Oct 15 14:21 rhnsat
drwxr-x---    6 root   root   1024 Nov  8 11:33 root
drwxr-xr-x    2 root   root   8192 Oct 12 16:01 sbin
drwxrwxrwx   78 wopr3w exo1 106496 Nov  8 13:08 scratch
drwxr-xr-x    2 root   root   1024 Oct 12 10:18 selinux
drwxr-xr-x    2 root   root   1024 Aug 13  2004 srv
drwxr-xr-x    9 root   root      0 Nov  7 12:16 sys
drwxr-xr-x    3 root   root   1024 Oct 15 14:56 tftpboot
drwxrwxrwt   12 root   root   4096 Nov  8 13:09 tmp
-rw-r--r--    1 root   root   2564 Oct 12 14:24 tmpsat.cert
drwxr-xr-x   17 root   root   4096 Oct 24 11:49 usr
drwxr-xr-x   22 root   root   4096 Oct 26 08:59 var
[root@las004 images]# cat /var/log/debug
Nov  8 13:09:17 las004 dhcpd: DHCPDISCOVER from 00:1a:64:2c:0d:ee via
eth2: network 10.240.59/24: no free leases
[root@las004 images]# service autofs stop
Stopping automount:                                        [  OK  ]
[root@las004 images]#
--- 

-----Original Message-----
From: Jeff Moyer [mailto:jmoyer@redhat.com] 
Sent: Thursday, 8 November 2007 2:29 AM
To: Coe, Colin C. (Unix Engineer)
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Problem with autofs_home map

"Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au> writes:

> Hi all
>
> I'm having a strange problem my autofs_home map. 
>
> RHEL AS4 (32bit)
> autofs-4.1.3-199.3
> Kernel 2.6.9-55.0.12
> nfs-utils 1.0.6-80
>  
> /etc/auto.master
> ---
> /rhome  autofs.home   --verbose --ghost
> nfsvers=3,tcp,rsize=32768,wsize=32768
> /-      autofs.global --verbose --ghost
> nfsvers=3,tcp,rsize=32768,wsize=32768
> ---
>
> /etc/nsswitch.conf
> ---
> snip
> automount:  ldap files
> snip
> ---
>
> autofs.home (from LDAP)
> ---
> usr4 server:/local/home-usr4
> usr3 server:/local/home-usr3
> usr2 server:/local/home-usr2
> usr1 server:/local/home-usr1
> ---
>
> I find that there is no '/rhome' directory and '/home' is 0 bytes in
> size where what should happen is '/home' is of 'normal' size (4096
> bytes) anf '/rhome' exists and is 0 bytes.
>
> Is this a bug or have I configured this box wrong?

The configuration looks sane to me.  Does your direct map have entries
for /home?  Could you provide a debug log?

Cheers,

Jeff

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
