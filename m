From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 variable substitution
Date: Tue, 11 May 2010 10:12:19 +0800
Message-ID: <1273543939.2287.1.camel@localhost>
References: <4BE4E1C3.8050708@cs.umn.edu>
	<1273377392.3851.70.camel@localhost> <4BE83CA3.70206@cs.umn.edu>
	<4BE8448E.20403@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=N/3d3wiYU0Q5j8fjj6rF8z+f09E=;
	b=lKWPkZr5JuHNeoPz8PYtaKM2uaEazV7gJ6kVc6bZHeLe6B3MGndsgyuqiV9BO1x1Auz6TGK1DOYUm+pI+HgsQLk0dY7XDkDIpQR7cIHN+5MuF4jqAuPMFKXnEiCVilehw5pTOuGrCMugp6DfSGc5TLh0+MnblMI6ZmD7pB4wueU=
In-Reply-To: <4BE8448E.20403@cs.umn.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Peter Bajurny <bajurny@cs.umn.edu>
Cc: autofs@linux.kernel.org

On Mon, 2010-05-10 at 12:38 -0500, Peter Bajurny wrote:
> Peter Bajurny wrote:
> > Ian Kent wrote:
> >   
> >> On Fri, 2010-05-07 at 23:00 -0500, Peter Bajurny wrote:
> >>   
> >>     
> >>> I apologize if this is the wrong place for this, but my Googling has 
> >>> come up empty and I find myself at a loss.
> >>>
> >>> In our enviroment we do automounts based on the OSNAME and OSREL 
> >>> variables.  With autofs4 and the sun automounter we manually specify the 
> >>> values of OSNAME and OSREL in the init scripts.  In the autofs4 init.d 
> >>> script there is a line for 'localoptions' where I can set '-DOSNAME=name 
> >>> -DOSREL=rel'.  But I can't for the life of me figure out how to set this 
> >>> with an autofs5 init script.  The init script specifies a confdir and 
> >>> the autofs file there.  I tried adding 'OPTIONS="-DOSNAME=name 
> >>> -DOSREL=rel"' to that line, and the automountd process started with 
> >>> those correct flags, but then it wasn't able to mount anything from my 
> >>> automount maps.  I also tried using LOCALOPTIONS instead of OPTIONS and 
> >>> that didn't do anything.
> >>>     
> >>>       
> >> Yes, the OPTIONS configuration entry probably needs a bit of explanation
> >> in the comments.
> >>
> >> See automount(8) or automount5(8), as the case may be, for the -O
> >> option.
> >>
> >> Use OPTIONS="-O -DOSNAME=name -DOSREL=rel".
> >>
> >> Not sure about if you will need separate quotes around the options
> >> themselves but give it a try.
> >>
> >>   
> >>     
> > Allright.  I've tried that, both with and without quotes around the
> > options.  In both cases the automount process ran with those options
> > according to ps, and 'normal' mounts worked, but I still couldn't access
> > our $OSNAME$OSREL mounts.  On my client, the default values of those
> > variables would lead to a mount of Linux2.6.28-18-generic.  I created
> > that mountpoint and tried to mount that, and not even that works.  I'm
> > wondering if I'm being hit with this bug filed on Ubuntu:
> > https://bugs.launchpad.net/ubuntu/+source/autofs5/+bug/488229/
> > Although that but only affects user variables and not machine variables,
> > so I could be wrong.
> >
> > If setting enviroment variables doesn't work, I can get around that by
> > using a combination of $OSNAME and $ARCH, but I'm worried that the
> > client isn't even using the default values properly.
> >
> > Thanks,
> > Peter Bajurny
> >
> >   
> Well now this is embarrassing.  It turns out all along that I had a
> stale process that meant everytime I thought I was restarting autofs and
> getting a new mount I was... not.  This is how we did the OPTIONS:
> OPTIONS="-DOSNAME=ubuntuamd -DOSREL=1"

Of course, oops, my mistake, -D is in fact an automount option so that
is the way it should be done.

Ian
