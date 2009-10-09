From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch] fs: dcache remove d_mounted
Date: Fri, 9 Oct 2009 10:33:35 +0200
Message-ID: <20091009083335.GB17818@wotan.suse.de>
References: <20091009025621.GB4287@wotan.suse.de> <4ACECE68.70009@themaw.net>
	<20091009074211.GD2983@wotan.suse.de> <4ACEED94.6040002@themaw.net>
	<20091009080709.GA17818@wotan.suse.de>
	<4ACEF0FA.1060605@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ACEF0FA.1060605@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

On Fri, Oct 09, 2009 at 04:14:50PM +0800, Ian Kent wrote:
> Nick Piggin wrote:
> > Yeah I will redo it against mainline and send it out again. I will
> > get around to doing a git tree of the vfs scalability stuff after
> > I get the series in a bit more reasonable shape... I'll need you to
> > look at that too because autofs4 does a lot of meddling with
> > dcache_lock ;)
> 
> Hehe, sorry.
> 
> np, just point me at it and I'll do what I can.

I will do so, I just want to get a chance to clean it up and
document it all a bit better before I ask filesystem maintainres
to take a really good look.


> I'm open to advice on where and why I don't need to use the dcache_lock.
> I think there are case where I unnecessarily take it, especially in the
> changes that I have just posted to support the Sage Weil change to the
> taking of the directory i_mutex over revalidate in real_lookup(). Which
> are present in the mm kernel atm, if the latest one has been posted yet
> that is.

Well, after my patches there is no dcache_lock, so we need to
be sure that we _don't_ need dcache_lock :)

Basically what I have done for autofs4 is that I've tried to
preserve the same guarantees (from the dcache) that it looks
like you need, when replacing each instance of dcache_lock.

I have then replaced each dcache_lock with a new global
autofs4_lock, because there is so much state in there and
so many places where you take dcache_lock that I can't tell
what autofs internals are being protected with it.

I.... have it "working", but the reality is that there will be
bugs especially in my initial conversions of something hard like
autofs4. So just informed reviewing and questions/comments are
going to be important.

Thanks,
Nick
