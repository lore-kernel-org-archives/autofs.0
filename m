From: "Peter C. Norton" <spacey-autofs@lenin.net>
Subject: Re: lookup_nisplus module
Date: Sun, 11 Sep 2005 20:19:33 -0700
Message-ID: <20050912031933.GS3434@lenin.net>
References: <11593.136.182.2.222.1126298006.squirrel@thepisanis.com>
	<Pine.LNX.4.63.0509101101330.2073@donald.themaw.net>
	<46288.24.223.199.54.1126322315.squirrel@thepisanis.com>
	<Pine.LNX.4.63.0509101134220.2073@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509101134220.2073@donald.themaw.net>
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

On Sat, Sep 10, 2005 at 11:36:55AM +0800, Ian Kent wrote:
> On Fri, 9 Sep 2005, Ryan Pisani wrote:
> 
> > Thanks Ian. Hopefully it can be used down the road. If you ever do need a
> > tester, I'm always available, and I have access to multiple nisplus
> > domains that differ from the primary one. I know nisplus is not a hot item
> > in the world of linux and autofs. Thanks again.
> 
> Thanks Ryan. It's in my contrib directory.
> 
> What we really need is someone that wants to do a little nisplus 
> development. But who has the time?

Ian,

In general nis+ development isn't actually needed. NIS+ isn't going
anywhere and will probably be de-supported in the coming years. In the
near future, however, when x86_64 platforms with virtualization
becoming cheap and solaris x86 not being the red-headed stepchild at
sun anymore, it becomes feasible to have a NIS+ infrastructure without
needing a pile of sun boxes along with a linux client. The
infrastructure becomes the requirement for a workstation cpu and a few
dozen gigs of space on an ide drive.

Look for more action on this area next year when none of us have to
stay in the office to fix NIS+ bugs (or, more accurately, none of us
have to foobar our department NIS+ maps to test fixes).

-Peter

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.
