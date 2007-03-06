From: "Krejsa, Dan" <dan.krejsa@windriver.com>
Subject: Re: automount dies almost immediately after upgrade to
	autofs 5.0.1
Date: Tue, 6 Mar 2007 10:29:36 -0800
Message-ID: <796EF5B39103EE45A04CC2FFFCF130B98D6E23@ala-mail08.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7601D.64D5B5FC"
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
Cc: "Krejsa, Dan" <dan.krejsa@windriver.com>, raven@themaw.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7601D.64D5B5FC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ian & Folks,

I've included the debug log and other information asked for
below, and attached as separate files in an archive.

To collect the /var/log/debug output, I restarted autofs
as root, and in another shell as an ordinary user, did

  cd /net
  cd blue

The 'cd blue' call hanged, and the automount died (
according to /etc/init.d/autofs status) after
fetching the export list for blue. (I provide the output
of 'showmount -e blue' below.)  After a bit I was able
to interrupt the 'cd blue' call, getting back a 'No such
file or directory' message.  I then restarted autofs
again (/etc/init.d/autofs restart), and again tried
'cd blue' with the same results.

In the /var/log/debug output I see

Mar  6 09:23:52 localhost automount[3579]: lookup_read_master:
lookup(yp): read of master map auto.master failed: Can't bind to server
which serves this domain
Mar  6 09:23:52 localhost automount[3579]: lookup_read_master:
lookup(file): failed to read included master map auto.master

I'm not too surprised about the yp lookup failure, but I'm
not sure what to make of the lookup(file) failure, or even
whether this is to be worried about for /net mounts.

Thanks for any suggestions,

- Dan

[root@clifford etc]# uname -a
Linux clifford 2.6.19-1.2911.6.4.fc6 #1 SMP Sat Feb 24 14:39:04 EST 2007
i686 i686 i386 GNU/Linux
[root@clifford etc]# rpm -q autofs
autofs-5.0.1-0.rc3.23
[root@clifford etc]# lf -l auto.*
-rw-r--r-- 1 root root  560 Feb 19 20:39 auto.master
-rw-r--r-- 1 root root  581 Feb 19 20:39 auto.misc
-rwxr-xr-x 1 root root 1292 Feb 19 20:39 auto.net*
-rwxr-xr-x 1 root root  715 Feb 19 20:39 auto.smb*
[root@clifford etc]# cat auto.master
#
# $Id: auto.master,v 1.4 2005/01/04 14:36:54 raven Exp $
#
# Sample auto.master file
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# For details of the format look at autofs(5).
#
/misc   /etc/auto.misc
/net    -hosts
#
# Include central master map if it can be found using
# nsswitch sources.
#
# Note that if there are entries for /net or /misc (as
# above) in the included master map any keys that are the
# same will not be seen as the first read key seen takes
# precedence.
#
+auto.master
[root@clifford etc]# cat auto.net
#!/bin/bash

# $Id: auto.net,v 1.8 2005/04/05 13:02:09 raven Exp $

# This file must be executable to work! chmod 755!

# Look at what a host is exporting to determine what we can mount.
# This is very simple, but it appears to work surprisingly well

key=3D"$1"

# add "nosymlink" here if you want to suppress symlinking local
filesystems
# add "nonstrict" to make it OK for some filesystems to not mount
opts=3D"-fstype=3Dnfs,hard,intr,nodev,nosuid"

# Showmount comes in a number of names and varieties.  "showmount" is
# typically an older version which accepts the '--no-headers' flag
# but ignores it.  "kshowmount" is the newer version installed with
knfsd,
# which both accepts and acts on the '--no-headers' flag.
#SHOWMOUNT=3D"kshowmount --no-headers -e $key"
#SHOWMOUNT=3D"showmount -e $key | tail -n +2"

for P in /bin /sbin /usr/bin /usr/sbin
do
        for M in showmount kshowmount
        do
                if [ -x $P/$M ]
                then
                        SMNT=3D$P/$M
                        break
                fi
        done
done

[ -x $SMNT ] || exit 1

# Newer distributions get this right
SHOWMOUNT=3D"$SMNT --no-headers -e $key"

$SHOWMOUNT | LC_ALL=3DC sort -k 1 | \
        awk -v key=3D"$key" -v opts=3D"$opts" -- '
        BEGIN   { ORS=3D""; first=3D1 }
                { if (first) { print opts; first=3D0 }; print " \\\n\t"
$1, key ":" $1 }
        END     { if (!first) print "\n"; else exit 1 }
        ' | sed 's/#/\\#/g'
[root@clifford etc]# cat auto.misc
#
# $Id: auto.misc,v 1.2 2003/09/29 08:22:35 raven Exp $
#
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# Details may be found in the autofs(5) manpage

cd              -fstype=3Diso9660,ro,nosuid,nodev :/dev/cdrom

# the following entries are samples to pique your imagination
#linux          -ro,soft,intr           ftp.example.org:/pub/linux
#boot           -fstype=3Dext2            :/dev/hda1
#floppy         -fstype=3Dauto            :/dev/fd0
#floppy         -fstype=3Dext2            :/dev/fd0
#e2floppy       -fstype=3Dext2            :/dev/fd0
#jaz            -fstype=3Dext2            :/dev/sdc1
#removable      -fstype=3Dext2            :/dev/hdd
[root@clifford etc]# cat auto.smb
#!/bin/bash

# $Id: auto.smb,v 1.3 2005/04/05 13:02:09 raven Exp $

# This file must be executable to work! chmod 755!

key=3D"$1"
opts=3D"-fstype=3Dcifs"

for P in /bin /sbin /usr/bin /usr/sbin
do
        if [ -x $P/smbclient ]
        then
                SMBCLIENT=3D$P/smbclient
                break
        fi
done

[ -x $SMBCLIENT ] || exit 1

$SMBCLIENT -gNL $key 2>/dev/null| awk -v key=3D"$key" -v opts=3D"$opts"
-F'|' -- '
        BEGIN   { ORS=3D""; first=3D1 }
        /Disk/  {
                  if (first)
                        print opts; first=3D0
                  dir =3D $2
                  loc =3D $2
                  # Enclose mount dir and location in quotes
                  # Double quote "$" in location as it is special
                  gsub(/\$$/, "\\$", loc);
                  print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""
                }
        END     { if (!first) print "\n"; else exit 1 }
        '
[root@clifford etc]#
[root@clifford etc]# showmount -e blue
Export list for blue:
/vol/vol0/fsfcvs                  (everyone)
/vol/vol0/sww                     (everyone)
/vol/vol5/prj-prlc-work-products  (everyone)
/vol/vol7/prj-2007-fall-release   (everyone)
/vol/vol0/tina                    (everyone)
/vol/vol0/software                (everyone)
/vol/vol0/rti_tools               (everyone)
/vol/vol7/prj-2007-hut-dev        (everyone)
/vol/vol1/dave-test               ala-doradb2
/vol/vol0/sales_video             (everyone)
/vol/vol0/jumpstart               (everyone)
/vol/vol5/ilt                     (everyone)
/vol/vol3/prj-2006-fall-release   (everyone)
/vol/vol2/prj-2006-spring-release (everyone)
/vol/vol0/jumpstart/redhat/BSD    (everyone)
/vol/vol0/vmware-test             (everyone)
/vol/vol5/tux                     (everyone)
/vol/vol0/ultravox                (everyone)
/vol/vol0/ecms                    web-ecms,cadacan,morpheus,wisdom
/vol/vol0/docs                    (everyone)
/vol/vol0                         morpheus
/vol/vol1                         morpheus
/vol/vol2                         morpheus
/vol/vol3                         morpheus
/vol/vol4                         morpheus,ala-toradb2,ala-doradb2
/vol/vol5                         morpheus
/vol/vol6                         (everyone)
/vol/vol7                         (everyone)
/vol/vol8                         (everyone)
/vol/vol7/prj-2007-hut-release    (everyone)
/vol/vol0/web                     (everyone)
/vol/vol1/it_laptop_backup        (everyone)
/vol/vol6/prj-2007-spring-release (everyone)
/vol/vol7/prj-2007-fall-dev       (everyone)
/vol/vol0/ithome                  (everyone)
[root@clifford etc]#
[root@clifford etc]# cd /var/log
[root@clifford log]# cat debug
Mar  6 09:19:31 localhost automount[3453]: Starting automounter version
5.0.1-0.rc3.23, master map auto.master
Mar  6 09:19:31 localhost automount[3453]: using kernel protocol version
5.00
Mar  6 09:19:31 localhost automount[3453]: lookup_nss_read_master:
reading master files auto.master
Mar  6 09:19:31 localhost automount[3453]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:19:31 localhost automount[3453]: mount_init: mount(bind):
bind_works =3D 1
Mar  6 09:19:31 localhost automount[3453]: lookup_read_master:
lookup(file): read entry /misc
Mar  6 09:19:31 localhost automount[3453]: lookup_read_master:
lookup(file): read entry /net
Mar  6 09:19:31 localhost automount[3453]: lookup_read_master:
lookup(file): read entry +auto.master
Mar  6 09:19:31 localhost automount[3453]: lookup_nss_read_master:
reading master files auto.master
Mar  6 09:19:31 localhost automount[3453]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:19:31 localhost automount[3453]: lookup_nss_read_master:
reading master nis auto.master
Mar  6 09:19:31 localhost automount[3453]: lookup_init: lookup(yp):
ctxt->mapname=3Dauto.master
Mar  6 09:19:31 localhost automount[3453]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:19:31 localhost automount[3453]: lookup_read_master:
lookup(yp): read of master map auto.master failed: Can't bind to server
which serves this domain
Mar  6 09:19:31 localhost automount[3453]: lookup_read_master:
lookup(file): failed to read included master map auto.master
Mar  6 09:19:31 localhost automount[3453]: master_do_mount: mounting
/misc
Mar  6 09:19:31 localhost automount[3453]: lookup_nss_read_map: reading
map file /etc/auto.misc
Mar  6 09:19:31 localhost automount[3453]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:19:31 localhost automount[3453]: mount_init: mount(bind):
bind_works =3D 1
Mar  6 09:19:31 localhost automount[3453]: mounted indirect mount on
/misc with timeout 300, freq 75 seconds
Mar  6 09:19:31 localhost automount[3453]: master_do_mount: mounting
/net
Mar  6 09:19:31 localhost automount[3453]: lookup_nss_read_map: reading
map hosts (null)
Mar  6 09:19:31 localhost automount[3453]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:19:31 localhost automount[3453]: mounted indirect mount on
/net with timeout 300, freq 75 seconds
Mar  6 09:21:44 localhost automount[3453]: st_expire: state 1 path /misc
Mar  6 09:21:44 localhost automount[3453]: expire_proc: exp_proc =3D
3084581776 path /misc
Mar  6 09:21:44 localhost automount[3453]: expire_cleanup: got thid
3084581776 path /misc stat 0
Mar  6 09:21:44 localhost automount[3453]: expire_cleanup: sigchld: exp
3084581776 finished, switching from 2 to 1
Mar  6 09:21:44 localhost automount[3453]: st_ready: st_ready(): state =
=3D
2 path /misc
Mar  6 09:21:47 localhost automount[3453]: st_expire: state 1 path /net
Mar  6 09:21:47 localhost automount[3453]: expire_proc: exp_proc =3D
3084581776 path /net
Mar  6 09:21:47 localhost automount[3453]: mount still busy /net
Mar  6 09:21:47 localhost automount[3453]: expire_cleanup: got thid
3084581776 path /net stat 0
Mar  6 09:21:47 localhost automount[3453]: expire_cleanup: sigchld: exp
3084581776 finished, switching from 2 to 1
Mar  6 09:21:47 localhost automount[3453]: st_ready: st_ready(): state =
=3D
2 path /net
Mar  6 09:21:54 localhost automount[3453]: handle_packet: type =3D 3
Mar  6 09:21:54 localhost automount[3453]:
handle_packet_missing_indirect: token 1, name blue, request pid 3500
Mar  6 09:21:54 localhost automount[3453]: attempting to mount entry
/net/blue
Mar  6 09:21:54 localhost automount[3453]: lookup_mount: lookup(hosts):
fetchng export list for blue
Mar  6 09:23:52 localhost automount[3579]: Starting automounter version
5.0.1-0.rc3.23, master map auto.master
Mar  6 09:23:52 localhost automount[3579]: using kernel protocol version
5.00
Mar  6 09:23:52 localhost automount[3579]: lookup_nss_read_master:
reading master files auto.master
Mar  6 09:23:52 localhost automount[3579]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:23:52 localhost automount[3579]: mount_init: mount(bind):
bind_works =3D 1
Mar  6 09:23:52 localhost automount[3579]: lookup_read_master:
lookup(file): read entry /misc
Mar  6 09:23:52 localhost automount[3579]: lookup_read_master:
lookup(file): read entry /net
Mar  6 09:23:52 localhost automount[3579]: lookup_read_master:
lookup(file): read entry +auto.master
Mar  6 09:23:52 localhost automount[3579]: lookup_nss_read_master:
reading master files auto.master
Mar  6 09:23:52 localhost automount[3579]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:23:52 localhost automount[3579]: lookup_nss_read_master:
reading master nis auto.master
Mar  6 09:23:52 localhost automount[3579]: lookup_init: lookup(yp):
ctxt->mapname=3Dauto.master
Mar  6 09:23:52 localhost automount[3579]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:23:52 localhost automount[3579]: lookup_read_master:
lookup(yp): read of master map auto.master failed: Can't bind to server
which serves this domain
Mar  6 09:23:52 localhost automount[3579]: lookup_read_master:
lookup(file): failed to read included master map auto.master
Mar  6 09:23:52 localhost automount[3579]: master_do_mount: mounting
/misc
Mar  6 09:23:52 localhost automount[3579]: lookup_nss_read_map: reading
map file /etc/auto.misc
Mar  6 09:23:52 localhost automount[3579]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:23:52 localhost automount[3579]: mount_init: mount(bind):
bind_works =3D 1
Mar  6 09:23:53 localhost automount[3579]: mounted indirect mount on
/misc with timeout 300, freq 75 seconds
Mar  6 09:23:53 localhost automount[3579]: master_do_mount: mounting
/net
Mar  6 09:23:53 localhost automount[3579]: lookup_nss_read_map: reading
map hosts (null)
Mar  6 09:23:53 localhost automount[3579]: parse_init: parse(sun): init
gathered global options: (null)
Mar  6 09:23:53 localhost automount[3579]: mounted indirect mount on
/net with timeout 300, freq 75 seconds
Mar  6 09:24:01 localhost automount[3579]: handle_packet: type =3D 3
Mar  6 09:24:01 localhost automount[3579]:
handle_packet_missing_indirect: token 3, name blue, request pid 3500
Mar  6 09:24:01 localhost automount[3579]: attempting to mount entry
/net/blue
Mar  6 09:24:01 localhost automount[3579]: lookup_mount: lookup(hosts):
fetchng export list for blue
[root@clifford log]#=20




On Tue, 2007-03-06 at 17:22 +0900, Ian Kent wrote:
> On Mon, 2007-03-05 at 21:36 -0800, Dan Krejsa wrote:
> > Hi,
> >=20
> > Yesterday I updated autofs, the kernel, selinux-policy, and=20
> > a few other things on my Fedora Core 6 laptop.  Today I brought
> > my laptop in to work, and autofs failed for /net mounts.
> >=20
> > Here's the relevant section of yum.log:
> >=20
> > Mar 04 13:12:39 Installed: kernel-xen.i686 2.6.19-1.2911.6.4.fc6
> > Mar 04 13:12:51 Installed: kernel.i686 2.6.19-1.2911.6.4.fc6
> > Mar 04 13:12:51 Installed: ieee80211-kmdl-2.6.19-1.2911.6.4.fc6.i686
1.2.16-17.fc6.at
> > Mar 04 13:12:52 Installed:
ieee80211-kmdl-2.6.19-1.2911.6.4.fc6xen.i686 1.2.16-17.fc6.at
> > Mar 04 13:12:58 Updated: vim-common.i386 2:7.0.201-1.fc6
> > Mar 04 13:13:01 Updated: selinux-policy.noarch 2.4.6-41.fc6
> > Mar 04 13:13:03 Updated: kernel-headers.i386 2.6.19-1.2911.6.4.fc6
> > Mar 04 13:13:04 Updated: readahead.i386 1:1.3-7.fc6
> > Mar 04 13:13:04 Installed:
ipw3945-kmdl-2.6.19-1.2911.6.4.fc6xen.i686 1.2.0-18.2.fc6.at
> > Mar 04 13:13:06 Updated: autofs.i386 1:5.0.1-0.rc3.23
> > Mar 04 13:13:07 Updated: vim-enhanced.i386 2:7.0.201-1.fc6
> > Mar 04 13:13:14 Updated: selinux-policy-targeted.noarch 2.4.6-41.fc6
> > Mar 04 13:13:15 Installed:
nvidia-graphics9629-kmdl-2.6.19-1.2911.6.4.fc6.i686 1:1.0_9629-81.fc6.at
> > Mar 04 13:13:15 Updated: vim-minimal.i386 2:7.0.201-1.fc6
> > Mar 04 13:13:16 Installed:
nvidia-graphics9629-kmdl-2.6.19-1.2911.6.4.fc6xen.i686
1:1.0_9629-81.fc6.at
> > Mar 04 13:13:17 Installed: ipw3945-kmdl-2.6.19-1.2911.6.4.fc6.i686
1.2.0-18.2.fc6.at
> >=20
> > I tried restarting autofs using '/etc/init.d/autofs start'
> > and it would claim success "[OK]", but in a few seconds (probably
> > less than a minute) the automount process would
> > disappear and '/etc/init.d/autofs status' would report
> > autofs stopped. DNS & general network connectivity were working.
>=20
> Is there anything at all in the logs?
> You can get a debug log by following the instructions at
> http://people.redhat.com/jmoyer
>=20
> Ian
>=20
>=20

------_=_NextPart_001_01C7601D.64D5B5FC
Content-Type: application/x-compressed;
	name="autofs.tgz"
Content-Transfer-Encoding: base64
Content-Description: autofs.tgz
Content-Disposition: attachment;
	filename="autofs.tgz"

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
n+/xbwIe22N7bI/tsT22hdv/AdWVXmkAUAAA

------_=_NextPart_001_01C7601D.64D5B5FC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

------_=_NextPart_001_01C7601D.64D5B5FC--

