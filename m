From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: Map overrides
Date: Thu, 13 Jul 2006 03:43:13 -0400
Message-ID: <20060713074313.GH29064@mail.iSKUNK.ORG>
References: <20060712013858.GA29064@mail.iSKUNK.ORG>
	<1152674321.2930.28.camel@raven.themaw.net>
	<20060712041816.GC29064@mail.iSKUNK.ORG>
	<1152705813.2930.34.camel@raven.themaw.net>
	<20060713021103.GG29064@mail.iSKUNK.ORG>
	<1152765179.2929.11.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1152765179.2929.11.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

On Thu, 2006 Jul 13 12:32:59 +0800, Ian Kent wrote:
> 
> And having a quick look at the code suggests that it could be made to
> function the way you require with some minor changes.

So this is all in lookup_multi.c, eh? Interesting.

This looks like it should do the trick... but since I'm not yet up on all 
the subtleties, what sort of changes do you anticipate this needing?


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
