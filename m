From: Ian Kent <raven@themaw.net>
Subject: Re: autofs init script doesn't support exclude
Date: Wed, 22 Sep 2004 15:37:43 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409221533390.25785@wombat.indigo.net.au>
References: <20040920224949.GL23879@merlins.org>
	<20040921203920.GA9988@turing>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040921203920.GA9988@turing>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arthur Korn <arthur@korn.ch>
Cc: autofs@linux.kernel.org

On Tue, 21 Sep 2004, Arthur Korn wrote:

> Hi
> 
> Marc MERLIN schrieb:
> > >From https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=91559
> 
> > --- autofs.FCS  2003-01-27 20:22:54.000000000 -0800
> > +++ autofs      2003-05-23 18:38:27.000000000 -0700
> > @@ -34,6 +34,11 @@
> >  initdir=/etc/init.d
> >  
> >  #
> > +# Read configuration options
> > +#
> > +[ -f /etc/sysconfig/autofs ] && . /etc/sysconfig/autofs
> 
> This would be /etc/default/autofs for Debian then ...

Yes, the fact that this can be different for different distributions means 
that it's not as straight forward as one would hope.

This is only one of the cases that needs to be catered. I'll take this on 
advisement but would prefer that these type of patches be carried in the 
distribution packages till we can deal with them in a sensible manner.

Ian
