From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: AFS + LDAP
Date: Fri, 07 Jul 2006 13:50:12 -0400
Message-ID: <x49hd1t1ezv.fsf@segfault.boston.redhat.com>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
	<1152189192.8761.24.camel@raven.themaw.net>
	<20060706194023.GG32706@mail.iSKUNK.ORG>
	<1152236488.2922.19.camel@raven.themaw.net>
	<20060707170919.GI32706@mail.iSKUNK.ORG>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060707170919.GI32706@mail.iSKUNK.ORG> (Daniel Richard G.'s
	message of "Fri, 7 Jul 2006 13:09:19 -0400")
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
To: "Daniel Richard G." <skunk@iskunk.org>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] AFS + LDAP; "Daniel Richard G." <skunk@iskunk.org> adds:

skunk> On Fri, 2006 Jul 07 09:41:28 +0800, Ian Kent wrote:
>> > be no lookup/parser disjunction. Should there be any issue with a backend 
>> > module that effectively does both tasks?
>> 
>> Not really, but maybe.
>> The entry point into this is the lookup module.
>> 
>> In version 4 and version 5 so far the lookup module for a map source is
>> called to find the mount data it then calls the parser module which in
>> turn calls the appropriate mount module.

skunk> I see. So the separation is not enforced; the daemon only knows about 
skunk> lookup modules, and the modules can delegate however they wish.

And as things stand today, every lookup module falls into the model of
calling into the parse module to do parsing (and the parse module calls the
mount module).  If you're going to stray from this, you had better have a
really good reason to do so.

>> You need to be careful not to implement something that is specific to
>> what you require rather than something that general and that others may
>> benefit from. Otherwise we would end up with a bunch of limited function
>> modules.

skunk> The point is not lost on me. I'd like to find a "tighter" solution
skunk> that can nevertheless be generally applicable.

Good.

Jeff
