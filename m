From: raven@themaw.net
Subject: Re: [PATCH] check nsswitch.conf for submounts
Date: Tue, 1 Mar 2005 21:17:57 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0503012116150.14747@donald.themaw.net>
References: <421D05BF.5000206@redhat.com>
	<Pine.LNX.4.61.0502271124090.8184@donald.themaw.net>
	<16931.9806.115239.891035@segfault.boston.redhat.com>
Mime-Version: 1.0
In-Reply-To: <16931.9806.115239.891035@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Chris Feist <cfeist@redhat.com>

On Mon, 28 Feb 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] [PATCH] check nsswitch.conf for submounts; raven@themaw.net adds:
>
> raven> On Wed, 23 Feb 2005, Chris Feist wrote: Thanks Chris.
>
> raven> This is a really useful bit of code.  Appart from addressing the
> raven> default map problem, it is one of the pieces of code needed to move
> raven> logic out of the init script.
>
> raven> Howerver, we can't assume that maps are stored in "/etc".  This
> raven> really should be a configure logical.
>
> And why not?  Is this not precisely what the Sun automounter does?

Yes but not all distributions store their maps in /etc.
I don't want to make it hard for myself and others that may need this in 
time to come.

Gentoo stores maps in /etc/autofs for example.

>
> -Jeff
>
>>> This patch addresses the problem if a user has the following in one of
>>> their automount maps: # auto.misc test -fstype=autofs auto.m2
>>>
>>> Before it would automatically assume that auto.m2 was a yp/nis map.  The
>>> patch now checks if the file exists in /etc/ (and if it's a file or
>>> program map) or if it exists in yp (according to the order in
>>> nsswitch.conf).
>>>
>>> In the future we may want to include functionality in the lookup_xxx.so
>>> modules so we can more easily detect if a certain map exists.
>>>
>>> Thanks, Chris
>>>
>>>
>
> raven> _______________________________________________ autofs mailing list
> raven> autofs@linux.kernel.org
> raven> http://linux.kernel.org/mailman/listinfo/autofs
>
