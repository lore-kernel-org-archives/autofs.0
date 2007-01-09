From: Ian Kent <raven@themaw.net>
Subject: Re: mtab corruption
Date: Wed, 10 Jan 2007 00:02:21 +0900
Message-ID: <1168354941.3641.25.camel@raven.themaw.net>
References: <459BD3C9.9090201@conterra.de>
	<1167874477.3546.10.camel@raven.themaw.net>
	<Pine.LNX.4.64.0701040855170.23215@simba.math.ucla.edu>
	<1167962084.4289.8.camel@raven.themaw.net>
	<n7xlkkc4682.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <n7xlkkc4682.fsf@sor.suse.de>
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
To: Matthias Koenig <mkoenig@suse.de>
Cc: autofs@linux.kernel.org

On Tue, 2007-01-09 at 15:36 +0100, Matthias Koenig wrote:
> >
> > Sure, but my point was that I'm not familiar with what patches the SuSE
> > maintainer may have added. Perhaps this would be a good time for the
> > SuSE maintainer to speak up, if present.
> 
> Yes, I know about this problem. However I have not had the time yet to do
> some further debugging.
> We have a patch addressing the mtab locking part of fstab.c however this
> seems not to be enough. According to a recent mail on the util-linux-ng list
> there is a principal problem with the method used in mount. This needs
> some more investigation. As soon this problem is fixed I think this is
> important enough to backport.

Thanks for the reply Matthias.

I'm also following the discussion on util-linux-ng.
We'll see how it develops.

Ian
