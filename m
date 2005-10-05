From: "Peter C. Norton" <spacey-autofs@lenin.net>
Subject: Re: direct vs indirect maps??
Date: Tue, 4 Oct 2005 19:51:18 -0700
Message-ID: <20051005025118.GE5852@lenin.net>
References: <43431528.5060506@eecs.wsu.edu> <20051005014351.GA32035@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051005014351.GA32035@uio.no>
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

On Wed, Oct 05, 2005 at 03:43:51AM +0200, Steinar H. Gunderson wrote:
> On Tue, Oct 04, 2005 at 04:50:00PM -0700, Jim Kusznir wrote:
> > I've found references to "direct" and "indirect" maps throughout the 
> > various autofs documentation.  However, I have not yet found an 
> > understandable definition of what the difference is.  Could someone 
> > enlighten me?
> 
> Direct maps are relative to /, indirect maps are relative to some other path.
> 
> (At least that's my understanding of it.)
> 

A practical way to think about it is that direct maps are things that
you may otherwise put into /etc/fstab except that you may want them
centrally controlled.

It's the way to fake a common federated namespace - like AFS - which
lets you create the same mountpoints on all systems even if the fstab
format is different and even if the server changes once in a while.

Except it doesn't actually work on linux yet, but the team here seems
to be really trying to get this one done.

-Peter

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.
