From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: Problem with autofs_home map
Date: Fri, 16 Nov 2007 12:46:42 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F041EE76F@permls05.wde.woodside.com.au>
References: <BAC1D28A5AB852439A6914CA7AB4E63F041EE76E@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F041EE76E@permls05.wde.woodside.com.au>
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


Hi Ian

I've just seen autofs5 (yay!) in the RHEL4 channels so I'm giving it a
shot but it's not looking good so far.

/rhome still isn't created and the real /home is still getting over
ridden.  Also, automount5 is core dumping and /var/log/debug is still
empty.

Thanks

CC


---
[root@las004 /]# date
Fri Nov 16 12:43:49 WST 2007
[root@las004 /]# service autofs5 stop
Stopping automount5:                                       [  OK  ]
[root@las004 /]# > /var/log/debug
[root@las004 /]# # /rhome should *not* exist here...
[root@las004 /]# ls -ld /home /rhome
ls: /rhome: No such file or directory
drwxr-xr-x  4 root root 1024 Oct 12 11:05 /home
[root@las004 /]# cat /etc/auto.master
#
# $Id: auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $
#
# Sample auto.master file
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# For details of the format look at autofs(5).
#/misc  /etc/auto.misc --timeout=60
#/misc  /etc/auto.misc
#/net   /etc/auto.net
/-      autofs.global --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
/rhome  autofs.home   --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
--debug

[root@las004 /]# cat /etc/sysconfig/autofs5
LOCALOPTIONS=""
DAEMONOPTIONS="--timeout=60 --debug"
UNDERSCORETODOT=0
DISABLE_DIRECT=0

DEFAULT_MAP_OBJECT_CLASS="automountMap"
DEFAULT_ENTRY_OBJECT_CLASS="automount"
DEFAULT_MAP_ATTRIBUTE="automountMapName"
DEFAULT_ENTRY_ATTRIBUTE="automountKey"
DEFAULT_VALUE_ATTRIBUTE="automountInformation"
[root@las004 /]# cat /etc/syslog.conf
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
[root@las004 /]# service syslog restart
Shutting down kernel logger:                               [  OK  ]
Shutting down system logger:                               [  OK  ]
Starting system logger:                                    [  OK  ]
Starting kernel logger:                                    [  OK  ]
[root@las004 /]# service autofs5 status
automount5 is stopped
[root@las004 /]# service autofs5 start
Starting automount5:                                       [  OK  ]
[root@las004 /]# service autofs5 status
automount5 (pid 23416) is running...
[root@las004 /]# # /rhome *should* exist here...
[root@las004 /]# ls -ld /home /rhome
ls: /rhome: No such file or directory
drwxr-xr-x  16 root root 0 Nov 16 12:44 /home
[root@las004 /]# cat /var/log/debug
[root@las004 /]# file /core.*
/core.23296: ELF 32-bit LSB core file Intel 80386, version 1 (SYSV),
SVR4-style, from 'automount5'
[root@las004 /]# date
Fri Nov 16 12:44:04 WST 2007
[root@las004 /]#
---

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Coe, Colin C.
(Unix Engineer)
Sent: Friday, 16 November 2007 11:07 AM
To: Ian Kent
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Problem with autofs_home map


Hey Ian

OK, but the debug.log was attached previously .  It only contained:
---
> [root@las004 images]# cat /var/log/debug
> Nov  8 13:09:17 las004 dhcpd: DHCPDISCOVER from 00:1a:64:2c:0d:ee via
> eth2: network 10.240.59/24: no free leases
---

Nothing autofs related was put in the log file.

Thanks

CC

<snip>

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
