From: Krishnakumar B <kitty@dre.vanderbilt.edu>
Subject: Re: Help with automounting from a LDAP server
Date: Tue, 11 Jan 2005 01:21:51 -0600
Message-ID: <87pt0czb00.fsf@tango.dre.vanderbilt.edu>
References: <87llb1oi7g.fsf@tango.dre.vanderbilt.edu>
	<Pine.LNX.4.58.0501101645100.5722@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501101645100.5722@wombat.indigo.net.au> (Ian
	Kent's message of "Mon, 10 Jan 2005 16:47:53 +0800 (WST)")
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi,

Thanks for all the followups.

On Tuesday, 11 January 2005, Ian Kent  wrote:
> On Mon, 10 Jan 2005, Krishnakumar B wrote:
>

[...]

>> Will autofs on nfs.example.com recognize the local mount /export/home and
>> use a loopback mount for /home?  If so, do people recommend using the same
>> approach (using a direct mount) for /var/spool/mail on nfs.example.com?  If
>> not, why not?
>
> Can't do that at present.  Direct mounts are not fully implemented.

My manpage for autofs(5) claims the following:

UNSUPPORTED
       This version of the automounter supports direct maps for FILE, NIS
       and LDAP maps only and handles SunOS-style replicated filesystems
       only to the extent that mount(8) does.

So is my manpage wrong, or does "direct maps" mean something other than
"direct mounts"?  Or are you referring to the following limitation (from
README.direct v1.3).

NOTE: Due to current design limitations, direct maps will take over an
entire directory hierarchy.  What this means is, if your direct map key is
/usr/share/bilbo, then /usr will become an automount mount point, mounting
over the existing /usr.


I am using the following version of autofs with Linux-2.4.28.

tango % dpkg -S /usr/share/man/man5/autofs.5.gz
autofs: /usr/share/man/man5/autofs.5.gz
tango %
 
tango % dpkg -p autofs
Package: autofs
Priority: extra
Section: utils
Installed-Size: 428
Maintainer: Steinar H. Gunderson <sesse@debian.org>
Architecture: i386
Version: 4.1.3-8
DDepends: libc6 (>= 2.3.2.ds1-4)
Recommends: nfs-common
ConCflicts: samba (<< 2.0.6-1)
Filename: pool/main/a/autofs/autofs_4.1.3-8_i386.deb
Size: 96350
MD5sum: 42aef00313ebe91c572bcdeb04708914
Description: A kernel-based automounter for Linux
 Autofs controls the operation of the automount daemons. The automount
 daemons automatically mount filesystems when they are used and unmount
 them after a period of inactivity. This is done based on a set of
 pre-configured maps.
 .
 The kernel automounter implements an almost complete SunOS style
 automounter under Linux. Automounter version 4 (autofs4) has to be enabled
 when compiling the kernel. Debian packaged kernels have it enabled.

-kitty.
             
-- 
Krishnakumar B <kitty at dre dot vanderbilt dot edu>
Institute for Software Integrated Systems, Dept. of EECS, Vanderbilt University
