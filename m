From: Brian Long <brilong@cisco.com>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Wed, 30 Nov 2005 15:53:36 -0500
Message-ID: <1133384016.4403.25.camel@brilong-lnx>
References: <1132670358.4039.37.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222329100.9982@donald.themaw.net>
	<17283.17854.189791.135878@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0511242311570.2314@donald.themaw.net>
	<17292.42845.186329.808676@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0511300907190.32520@wombat.indigo.net.au>
	<17294.3164.781525.150155@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17294.3164.781525.150155@segfault.boston.redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Wed, 2005-11-30 at 15:32 -0500, Jeff Moyer wrote:
> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Tue, 29 Nov 2005, Jeff Moyer wrote:
> >> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds;
> >> Ian Kent <raven@themaw.net> adds:
> >> 
> raven> On Tue, 22 Nov 2005, Jeff Moyer wrote:
> >> >> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15
> >> seconds; Ian Kent <raven@themaw.net> adds:
> >> >> 
> >> 
> raven> Could you review this patch please Jeff.
> >> After reviewing this further, I did find a problem.  See below.
> 
> raven> All good points and the test is wrong.  I'll update the patch and
> raven> post another.
> 
> raven> That just leaves the re-read for the other cases which may be
> raven> causing a long delay. I'm not sure this slows the lookup unless
> raven> sending the signal is causing starvation of cpu cycles some
> raven> how. Perhaps the change from cache_add to cache_update will help
> raven> more than I think.
> 
> Ian,
> 
> The patch I'm attaching is the one against the RHEL autofs package.  This
> is what I have come up with, and it is WRONG.  =)  It causes a regression
> in the case where there are multiple keys of the same name in a map;  the
> patched automounter will always use the last key instead of the first.
> Remember dealing with this back in February?  Fun.
> 
> I'll keep poking at it, I just wanted to make you aware of the problem.

Does this affect the autofs-4.1.3-166 RPMs I'm testing?  :)

/Brian/

-- 
       Brian Long                      |         |           |
       IT Data Center Systems          |       .|||.       .|||.
       Cisco Linux Developer           |   ..:|||||||:...:|||||||:..
       Phone: (919) 392-7363           |   C i s c o   S y s t e m s
