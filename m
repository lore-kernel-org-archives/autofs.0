From: "Peter C. Norton" <spacey-autofs@lenin.net>
Subject: Re: determining which process triggered an automount
Date: Thu, 12 Apr 2007 07:13:07 -0700
Message-ID: <20070412141307.GV5812@lenin.net>
References: <20070411234847.GH21698@pixar.com>
	<1176372304.3441.63.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1176372304.3441.63.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Thu, Apr 12, 2007 at 06:05:04PM +0800, Ian Kent wrote:
> On Wed, 2007-04-11 at 16:48 -0700, Chris Walker wrote:
> > I'd like to determine which process triggered an automount. Might I have
> > to use Systemtap or some other tool to determine this?
> 
> Can't really do that with autofs version 4.
> It's a bit of information that the daemon doesn't get in the request
> packet from the kernel. This information is passed to the daemon in
> autofs version 5 and is logged when debug logging is enabled so you
> could try that.
> 
> Sorry I can't be more help.
> Ian

I think a system tap module could get you this, but it will take some
time investment for you to find out how to use it.

http://sourceware.org/systemtap/

-Peter

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.
