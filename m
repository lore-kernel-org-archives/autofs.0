From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta2
Date: Sat, 27 May 2006 13:26:54 -0400
Message-ID: <x498xonz8dd.fsf@segfault.boston.redhat.com>
References: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
	<446251C5.5070407@inria.fr> <x49y7x12vml.fsf@redhat.com>
	<x49lksoz974.fsf@segfault.boston.redhat.com>
	<1148717601.2587.39.camel@raven.themaw.net>
	<1148721904.10961.2.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1148721904.10961.2.camel@raven.themaw.net> (Ian Kent's message
	of "Sat, 27 May 2006 17:25:04 +0800")
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
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [ANNOUNCE] autofs 5.0.0 beta2; Ian Kent <raven@themaw.net> adds:

raven> On Sat, 2006-05-27 at 16:13 +0800, Ian Kent wrote:
>> On Fri, 2006-05-26 at 18:56 -0400, Jeff Moyer wrote: > Guillaume.Rousse>
>> Third, the following patches still apply, but I got no >
>> Guillaume.Rousse> clue about their usefulness: -
>> > 
>> > Guillaume.Rousse> autofs-4.1.0-hesiod-bind.patch
>> > 
>> > jmoyer> I'll do some digging on this one tomorrow.
>> > 
>> > OK, it took me a while longer than expected to get to this.  Sorry!
>> > 
>> > The hesiod resolve patch is wanted.  Actually, I think in v5 we can
>> just > get rid of the old calls to hes_resolve.
>> > 
>> > If you look at the implementation that currently is there in
>> lookup_hesiod.c, > it has some bugs.  It will free a pointer that the
>> library will > subsequently try to free, and it also leaks memory.  This
>> is, in part, due to > the horrible definition of the interface at the
>> time, I believe.
>> > 
>> > At any rate, we should move to hesiod_init, hesiod_resolve, etc.  It's
>> > probably best to check that the hesiod library supports the new
>> interfaces > at configure time.  If not, just disable the building of
>> the hesiod > modules.
>> > 
>> > Ian, let me know what you think of the attached patch.
>> > 
>> 
>> I've checked this out and ended up with this, the configure part is due
>> to the change in configure.in:
>> 

raven> Oops and this.

Yeah, with the added unlock this looks good.

Thanks,

Jeff
