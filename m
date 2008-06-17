From: Ian Kent <raven@themaw.net>
Subject: Re: Suggested minor patches for the automounter daemon...
Date: Tue, 17 Jun 2008 10:39:00 +0800
Message-ID: <1213670340.18072.60.camel@raven.themaw.net>
References: <A2ECBF49F352C24F9DF65BB529DCBC7014E02CF0@hqemmail01.nvidia.com>
	<1213668900.18072.55.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213668900.18072.55.camel@raven.themaw.net>
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
To: Stephen Biggs <sbiggs@nvidia.com>
Cc: autofs@linux.kernel.org


On Tue, 2008-06-17 at 10:15 +0800, Ian Kent wrote:
> > --- autofs-5.0.3-git-ian_kent_patches-vanilla/samples/rc.autofs.in
> > 2008-05-19 17:02:17.071234000 -0700 
> > +++ autofs-5.0.3-git-ian_kent_patches/samples/rc.autofs.in
> > 2008-05-19 18:15:39.881408000 -0700 
> > @@ -56,7 +56,7 @@ 
> >                 fi 
> >         fi
> > 
> > -       $prog $OPTIONS 
> > +       $DAEMON $OPTIONS 
> >         RETVAL=$? 
> >         if [ $RETVAL -eq 0 ] ; then 
> >                 echo "done." 
> > @@ -75,7 +75,7 @@ 
> >                 [ $RETVAL = 0 -a -z "`pidof $DAEMON`" ] || sleep 3 
> >                 count=`expr $count + 1` 
> >         done 
> > -       if [ -n "`pidof $DAEMON`" ] ; then 
> > +       if [ -z "`pidof $DAEMON`" ] ; then 
> >                 echo "done." 
> >         else 
> >                 echo "failed."
> > 
> 
> Both these have come up before.
> In fact I think I changed the if test, so now do we change it back?
> I'm not sure why I didn't change the daemon path before but maybe there
> was a reason for it. I'll need to think about that.

Ahhh, but this last hunk was fixed in redhat/autofs.init.in and not in
samples/rc.autofs.in. To keep these consistent I'll change the messages
instead of the if.

Ian
