From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
	5} and bind mounts which point to other	automount points
Date: Fri, 15 Sep 2006 19:54:31 +0800
Message-ID: <1158321271.2953.3.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net>
	<Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608251506180.25004@raven.themaw.net>
	<Pine.LNX.4.64.0608251917030.30523@raven.themaw.net>
	<Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608251417500.14075@frank.dcs.qmul.ac.uk>
	<1156516669.30971.43.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608271549370.21043@raven.themaw.net>
	<1156849871.15241.9.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608302028550.4441@frank.dcs.qmul.ac.uk>
	<1156994282.5281.4.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608311040070.2953@frank.dcs.qmul.ac.uk>
	<1157019921.14116.5.camel@raven.themaw.net>
	<1157023109.14116.12.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608311221110.12689@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0609032221570.24199@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0609151045470.11631@frank.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609151045470.11631@frank.dcs.qmul.ac.uk>
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
To: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Cc: autofs@linux.kernel.org

On Fri, 2006-09-15 at 10:57 +0100, Matt Bernstein wrote:
> On Sep 3 Matt Bernstein wrote:
> 
> > Further archaeology suggests that traversing home directories only works
> > if they have 755 permissions.
> >
> > I've no idea why.
> 
> Just to clarify, the "they" refers to the NFS-mounted directory. We try 
> not to create home directories with 755 perms.
> 
> /server/cream/export71/users/mb and /home/cream/home71/mb traverse 
> correctly, saying "Permission denied". The former is the NFS mount, and 
> the latter a bind mount. They both work irrespective of whether the other 
> is mounted or not.
> 
> /homes/mb says "No such file or directory". The log suggests it's trying 
> to do an NFS mount, when it should be another bind mount.
> 
> /homes/dave (cream:/export74/users/dave having 755 perms) works perfectly, 
> with two bind mounts and one NFS mount.

Can you send the log please.

> 
> Me and my layers of indirection... I suppose I could solve it by making 
> /homes/mb bind straight to :/server/cream/export71/users/mb, but that 
> wouldn't stop the bug from being there.

Yep.

Ian
