From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] RE: multiple servers per automount
Date: Mon, 13 Oct 2003 11:23:51 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0310131108160.3433-100000@wombat.indigo.net.au>
References: <6AB920CC10586340BE1674976E0A991D5955FC@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <6AB920CC10586340BE1674976E0A991D5955FC@slexch2.sugarland.unocal.com>
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
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net, Mike Waychison <Michael.Waychison@Sun.COM>

On Fri, 10 Oct 2003, Ogden, Aaron A. wrote:

>
>
> > So this would indicate that even if there is a device system that can
> > increase the number of unnamed devices that subsystems like NFS cannot
> > handle this many mounts.
>
> Maybe.  I'm not 100% certain though.  Currently I am holding steady at
> 710 active mounts, I am going to write a little script to mount more in
> small increments, ie. read a list of ~1000 mountpoints from /home, mount
> a few of them, check the filesystems, and repeat... this way I will know
> exactly where things break down.

Interesting.

If you can edge it up then it's probably not an available port
restriction.

There may be more than one issue at work here.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
