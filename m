From: Ian Kent <raven@themaw.net>
Subject: Re: autofs init script doesn't support exclude
Date: Thu, 23 Sep 2004 11:31:11 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409231120110.17889@wombat.indigo.net.au>
References: <20040920224949.GL23879@merlins.org>
	<20040921203920.GA9988@turing>
	<Pine.LNX.4.58.0409221533390.25785@wombat.indigo.net.au>
	<16721.32274.474781.773811@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16721.32274.474781.773811@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 22 Sep 2004, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] autofs init script doesn't support exclude; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Tue, 21 Sep 2004, Arthur Korn wrote:
> >> Hi
> >> 
> >> Marc MERLIN schrieb: > >From
> >> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=91559
> >> 
> >> > --- autofs.FCS 2003-01-27 20:22:54.000000000 -0800 > +++ autofs
> >> 2003-05-23 18:38:27.000000000 -0700 > @@ -34,6 +34,11 @@ >
> >> initdir=/etc/init.d
> >> >  
> >> >  #
> >> > +# Read configuration options > +# > +[ -f /etc/sysconfig/autofs ] &&
> >> . /etc/sysconfig/autofs
> >> 
> >> This would be /etc/default/autofs for Debian then ...
> 
> raven> Yes, the fact that this can be different for different distributions
> raven> means that it's not as straight forward as one would hope.
> 
> raven> This is only one of the cases that needs to be catered. I'll take
> raven> this on advisement but would prefer that these type of patches be
> raven> carried in the distribution packages till we can deal with them in a
> raven> sensible manner.
> 
> I'm not sure how to interpret this.  What do you forsee as "a sensible
> manner?"  Do you think the mechanism is correct?  Is there a way to achieve
> this with the Sun automounter?

I think this will need thought wrt what distros use which directories.
Perhaps some work on configure to make it happen right and at least a deal 
of work on the init script.

My question is "can we try to do this in a reasonably distribution 
independent manner". Having each distro carry its own patches is one way 
to identify the needs.

The reason I piped up here is that I have a crazy idea that it would be 
good to be able to use autofs in a range of distributions. Not just RedHat 
and Debian as it is now in the init script. But I'm not sure how I can do 
that yet.

A seperate configuration, such as is used in Linux, is not available with 
the Solaris automounter.

Ian
