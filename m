From: raven@themaw.net
Subject: Re: Local mounts without NFS server
Date: Sat, 1 May 2004 11:54:15 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405011152290.5768@donald.themaw.net>
References: <ufa65bi8qxv.fsf@epithumia.math.uh.edu>
	<ufa65bh1pjj.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ufa65bh1pjj.fsf@epithumia.math.uh.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: autofs@linux.kernel.org

On Fri, 30 Apr 2004, Jason L Tibbitts III wrote:

> >>>>> "BL" == Brian Long <brilong@cisco.com> writes:
> 
> BL> I like your idea about keeping the /cache up to date via
> BL> rsync.
> 
> Well, it's actually a hack but it works well enough.
> 
> BL> What other maps, mounts or symlinks do you have to keep this
> BL> working?
> 
> Just to /etc/auto_usr_local files, one for the hosts with /cache and
> one without.  These days, though, every machine has enough disk to
> cache what it needs.  That wasn't the case back when I put this
> together.
> 
> BL> For example, for hosts that don't have a /cache filesystem, do
> BL> they have a separate auto_usr_local map?
> 
> Yes, the hosts pull what they need from a server, and hosts without
> /cache pull a different auto_usr_local map.  I guess if I used
> failover I wouldn't even have to do that, but I'm not sure if that's
> supported far enough back.

4.1.1 I think.

It's a mount time check only. There is no dynamic failover.

The umounting logic needs to made smarter as well.

Ian
