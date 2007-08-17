From: Ian Kent <raven@themaw.net>
Subject: Re: A weird autofs problem
Date: Sat, 18 Aug 2007 02:40:57 +0800
Message-ID: <1187376057.3560.19.camel@raven.themaw.net>
References: <ufa1we3xcw5.fsf@epithumia.math.uh.edu>
	<1187320655.3560.2.camel@raven.themaw.net>
	<ufalkcack3k.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ufalkcack3k.fsf@epithumia.math.uh.edu>
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
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: autofs@linux.kernel.org

On Fri, 2007-08-17 at 09:27 -0500, Jason L Tibbitts III wrote:
> >>>>> "IK" == Ian Kent <raven@themaw.net> writes:
> 
> IK> That NFS problem was fixed in 2.6.18 I think.
> 
> Well, I'm at 2.6.20, so....
> 
> IK> Something has changed?
> 
> I honestly can't think of anything.
> 
> IK> We'll need you to get a first hand look at a broken system and
> IK> have a look around and see what really is wrong. And you know that
> IK> a debug log would be good too.
> 
> OK, here's a machine that's gone bad.  df shows:
> 
> nas01:/export/users-00/boyarkin
>                              -         -         -   -  /home/boyarkin
> 
> Attempting to unmount the directory results in "device is busy" as the
> user is currently logged in and has files open on the filesystem.

What about the output of an ls as you referred bogus entries being
listed. Is that actually the case? Is there anything in the log that
might give us a clue as to what's going on?

> 
> Unfortunately because the user has not logged out of this machine, I
> haven't been able to restart the automounter so debugging is not
> enabled.
> 
> Simply running "umount -l /home/boyarkin" as roott causes the mount to
> appear properly.

Yes, that would do the trick.

> 
> I've kicked the user out of the machine and restarted the automounter
> with debugging on.  I'll continue to watch this machine and see if the
> problem reoccurs.
> 
>  - J<
