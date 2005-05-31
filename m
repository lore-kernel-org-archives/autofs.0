From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Failure to mount without ever trying to mount..
Date: Tue, 31 May 2005 23:53:32 +0200
Message-ID: <20050531215332.GA31971@uio.no>
References: <200505312142.j4VLg3OT016150@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <200505312142.j4VLg3OT016150@cornholio.qualcomm.com>
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

On Tue, May 31, 2005 at 02:42:02PM -0700, Michael Marion wrote:
> Wonder if this is known.. don't see the same thing in the list, but I'm way
> behind.
> 
> Most hosts failing to mount a test server, but watching packets shows that it
> never does try to mount.  I've verified that patching 4.1.4 with:
> autofs-4.1.4-multi-parse-fix.patch
> autofs-4.1.4-non-replicated-ping.patch
> autofs-4.1.4-misc-fixes.patch
> 
> fixes the problem, and I'm guessing it's the non-replicated-ping patch that
> does it as the ok hosts do a lot more rpc traffic. 

If patching autofs works, why not simply do that?

> We're trying to figure out if just enabling nfs v2 support, or something else
> simple will help in the short term.. I'd rather not update the kernel and
> automount daemon on 800+ hosts for one path. :)  Though I want to get them all
> updated eventually where I can.

You don't have to update the kernel for the fixes, just the daemon. If you
have 800+ machines, surely you must have some kind of automated system for
doing that.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
