From: Ian Kent <raven@themaw.net>
Subject: Re: Failure to mount without ever trying to mount..
Date: Wed, 1 Jun 2005 12:45:50 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0506011244190.10849@wombat.indigo.net.au>
References: <200505312142.j4VLg3OT016150@cornholio.qualcomm.com>
	<20050531215332.GA31971@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050531215332.GA31971@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 31 May 2005, Steinar H. Gunderson wrote:

> On Tue, May 31, 2005 at 02:42:02PM -0700, Michael Marion wrote:
> > Wonder if this is known.. don't see the same thing in the list, but I'm way
> > behind.
> > 
> > Most hosts failing to mount a test server, but watching packets shows that it
> > never does try to mount.  I've verified that patching 4.1.4 with:
> > autofs-4.1.4-multi-parse-fix.patch
> > autofs-4.1.4-non-replicated-ping.patch
> > autofs-4.1.4-misc-fixes.patch
> > 
> > fixes the problem, and I'm guessing it's the non-replicated-ping patch that
> > does it as the ok hosts do a lot more rpc traffic. 
> 
> If patching autofs works, why not simply do that?
> 
> > We're trying to figure out if just enabling nfs v2 support, or something else
> > simple will help in the short term.. I'd rather not update the kernel and
> > automount daemon on 800+ hosts for one path. :)  Though I want to get them all
> > updated eventually where I can.
> 
> You don't have to update the kernel for the fixes, just the daemon. If you
> have 800+ machines, surely you must have some kind of automated system for
> doing that.

Yep. Assuming I'm right. Resolving this specific issue won't need a kernel 
update.

Ian
