From: "Rigler, Stephen C." <srigler@marathonoil.com>
Subject: RE: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 4 May 2006 06:16:10 -0500
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D0@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@linux.kernel.org>

I have it installed on one FC5 machine running the vanilla 2.6.16.12
kernel
patched with the autofs4-2.6.16-v5 patch.

Operationally everything seems good so far.  I like how the direct
mounts
are ghosted (which is consistent behavior with the other unixes we run).

The only issue I had was with parsing of auto.master.  We get our
auto.master
from NIS and automount didn't seem to want to parse it even when
specifying
"+auto.master" in /etc/auto.master.  I ended up ypcat'ing auto.master
into
the local file and it now handles all of our maps.

-Steve


> -----Original Message-----
> From: autofs-bounces@linux.kernel.org 
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Ian Kent
> Sent: Tuesday, May 02, 2006 10:35 AM
> To: autofs mailing list
> Cc: linux-fsdevel
> Subject: [autofs] [ANNOUNCE] autofs 5.0.0 beta1
> 
> 
> Hi all,
> 
> I've finally got to a point where I can release a beta of
> autofs 5.0.0.
> 
> I would really appreciate some real world testing of this
> so I hope some of you are able to help.
> 
> Feedback is welcome.
> 
> autofs
> ======
> 
> For the moment the package can be found at:
> 
> ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4
> 
> It is autofs-5.0.0_beta1.tar.[gz|bz2]
> 
> No source rpm is there as it can be produced by using:
> 
> rpmbuild -ts autofs-5.0.0_beta1.tar.gz
> 
> and the binary rpm by using:
> 
> rpmbuild -tb autofs-5.0.0_beta1.tar.gz
> 
> See the INSTALL file for information about configure options and
> kernel requirements.
> 
> I have no way to test the Gentoo portage build and the build
> files will need to be modified for beta1. It would be great
> if someone could get this working and forward a patch before
> the final release.
> 
> Here is the README.v5.release which outlines the changes:
> 
> autofs-5.0.0 beta1 release notes
> ================================
> 
> Differences between version 4 and version 5.
> 
> - Master map is now read and parsed by the `automount' daemon
>   - the parameters for the `automount' daemon are now very different.
>     See automount(8).
> 
> - The `automount' daemon is now a multi-threaded application and so
>   appears as a single process (unless a thread process display option
>   is used).
> 
> - `autofs' filesystem mounts only appear in /proc/mounts and not
>   /etc/mtab. If you have a large number of entries in a direct mount
>   map and link /etc/mtab to /proc/mounts you may see performance
>   degradation.
> 
> - `autofs' version 5.0.0 will refuse to run if it cannot find an
>    autofs4 kernel module that supports protocol version 5.00 or above.
> 
> New in 5.0.0 is:
> 
> - improved direct mount map support
>   - single level map entries now work as expected.
>   - top level directory of direct mount heirachy no longer obscurses
>     directory tree below.
> 
> - `+' map inclusion
>   - maps preceded by a `+' in file maps may now be included inline.
>   - implemented for the master map and mount maps.
> 
> - added nsswitch map source support
>   - is now used to locate maps if no map source is given in their
>     specification.
>   - is used for bothe master map and mount maps.
> 
> - rewrote multi-mount map code
>   - multi-mount map entry offsets now mount and expire indpendently
>     instead of having to mount and umount all offset entries at once.
> 
> - added LDAP encryption and authentication support
>   - needs to be enabled using a configure option.
>   - a configuration file specifies whether encryption and 
> authentication
>     is to be used (see INSTALL and auto.master(5) for more 
> information).
> 
> - improved shutdown and restart
>   - needs to be enabled using a configure option.
>   - see INSTALL for more information.
> 
> - a "hosts" map module has been added
>   - an entry like "/net -hosts" is now understood and uses the new
>     multi-mount semantics for lazy mount/umount of exports 
> from the host.
>   - the implementation is quite simple minded at this stage 
> and will need
>     refinment. It just iterates through the host table and 
> addes any host
>     names it finds to the internal map.
> 
> Things not yet done
> ===================
> 
> - I have no way to test the Gentoo setup here anymore so it is unlikey
>   to work. Patches from anyone who needs this are welcome.
> 
> - the underscore to dot translation has not been added yet.
> 
> - there's a problen with the calcuation of the best host in replicated
>   server selection.
> 
> - all the things I've broken and not re-tested after further 
> development!
> 
> 
> Ian
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
> 
> 
