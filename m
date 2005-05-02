From: Ian Kent <raven@themaw.net>
Subject: Re: Re: debug failed automount
Date: Mon, 2 May 2005 10:03:38 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0505020959430.8040@wombat.indigo.net.au>
References: <11101302050428071921ec8bb7@mail.gmail.com> 
	<11101302050429222770e0df9d@mail.gmail.com>
	<Pine.LNX.4.62.0504302318540.2229@donald.themaw.net>
	<Pine.LNX.4.62.0505012144150.2824@donald.themaw.net>
	<1110130205050116184381a11e@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1110130205050116184381a11e@mail.gmail.com>
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
To: Robert Swan <rswanster@gmail.com>
Cc: autofs@linux.kernel.org

On Sun, 1 May 2005, Robert Swan wrote:

> On 5/1/05, raven@themaw.net <raven@themaw.net> wrote:
> > On Sat, 30 Apr 2005 raven@themaw.net wrote:
> > 
> > My response was a bit hasty I think.
> > 
> > > On Sat, 30 Apr 2005, Robert Swan wrote:
> > >
> > >> >
> > >> >  One point is that the remote host is accessed through a VPN tunnel.
> > >>
> > >>  so as it turns out, this is the problem. The rpc_time call fails (I
> > >>  assume this is because it is not supported by the VPN) and this marks
> > >>  my only host as dead and automount does not attempt to mount. Even
> > >>  though the mount actually works fine.
> > >
> > > Why? The rpc_ping connects to port 2049 on the target host.
> > 
> > You may be seeing a bug with the autofs mount code not trying a longer
> > timeout if it fails to get a response in time.
> 
> I'm a bit confused myself because I can no longer replicate my
> problem. I had made a test program to call your get_best_mount() with
> my particular arguments so I could step through it, and  I'm _sure_
> (aren't we all) that it would get a failed status from rpc_time at
> line 238 and so would not assign a winner. I changed initial
> assignment of "winner" at the start of the function which solved my
> problem. I didn't look inside rpc_time to see what was going wrong; I
> tried to do that today and now the status from rpc_time() is
> successful, and your original code performs the mounts. So I don't
> have a bug report and you can ignore me.

This sound even more like the original problem.

The symptom was intermitent fails.

So if the target server responds quickly enough all is well.
But if there's a bit to much trafic or if you stop to scratch it doesn't 
work.

As I said I'd recommend the two patches on kernel.org.

> 
> Is there a way to attach a debugger to the automount process that gets
> spawned when the kernel attempts an automount?

Nothing that will help in this situation.
All the mount/umount is done in userspace by the daemon.

Ian
