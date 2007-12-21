From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Seeing autofs-5.0.2 core dumping
Date: Fri, 21 Dec 2007 11:27:45 -0800
Message-ID: <20071221192744.GA14860@cornholio.qualcomm.com>
References: <20071221023024.GB10904@cornholio.qualcomm.com>
	<1198236856.3488.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1198236856.3488.11.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Fri, Dec 21, 2007 at 08:34:16PM +0900, Ian Kent wrote:

> There was a bug that caused the direct map to be pruned out of existence
> when a server connection failed for some reason. I don't remember seeing
> a SEGV although I wasn't paying attention to that when I worked on it.

Yeah, we're digging into trying to get more info via debugging.  The
weird thing is that every host with an issue seems to be doing the
umount/rmdir on the exact same subset of paths (about 13 out of almost
7000 entries) and I'm positive that at least 1 path was changed 2 days
ago.  Changed in that the local path is different, but the mount point
(server:/path) is the same.  So we're going to try to re-create this on
a host by hand to see if it has to do with the daemon seeing a change in
what it has cached vs what the maps now answer with.

Even a new daemon seems to show this problem eventually too (if
restarted on a host after the daemon core dumped before) so it might be
that the change can be seen between what's in /proc/mounts still vs the
ldap map entries, and can poison the new daemon too.

BTW, not positive on this yet, but it seems like setting the logging to
debug (vs verbose) in /etc/sysconfig/autofs doesn't seem to trigger the 
same logging with 5.0.2 that it did/does with 5.0.1.  

> That shouldn't be a problem except that expires and map reads will take
> much longer. If there are problems with synchronization I expect you
> will see them before most others.

Yeah, what takes a _really_ long time, but actually works well (a credit
to the autofs5 code) is that if the running daemon is dorked or dies or
whatever... you can start up a new one, and it'll parse the entire
/proc/mounts path and take over the existing mounts and such just fine.

> I would prefer to work from fully patched source if possible.

We'll be doing some testing on this as well.  Just harder for us to get
buy-in to push out an update on something this important to the compute
pool.. but if we can prove it's more stable and fixes a problem, it's
a little easier.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
Peggy: "12 years old and drinking a beer!?!"
Bobby: "I didn't even like it!"
Hank: "Well now you're just trying to get me mad!" ==> King of the Hill
