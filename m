From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
	5} and bind mounts which point	to	other	automount points
Date: Thu, 31 Aug 2006 19:57:36 +0800
Message-ID: <1157025457.14116.18.camel@raven.themaw.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1157023109.14116.12.camel@raven.themaw.net>
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

On Thu, 2006-08-31 at 19:18 +0800, Ian Kent wrote:
> On Thu, 2006-08-31 at 18:25 +0800, Ian Kent wrote:
> > > 
> > > Same deal, I think :-\
> 
> And I've been able to duplicate this on fc6-test2 with exactly the same
> rpm. I'm beginning to think that it is mount(8) that's at fault here.
> 
> Maybe it's yet another attempt to remove support for the "-s" option.
> We'll see.
> 
> I'd be interested to know if it works for an NFS mount entry with no
> mount options.

And it won't work

It's selinux again.
I'll bet your FC6 install has selinux in enforcing mode.

I'll bet that if you enable auditing of the "dontaudit" rules:

semodule -b /usr/share/selinux/targeted/enableaudit.pp

you'll get a message like:

audit(1157054094.219:95): avc:  denied  { read } for  pid=9255
comm="automount" name="users" dev=0:18 ino=19065
scontext=user_u:system_r:automount_t:s0
tcontext=system_u:object_r:nfs_t:s0 tclass=dir

in your logs.

Ian
