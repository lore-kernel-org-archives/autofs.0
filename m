From: Ian Kent <raven@themaw.net>
Subject: RE: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 4 May 2006 20:29:00 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605042019420.3559@raven.themaw.net>
References: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D0@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D0@HOUEXC210.mgroupnet.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rigler, Stephen C." <srigler@marathonoil.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 4 May 2006, Rigler, Stephen C. wrote:

> I have it installed on one FC5 machine running the vanilla 2.6.16.12
> kernel
> patched with the autofs4-2.6.16-v5 patch.
> 
> Operationally everything seems good so far.  I like how the direct
> mounts
> are ghosted (which is consistent behavior with the other unixes we run).
> 
> The only issue I had was with parsing of auto.master.  We get our
> auto.master
> from NIS and automount didn't seem to want to parse it even when
> specifying
> "+auto.master" in /etc/auto.master.  I ended up ypcat'ing auto.master

What do you have in the nsswitch.conf automount: entry?

You probably already know this but ...

The default master map is /etc/auto.master but that can be changed by 
setting DEFAULT_MASTER_MAP_NAME in the config or giving it on the command 
line for automount.

Setting

DEFAULT_MASTER_MAP_NAME=auto.master

and

automount: nis

should do the trick.

However if you had

automount: files nis

and /etc/auto.master exists with a +auto.master it will probably get it 
wrong in a strange way. Maybe that's what is happening?

It would be good if we could check this out a bit further and find out 
what's going wrong. I'm sure there's something I need to fix.

> into
> the local file and it now handles all of our maps.
> 
> -Steve
> 
> 
> > -----Original Message-----
> > From: autofs-bounces@linux.kernel.org 
> > [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Ian Kent
> > Sent: Tuesday, May 02, 2006 10:35 AM
> > To: autofs mailing list
> > Cc: linux-fsdevel
> > Subject: [autofs] [ANNOUNCE] autofs 5.0.0 beta1
> > 
> > 
> > Hi all,
> > 
> > I've finally got to a point where I can release a beta of
> > autofs 5.0.0.
> > 
> > I would really appreciate some real world testing of this
> > so I hope some of you are able to help.
> > 
> > Feedback is welcome.
> > 
> > autofs
> > ======
> > 
> > For the moment the package can be found at:
> > 
> > ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4
> > 
> > It is autofs-5.0.0_beta1.tar.[gz|bz2]
> > 
> > No source rpm is there as it can be produced by using:
> > 
> > rpmbuild -ts autofs-5.0.0_beta1.tar.gz
> > 
> > and the binary rpm by using:
> > 
> > rpmbuild -tb autofs-5.0.0_beta1.tar.gz
> > 
> > See the INSTALL file for information about configure options and
> > kernel requirements.
> > 
> > I have no way to test the Gentoo portage build and the build
> > files will need to be modified for beta1. It would be great
> > if someone could get this working and forward a patch before
> > the final release.
> > 
> > Here is the README.v5.release which outlines the changes:
> > 
> > autofs-5.0.0 beta1 release notes
> > ================================
> > 
> > Differences between version 4 and version 5.
> > 
> > - Master map is now read and parsed by the `automount' daemon
> >   - the parameters for the `automount' daemon are now very different.
> >     See automount(8).
> > 
> > - The `automount' daemon is now a multi-threaded application and so
> >   appears as a single process (unless a thread process display option
> >   is used).
> > 
> > - `autofs' filesystem mounts only appear in /proc/mounts and not
> >   /etc/mtab. If you have a large number of entries in a direct mount
> >   map and link /etc/mtab to /proc/mounts you may see performance
> >   degradation.
> > 
> > - `autofs' version 5.0.0 will refuse to run if it cannot find an
> >    autofs4 kernel module that supports protocol version 5.00 or above.
> > 
> > New in 5.0.0 is:
> > 
> > - improved direct mount map support
> >   - single level map entries now work as expected.
> >   - top level directory of direct mount heirachy no longer obscurses
> >     directory tree below.
> > 
> > - `+' map inclusion
> >   - maps preceded by a `+' in file maps may now be included inline.
> >   - implemented for the master map and mount maps.
> > 
> > - added nsswitch map source support
> >   - is now used to locate maps if no map source is given in their
> >     specification.
> >   - is used for bothe master map and mount maps.
> > 
> > - rewrote multi-mount map code
> >   - multi-mount map entry offsets now mount and expire indpendently
> >     instead of having to mount and umount all offset entries at once.
> > 
> > - added LDAP encryption and authentication support
> >   - needs to be enabled using a configure option.
> >   - a configuration file specifies whether encryption and 
> > authentication
> >     is to be used (see INSTALL and auto.master(5) for more 
> > information).
> > 
> > - improved shutdown and restart
> >   - needs to be enabled using a configure option.
> >   - see INSTALL for more information.
> > 
> > - a "hosts" map module has been added
> >   - an entry like "/net -hosts" is now understood and uses the new
> >     multi-mount semantics for lazy mount/umount of exports 
> > from the host.
> >   - the implementation is quite simple minded at this stage 
> > and will need
> >     refinment. It just iterates through the host table and 
> > addes any host
> >     names it finds to the internal map.
> > 
> > Things not yet done
> > ===================
> > 
> > - I have no way to test the Gentoo setup here anymore so it is unlikey
> >   to work. Patches from anyone who needs this are welcome.
> > 
> > - the underscore to dot translation has not been added yet.
> > 
> > - there's a problen with the calcuation of the best host in replicated
> >   server selection.
> > 
> > - all the things I've broken and not re-tested after further 
> > development!
> > 
> > 
> > Ian
> > 
> > 
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
> > 
> > 
> > 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
