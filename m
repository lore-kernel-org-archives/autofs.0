From: Ian Kent <raven@themaw.net>
Subject: Re: automount dies almost immediately after upgrade
	to	autofs 5.0.1
Date: Wed, 07 Mar 2007 10:09:24 +0900
Message-ID: <1173229765.3371.9.camel@raven.themaw.net>
References: <796EF5B39103EE45A04CC2FFFCF130B98D6E23@ala-mail08.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <796EF5B39103EE45A04CC2FFFCF130B98D6E23@ala-mail08.corp.ad.wrs.com>
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
To: "Krejsa, Dan" <dan.krejsa@windriver.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-03-06 at 10:29 -0800, Krejsa, Dan wrote:
> Hi Ian & Folks,
> 
> I've included the debug log and other information asked for
> below, and attached as separate files in an archive.
> 
> To collect the /var/log/debug output, I restarted autofs
> as root, and in another shell as an ordinary user, did

Thanks.

> 
>   cd /net
>   cd blue
> 
> The 'cd blue' call hanged, and the automount died (
> according to /etc/init.d/autofs status) after
> fetching the export list for blue. (I provide the output
> of 'showmount -e blue' below.)  After a bit I was able
> to interrupt the 'cd blue' call, getting back a 'No such
> file or directory' message.  I then restarted autofs
> again (/etc/init.d/autofs restart), and again tried
> 'cd blue' with the same results.
> 
> In the /var/log/debug output I see
> 
> Mar  6 09:23:52 localhost automount[3579]: lookup_read_master:
> lookup(yp): read of master map auto.master failed: Can't bind to server
> which serves this domain
> Mar  6 09:23:52 localhost automount[3579]: lookup_read_master:
> lookup(file): failed to read included master map auto.master

Map includes are only allowed in file maps, this is the return from the
attempted include of "+auto.master".

> 
> I'm not too surprised about the yp lookup failure, but I'm
> not sure what to make of the lookup(file) failure, or even
> whether this is to be worried about for /net mounts.
> 
> Thanks for any suggestions,
> 
> - Dan
> 
> [root@clifford etc]# uname -a
> Linux clifford 2.6.19-1.2911.6.4.fc6 #1 SMP Sat Feb 24 14:39:04 EST 2007
> i686 i686 i386 GNU/Linux
> [root@clifford etc]# rpm -q autofs
> autofs-5.0.1-0.rc3.23
> [root@clifford etc]# lf -l auto.*
> -rw-r--r-- 1 root root  560 Feb 19 20:39 auto.master
> -rw-r--r-- 1 root root  581 Feb 19 20:39 auto.misc
> -rwxr-xr-x 1 root root 1292 Feb 19 20:39 auto.net*
> -rwxr-xr-x 1 root root  715 Feb 19 20:39 auto.smb*
> [root@clifford etc]# cat auto.master
> #
> # $Id: auto.master,v 1.4 2005/01/04 14:36:54 raven Exp $
> #
> # Sample auto.master file
> # This is an automounter map and it has the following format
> # key [ -mount-options-separated-by-comma ] location
> # For details of the format look at autofs(5).
> #
> /misc   /etc/auto.misc
> /net    -hosts
> #
> # Include central master map if it can be found using
> # nsswitch sources.
> #
> # Note that if there are entries for /net or /misc (as
> # above) in the included master map any keys that are the
> # same will not be seen as the first read key seen takes
> # precedence.
> #
> +auto.master
> [root@clifford etc]# cat auto.net

The auto.net script isn't used for the "-hosts" map.

snip ...

> [root@clifford etc]# showmount -e blue
> Export list for blue:
> /vol/vol0/fsfcvs                  (everyone)
> /vol/vol0/sww                     (everyone)
> /vol/vol5/prj-prlc-work-products  (everyone)
> /vol/vol7/prj-2007-fall-release   (everyone)
> /vol/vol0/tina                    (everyone)
> /vol/vol0/software                (everyone)
> /vol/vol0/rti_tools               (everyone)
> /vol/vol7/prj-2007-hut-dev        (everyone)
> /vol/vol1/dave-test               ala-doradb2
> /vol/vol0/sales_video             (everyone)
> /vol/vol0/jumpstart               (everyone)
> /vol/vol5/ilt                     (everyone)
> /vol/vol3/prj-2006-fall-release   (everyone)
> /vol/vol2/prj-2006-spring-release (everyone)
> /vol/vol0/jumpstart/redhat/BSD    (everyone)
> /vol/vol0/vmware-test             (everyone)
> /vol/vol5/tux                     (everyone)
> /vol/vol0/ultravox                (everyone)
> /vol/vol0/ecms                    web-ecms,cadacan,morpheus,wisdom
> /vol/vol0/docs                    (everyone)
> /vol/vol0                         morpheus
> /vol/vol1                         morpheus
> /vol/vol2                         morpheus
> /vol/vol3                         morpheus
> /vol/vol4                         morpheus,ala-toradb2,ala-doradb2
> /vol/vol5                         morpheus
> /vol/vol6                         (everyone)
> /vol/vol7                         (everyone)
> /vol/vol8                         (everyone)
> /vol/vol7/prj-2007-hut-release    (everyone)
> /vol/vol0/web                     (everyone)
> /vol/vol1/it_laptop_backup        (everyone)
> /vol/vol6/prj-2007-spring-release (everyone)
> /vol/vol7/prj-2007-fall-dev       (everyone)
> /vol/vol0/ithome                  (everyone)

Looks fine.

> [root@clifford etc]#
> [root@clifford etc]# cd /var/log
> [root@clifford log]# cat debug
> Mar  6 09:19:31 localhost automount[3453]: Starting automounter version
> 5.0.1-0.rc3.23, master map auto.master

There is a correction to the exports lookup code in 0.rc3.25 which you
should find in the testing directory on the mirrors. I've just requested
it be moved from testing to final so it should be available as an update
soon.

snip ...

> Mar  6 09:23:53 localhost automount[3579]: mounted indirect mount on
> /net with timeout 300, freq 75 seconds
> Mar  6 09:24:01 localhost automount[3579]: handle_packet: type = 3
> Mar  6 09:24:01 localhost automount[3579]:
> handle_packet_missing_indirect: token 3, name blue, request pid 3500
> Mar  6 09:24:01 localhost automount[3579]: attempting to mount entry
> /net/blue
> Mar  6 09:24:01 localhost automount[3579]: lookup_mount: lookup(hosts):
> fetchng export list for blue

Strange you don't get a SEGV and a core.
Do you see any core file in the root directory?

Ian
