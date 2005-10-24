From: Ian Kent <raven@themaw.net>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Mon, 24 Oct 2005 23:59:42 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0510242357290.2769@donald.themaw.net>
References: <200510181321.08443.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510231153350.19690@donald.themaw.net>
	<200510241259.31961.krienke@uni-koblenz.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200510241259.31961.krienke@uni-koblenz.de>
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
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 24 Oct 2005, Rainer Krienke wrote:

> On Sonntag 23 Oktober 2005 06:00, you wrote:
> > On Tue, 18 Oct 2005, Rainer Krienke wrote:
> > > Hello,
> > >
> > > using the autofs package from suse10.0 (autofs-4.1.4-6.i586.rpm; autofs4
> > > kernel module, Kernel2.6.13-15) NFS mounts of user directories fail when
> > > using indirect mounts. The problem can be reproduced in a certrain setup
> > > describes below. Because of this, the description is a bit lenghty.
> >
> > Here is a patch to add a configure option to disable locking when calling
> > mount. It also adds a patch for mount that I hope will prevent mtab
> > coruption. Obviousy autofs needs to be built with the option added to
> > configure.
> >
> 
> I tried the patch (compiled with --disable-mount-locking) on a opensuse10 
> client. For me it seems to work. I wrote a script that randomly selects users 
> from our NIS auto.home map and accesses the home directory. After a while I 
> had about 4000 mounts on the client (99.9% bind mounts of course) and nothing 
> went wrong as far as I saw. The most important thing for me is of course that 
> using this patch my solution for hierarchcal mounts of the home directories 
> does work again.

Great.

I'll merge the configure option into the next release.

You understand that this will not be the default because of problems that 
other people might have and the dependence on mount locking working.

Perhaps in time....

Ian
