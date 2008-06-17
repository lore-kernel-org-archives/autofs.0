From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Re: Suggested minor patches for the automounter daemon...
Date: Tue, 17 Jun 2008 10:12:06 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC7014E02CFC@hqemmail01.nvidia.com>
References: <A2ECBF49F352C24F9DF65BB529DCBC7014E02CF0@hqemmail01.nvidia.com>
	<1213668900.18072.55.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213668900.18072.55.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] =

> Sent: Monday, June 16, 2008 7:15 PM
> To: Stephen Biggs
> Cc: autofs@linux.kernel.org
> Subject: Re: Suggested minor patches for the automounter daemon...
> =

> =

> On Mon, 2008-06-16 at 12:56 -0700, Stephen Biggs wrote:
> >  Hi...
> > =

> >  As part of my compilation and execution efforts, I have =

> accumulated a =

> > small set of minor fixes to some of the automounter daemon files.
> > Presented for your approval. These apply to the git HEAD and the =

> > previous set of patches that Ian had provided to me.  The =

> biggest fix =

> > is the one for redhat'ish systems in rc.autofs.in that fixes the =

> > daemon "stop" function.
> > =

> >  I am CC'ing this directly to Ian just in case there is a =

> problem with =

> > posting to the autofs list.  Sorry for any noise.
> > =

> > ----
> > =

> >  daemon/automount.c: Remove compile warning of unused variable
> >  Makefile: Remove "modification time in the future" =

> messages generated =

> > by parallelism in some versions of make
> >  modules/Makefile: Avoid creating soft link to non-existent =

> library if =

> > LDAP not specified in configure
> >  samples/rc.autofs.in: Specify full path for invocation of daemon, =

> > making pkill function more exact,
> >                        Reverse sense of test of return of pidof to =

> > correctly kill daemon on stop function.
> > =

> > ---
> > =

> > =

> >  Makefile             |    2 ++ =

> >  daemon/automount.c   |    1 - =

> >  modules/Makefile     |    2 ++ =

> >  samples/rc.autofs.in |    4 ++-- =

> >  4 files changed, 6 insertions(+), 3 deletions(-)
> > =

> > =

> > diff -urd =

> autofs-5.0.3-git-ian_kent_patches-vanilla/daemon/automount.c
> > autofs-5.0.3-git-ian_kent_patches/daemon/automount.c
> > =

> > --- autofs-5.0.3-git-ian_kent_patches-vanilla/daemon/automount.c
> > 2008-05-19 17:02:17.083219000 -0700
> > +++ autofs-5.0.3-git-ian_kent_patches/daemon/automount.c
> > 2008-05-19 13:55:10.608330000 -0700
> > @@ -1554,7 +1554,6 @@
> > =

> >         while (ap->state !=3D ST_SHUTDOWN) { =

> >                 if (handle_packet(ap)) { =

> > -                       struct ioctl_ops *ops =3D get_ioctl_ops(); =

> >                         int ret, cur_state;
> > =

> >                         /*
> =

> Yes, already spotted this, it's already done.

Cool... =


> =

> > diff -urd autofs-5.0.3-git-ian_kent_patches-vanilla/Makefile
> > autofs-5.0.3-git-ian_kent_patches/Makefile
> > --- autofs-5.0.3-git-ian_kent_patches-vanilla/Makefile  2008-05-19 =

> > 11:59:15.333785000 -0700
> > +++ autofs-5.0.3-git-ian_kent_patches/Makefile  2008-05-19
> > 18:28:33.916067000 -0700
> > @@ -39,6 +39,8 @@ =

> >         sed -e "s/(\.autofs-[0-9.]\+)/(.autofs-`cat .version`)/" < =

> > configure.in > configure.in.tmp
> >         mv -f configure.in.tmp configure.in =

> >         rm -f configure
> > +# get rid of "modification time in the future" messages =

> > +       @sleep 1
> >         $(MAKE) configure
> =

> How does this help if you're clock is more than one second out?

It doesn't.  We're talking in the 1/100 second range... For some reason, th=
e rm -f configure doesn't seem to finish before the $(MAKE) starts, so it i=
s not a question of clock syncronization, rather a parallelism issue in mak=
e itself especially when there might be a lag across a slow NFS file path.

This fix makes it work for us.

> Why is the time on you're NFS machines not synchronized?

See above.  It looks like a 'make' issure rather than a clock issue, in tha=
t make starts the sub-make either before the rm -f is finished, or that the=
 local NFS client gets notified of the removal.  But, in any case, if you o=
bject to this one, we'll keep it for our own internal use.  It "works for u=
s".

> =

> > =

> >  TODAY  :=3D $(shell date +'%Y%m%d') =

> > diff -urd autofs-5.0.3-git-ian_kent_patches-vanilla/modules/Makefile
> > autofs-5.0.3-git-ian_kent_patches/modules/Makefile =

> > --- autofs-5.0.3-git-ian_kent_patches-vanilla/modules/Makefile
> > 2008-05-19 11:59:15.528977000 -0700 =

> > +++ autofs-5.0.3-git-ian_kent_patches/modules/Makefile  2008-05-19
> > 13:52:40.466366000 -0700 =

> > @@ -63,7 +63,9 @@ =

> >         -rm -f $(INSTALLROOT)$(autofslibdir)/mount_smbfs.so =

> =

> Why?
> Why not add a test for existence instead of just removing it?

?? This was already in the source and is not part of my patch. ??

> =

> >         ln -fs lookup_file.so
> > $(INSTALLROOT)$(autofslibdir)/lookup_files.so =

> >         ln -fs lookup_yp.so
> > $(INSTALLROOT)$(autofslibdir)/lookup_nis.so =

> > +ifeq ($(LDAP), 1) =

> >         ln -fs lookup_ldap.so
> > $(INSTALLROOT)$(autofslibdir)/lookup_ldaps.so =

> > +endif =

> =

> Yeah, maybe?

A bit pedantic, but it goes along with a cleanup.

> =

> >         ln -fs mount_nfs.so
> > $(INSTALLROOT)$(autofslibdir)/mount_nfs4.so =

> >  ifeq ($(EXT2FS), 1) =

> >   ifeq ($(EXT3FS), 1) =

> > diff -urd
> > autofs-5.0.3-git-ian_kent_patches-vanilla/samples/rc.autofs.in
> > autofs-5.0.3-git-ian_kent_patches/samples/rc.autofs.in
> > =

> > --- autofs-5.0.3-git-ian_kent_patches-vanilla/samples/rc.autofs.in
> > 2008-05-19 17:02:17.071234000 -0700 =

> > +++ autofs-5.0.3-git-ian_kent_patches/samples/rc.autofs.in
> > 2008-05-19 18:15:39.881408000 -0700 =

> > @@ -56,7 +56,7 @@ =

> >                 fi =

> >         fi
> > =

> > -       $prog $OPTIONS =

> > +       $DAEMON $OPTIONS =

> >         RETVAL=3D$? =

> >         if [ $RETVAL -eq 0 ] ; then =

> >                 echo "done." =

> > @@ -75,7 +75,7 @@ =

> >                 [ $RETVAL =3D 0 -a -z "`pidof $DAEMON`" ] || sleep 3 =

> >                 count=3D`expr $count + 1` =

> >         done =

> > -       if [ -n "`pidof $DAEMON`" ] ; then =

> > +       if [ -z "`pidof $DAEMON`" ] ; then =

> >                 echo "done." =

> >         else =

> >                 echo "failed."
> > =

> =

> Both these have come up before.
> In fact I think I changed the if test, so now do we change it back?

I don't understand.
Here is the relevant text from 'man bash':

       -z string
              True if the length of string is zero.
       -n string
       string True if the length of string is non-zero.

What you are saying is that the correct action here is to do 'echo "done"' =
IF the length of the string returned from 'pidof' is **non-zero**?? That me=
ans that 'pidof' returned a string containing at least one pid which means =
that the daemon is still running and that stopping the daemon failed, right?


> I'm not sure why I didn't change the daemon path before but =

> maybe there
> was a reason for it. I'll need to think about that.

Here is the relevant text for 'man pidof':
       When  pidof  is  invoked  with a full pathname to the program it sho=
uld
       find the pid of, it is reasonably safe. Otherwise it is  possible  t=
hat
       it  returns  pids of running programs that happen to have the same n=
ame
       as the program you=E2re after but are actually other programs.

> =

> Perhaps someone else can remember.
> =

> ______________________________________________________________
---------------------------------------------------------------------------=
--------
This email message is for the sole use of the intended recipient(s) and may=
 contain
confidential information.  Any unauthorized review, use, disclosure or dist=
ribution
is prohibited.  If you are not the intended recipient, please contact the s=
ender by
reply email and destroy all copies of the original message.
---------------------------------------------------------------------------=
--------
