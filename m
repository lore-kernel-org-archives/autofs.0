From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: autofs4 past 2.6.38: how to make it work?
Date: Wed, 17 Aug 2011 10:27:22 +0400
Message-ID: <4E4B5F4A.5060705@msgid.tls.msk.ru>
References: <4E4975AB.4050201@msgid.tls.msk.ru>	
 <4E497B43.4010600@msgid.tls.msk.ru>
 <1313550460.4418.5.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1313550460.4418.5.camel@perseus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

17.08.2011 07:07, Ian Kent wrote:
> On Tue, 2011-08-16 at 00:02 +0400, Michael Tokarev wrote:
>> After searching a bit more, especially after realizing
>> it's not 2.6.37+ but 2.6.38+ (so I corrected $subject),
>> I found a few references to this, especially
>> https://bugzilla.redhat.com/show_bug.cgi?id=719607
>> and a few more (most of which are without answers).
>>
>> I tested the patch proposed in RH#719607 (attachtment
>> #512209) - it restores functionality of automounter,
>> at least as far as I can see.
>>
>> I think it should go to -stable, too... ;)
> 
> That path (actually a different equivalent patch) is included in 3.1-rc.

commit 5a30d8a2b8ddd5102c440c7e5a7c8e1fd729c818
VFS: Fix automount for negative autofs dentries

> There were major changes to the kernel automount code in the 2.6.38 and
> there have been a number of corrections along the way, with this patch
> being the last one for known problems.

I see.  Well, actually this very issue is more or less
cosmetic for me for now, since it was just testing of
stuff that revealed the problem - I tried to debug something
else and come across a "non-working" automount, but actually
my usage goes stright to a file deeper into the automounted
filesystem so that part actually always worked, but it just
seemed to be non-working when doing simple ls $topdir test.

> I recommend staying with 2.6.37 until 3.1 is available.

I wish 2.6.37 were supported still, and 2.6.35 or better
2.6.32 were bootable on this machine (it needs a more
recent brocade driver which works ok in 3.0, and also
lots of scalability work went into recent kernels).

So I have to use more recent kernel, and am facing this
autofs issue.  The good thing is that it's been found
already, and fixed for a future release.  Still,
backporting some at least recent fixes to recent
stable kernels may not be entirely bad, I think:
there aren't many changes in this area since 3.0
for example, and 3.0 is the current stable kernel
(2.6.39 received its last update).

In 3.0, only two relevant commits are missing as far
as I can see: this negative autofs dentries fix, and
LOOKUP_CONTINUE change.  The rest - again, ifaics -
are merely cosmetics.  I'm not sure about this
LOOKUP_CONTINUE change, how relevant it is, but
the two combined does not look bad for -stable.
I think... :)

I applied both to my 3.0 now, so it should fix
all known issues as you say ;)

Thank you!

/mjt
