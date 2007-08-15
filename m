From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS5
Date: Wed, 15 Aug 2007 13:31:39 +0800
Message-ID: <1187155899.3249.23.camel@raven.themaw.net>
References: <46C2005D.1090907@cs.ou.edu>
	<x498x8daovy.fsf@segfault.boston.devel.redhat.com>
	<x49vebh98nd.fsf@segfault.boston.devel.redhat.com>
	<46C212FA.7030201@cs.ou.edu>
	<1187155104.3249.14.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1187155104.3249.14.camel@raven.themaw.net>
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
To: jsummers@bachman.cs.ou.edu
Cc: autofs@linux.kernel.org

On Wed, 2007-08-15 at 13:18 +0800, Ian Kent wrote:
> > > 
> > > I'm guessing that you have 2.6.22.1-13.fc6 or later installed.  These
> > > kernels include the "nosharecache" patch for NFS.  This patch can
> > > cause some mounts to fail with -EBUSY.  You can revert the
> > > nosharecache patch to get the old behaviour back.
> > 
> > is this accomplished with boot option similar to 'noacpi' or something like that?
> 
> It's a mount option.
> Check your nfs-utils. I believe that revision 14 and above will
> understand the "nosharecache" option.

That's nfs-utils-1.0.10-14 for FC6.

If you happen to be using F7 or Rawhide then it's nfs-utils-1.1.0-3, but
it doesn't look like the F7 package has got to the mirrors yet. The
patch for the option was inadvertently missed from F7 and Rawhide when
the patch went into the kernel.

Ian
