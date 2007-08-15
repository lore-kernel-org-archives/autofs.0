From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS5
Date: Wed, 15 Aug 2007 13:18:24 +0800
Message-ID: <1187155104.3249.14.camel@raven.themaw.net>
References: <46C2005D.1090907@cs.ou.edu>
	<x498x8daovy.fsf@segfault.boston.devel.redhat.com>
	<x49vebh98nd.fsf@segfault.boston.devel.redhat.com>
	<46C212FA.7030201@cs.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46C212FA.7030201@cs.ou.edu>
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

On Tue, 2007-08-14 at 15:39 -0500, Jim Summers wrote:
> Jeff Moyer wrote:
> > Jeff Moyer <jmoyer@redhat.com> writes:
> > 
> >> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
> >>
> >>> Hello All,
> >>>
> >>> Just hit a hiccup with autofs5.  Everything was going along fine and then had 
> >>> a user call and say they could not get their home on a machine.  I did some 
> >>> quick checking and some mounts were working and others not.  below is a bit of 
> >>> the debug log and some other info.  the user, gerardo is the one who called 
> >>> me.  entries in the debug log for him are the same as the tmac user.  in that 
> >>> it get his ldap info tries to mount but then says it is already mounted and 
> >>> then fails????
> >>>
> >>> client machine is FC6 hand compiled autofs version:
> >>> autofs-5.0.1-20
> >>> autofs-debuginfo-5.0.1-20
> >>> with a patch from Ian.
> >> What is the kernel version on the client?
> 
> 2.6.22.1-32.fc6
> 
> > 
> > I'm guessing that you have 2.6.22.1-13.fc6 or later installed.  These
> > kernels include the "nosharecache" patch for NFS.  This patch can
> > cause some mounts to fail with -EBUSY.  You can revert the
> > nosharecache patch to get the old behaviour back.
> 
> is this accomplished with boot option similar to 'noacpi' or something like that?

It's a mount option.
Check your nfs-utils. I believe that revision 14 and above will
understand the "nosharecache" option.

Add this as a global option by changing:

#OPTIONS=""

to

OPTIONS="-O nosharecache"

in /etc/sysconfig/autofs, near the bottom and let us know if this helps.

Ian
