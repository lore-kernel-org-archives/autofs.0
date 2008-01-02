From: Ian Kent <raven@themaw.net>
Subject: Re: automount won't start - just hangs
Date: Wed, 02 Jan 2008 10:55:44 +0900
Message-ID: <1199238944.3072.10.camel@raven.themaw.net>
References: <flbove$pg9$1@ger.gmane.org>
	<1199188197.3246.1.camel@raven.themaw.net> <fldr8g$t60$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <fldr8g$t60$1@ger.gmane.org>
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
To: Jim Duda <jim@duda.tzo.com>
Cc: autofs@linux.kernel.org

On Tue, 2008-01-01 at 11:54 -0500, Jim Duda wrote:
> I have gathered the information required in this post.  I have provided 
> the common information for machines which work and fail.  I have 
> provided the syslog debug message for those that work and also those 
> that fail.

This all looks OK but the debug log doesn't have the debugging info.
Did you set syslog to send daemon.* to the log?

I'm not sure we'll get much more from it but we should at least have a
look at it.

Do you get any core files for automount?

> 
> lroom# rpm -q autofs
> autofs-5.0.1-31
> 
> lroom# uname -a
> Linux lroom 2.6.22.2-tftp #1 Sun Aug 12 11:14:47 EDT 2007 i686 i686 i386 
> GNU/Linux
> 
> 
> lroom# cat /etc/auto.master
> #
> # Sample auto.master file
> # This is an automounter map and it has the following format
> # key [ -mount-options-separated-by-comma ] location
> # For details of the format look at autofs(5).
> #
> #/misc  /etc/auto.misc
> #/net   -hosts
> /mnt/usb /etc/auto.usb --timeout=2
> #
> # Include central master map if it can be found using
> # nsswitch sources.
> #
> # Note that if there are entries for /net or /misc (as
> # above) in the included master map any keys that are the
> # same will not be seen as the first read key seen takes
> # precedence.
> #
> #+auto.master
> 
> lroom# cat /etc/auto.usb
> device_a         -fstype=vfat,rw,gid=100,umask=002       :/dev/sda1
> device_b         -fstype=vfat,rw,gid=100,umask=002       :/dev/sdb1
> 
> lroom# cat /etc/nsswitch.conf
> #
> # /etc/nsswitch.conf
> #
> # An example Name Service Switch config file. This file should be
> # sorted with the most-used services at the beginning.
> #
> # The entry '[NOTFOUND=return]' means that the search for an
> # entry should stop if the search in the previous entry turned
> # up nothing. Note that if the search failed due to some other reason
> # (like no NIS server responding) then the search continues with the
> # next entry.
> #
> # Legal entries are:
> #
> #       nisplus or nis+         Use NIS+ (NIS version 3)
> #       nis or yp               Use NIS (NIS version 2), also called YP
> #       dns                     Use DNS (Domain Name Service)
> #       files                   Use the local files
> #       db                      Use the local database (.db) files
> #       compat                  Use NIS on compat mode
> #       hesiod                  Use Hesiod for user lookups
> #       [NOTFOUND=return]       Stop searching if not found so far
> #
> 
> # To use db, put the "db" in front of "files" for entries you want to be
> # looked up first in the databases
> #
> # Example:
> #passwd:    db files nisplus nis
> #shadow:    db files nisplus nis
> #group:     db files nisplus nis
> 
> passwd:     files
> shadow:     files
> group:      files
> 
> #hosts:     db files nisplus nis dns
> hosts:      files dns
> 
> # Example - obey only what nisplus tells us...
> #services:   nisplus [NOTFOUND=return] files
> #networks:   nisplus [NOTFOUND=return] files
> #protocols:  nisplus [NOTFOUND=return] files
> #rpc:        nisplus [NOTFOUND=return] files
> #ethers:     nisplus [NOTFOUND=return] files
> #netmasks:   nisplus [NOTFOUND=return] files
> 
> bootparams: nisplus [NOTFOUND=return] files
> 
> ethers:     files
> netmasks:   files
> networks:   files
> protocols:  files
> rpc:        files
> services:   files
> 
> netgroup:   files
> 
> publickey:  nisplus
> 
> automount:  files
> aliases:    files nisplus
> 
> lroom# cat /etc/sysconfig/autofs
> #
> # Define default options for autofs.
> #
> # MASTER_MAP_NAME - default map name for the master map.
> #
> #MASTER_MAP_NAME="auto.master"
> #
> # TIMEOUT - set the default mount timeout (default 600).
> #
> TIMEOUT=300
> #
> # BROWSE_MODE - maps are browsable by default.
> #
> BROWSE_MODE="no"
> #
> # APPEND_OPTIONS - append to global options instead of replace.
> #
> #APPEND_OPTIONS="yes"
> #
> # LOGGING - set default log level "none", "verbose" or "debug"
> #
> LOGGING="debug"
> #
> # Define the default LDAP schema to use for lookups
> #
> # System default
> #
> #MAP_OBJECT_CLASS="nisMap"
> #ENTRY_OBJECT_CLASS="nisObject"
> #MAP_ATTRIBUTE="nisMapName"
> #ENTRY_ATTRIBUTE="cn"
> #VALUE_ATTRIBUTE="nisMapEntry"
> #
> # Other common LDAP nameing
> #
> #MAP_OBJECT_CLASS="automountMap"
> #ENTRY_OBJECT_CLASS="automount"
> #MAP_ATTRIBUTE="ou"
> #ENTRY_ATTRIBUTE="cn"
> #VALUE_ATTRIBUTE="automountInformation"
> #
> #MAP_OBJECT_CLASS="automountMap"
> #ENTRY_OBJECT_CLASS="automount"
> #MAP_ATTRIBUTE="automountMapName"
> #ENTRY_ATTRIBUTE="automountKey"
> #VALUE_ATTRIBUTE="automountInformation"
> #
> # AUTH_CONF_FILE - set the default location for the SASL
> #                          authentication configuration file.
> #
> #AUTH_CONF_FILE="/etc/autofs_ldap_auth.conf"
> #
> # General global options
> #
> #OPTIONS=""
> #
> 
> The "linux" machine is the NFS server which provides the root file 
> system for the "lroom" and "gym" machines.  The /tftpboot/muekow/i386 
> directory is the root file system for the diskless machines, which is a 
> static hard mount setup during the early boot process.
> 
> Here are the log files for the "lroom" machine which works properly.
> 
> Jan  1 11:43:37 lroom automount[1968]: Starting automounter version 
> 5.0.1-31, master map auto.master
> Jan  1 11:43:37 lroom automount[1968]: using kernel protocol version 5.00
> Jan  1 11:43:37 linux mountd[2130]: authenticated unmount request from 
> lroom:915 for /tftpboot/muekow/i386 (/tftpboot/muekow)
> Jan  1 11:44:12 linux mountd[2130]: authenticated unmount request from 
> lroom:637 for /tftpboot/muekow/i386 (/tftpboot/muekow)
> Jan  1 11:44:12 lroom automount[1968]: mounted indirect mount on 
> /mnt/usb with timeout 2, freq 1 seconds
> Jan  1 11:45:06 lroom automount[1968]: attempting to mount entry 
> /mnt/usb/DCIM
> Jan  1 11:45:06 lroom automount[1968]: failed to mount /mnt/usb/DCIM
> Jan  1 11:45:06 lroom automount[1968]: attempting to mount entry 
> /mnt/usb/dcim
> Jan  1 11:45:06 lroom automount[1968]: failed to mount /mnt/usb/dcim
> Jan  1 11:45:17 lroom xinetd[1820]: START: telnet pid=2280 
> from=192.168.1.254
> 
> Here are the log files for the "gym" machine which fails to start 
> automount properly.  The automount program is in the hung state at this 
> point.
> 
> Jan  1 11:49:36 gym automount[1846]: Starting automounter version 
> 5.0.1-31, master map auto.master
> Jan  1 11:49:36 gym automount[1846]: using kernel protocol version 5.00
> Jan  1 11:49:36 linux mountd[2130]: authenticated unmount request from 
> gym:778 for /tftpboot/muekow/i386 (/tftpboot/muekow)
> 
> 
> I realized today that the machines which fail to work are P3 processors 
> whereas the one that works is a P4 processor.  I don't know if that has 
> meaning or is a pure coincidence.
> 
> Thanks for the help.
> 
> Jim
> 
> 
> 
> 
> 
> Ian Kent wrote:
> > On Mon, 2007-12-31 at 17:03 -0500, Jim Duda wrote:
> >> I'm attempting to use autofs on some diskless machines which operate 
> >> using an NFS mounted root file system.  I have three different computers 
> >> which share the same root file system (with unique /tmp and /var 
> >> directories) and the same 2.6.22 kernel.
> >>
> >> I want to use autofs for removable USB memory sticks.
> >>
> >> On one machine, I can use autofs just fine.  Autofs mounts and unmounts 
> >> the usb sticks as I expect it to.  Works nice.
> >>
> >> However, on the other two machines, I cannot get automount to start.  It 
> >> simply hangs upon startup, I cannot ^C to exit or anything.  I have to 
> >> kill -9 the process.
> >>
> >> I cannot figure out what automount is looking for, and not getting, 
> >> which would cause it to hang.  I've attempted to use gdb to help me find 
> >> the problem, but I haven't had much luck.  (I've downloaded the most 
> >> recent 5.0.2 tar bar and build automount with -g to debug.
> > 
> > Did you apply any of the patches for 5.0.2?
> > 
> >> I'm hoping someone might shed some light on how best to debug this issue.
> > 
> > Have a look at http://people.redhat.com/jmoyer for what to collect and
> > post here.
> > 
> > Ian
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
