From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] mount_nfs replicated mounts patch (now sorts
	by subnet locality too)
Date: Tue, 19 Jul 2005 20:34:49 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0507192032490.2061@donald.themaw.net>
References: <1121556776.11263.13.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1121556776.11263.13.camel@localhost.localdomain>
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
To: Jeff Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Sat, 16 Jul 2005, Jeff Layton wrote:

> Hi all,
> 
> I sent this earlier from a different account but it never showed up, so
> apologies if it's a duplicate...

Sorted.

> 
> Currently the 'addr=' mount option for nfs mounts is ignored. I'd like
> to roll a patch for mount such that this option is instead treated as an
> address hint. If the address provided by the 'addr=' option matches one
> of the addresses returned by gethostbyname(), then the mount program
> would use that address for the mount. Otherwise, the existing behavior
> (use first address in list) would prevail.

I think I'm missing something?
How do you get proximity information from the 'addr=' address?

Ian
