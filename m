From: Joseph Mack NA3T <jmack@wm7d.net>
Subject: Re: automount doesn't expire nested nfs mounts for certain
 kernel configs
Date: Mon, 10 May 2004 06:15:56 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405100605110.10734@www.wm7d.net>
References: <409E4AB5.6A3CCEB1@wm7d.net>
	<Pine.LNX.4.58.0405100913350.14283@wombat.indigo.net.au>
	<Pine.LNX.4.58.0405100504440.7687@www.wm7d.net>
	<Pine.LNX.4.58.0405102051180.19425@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405102051180.19425@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On Mon, 10 May 2004 raven@themaw.net wrote:

> > Here's a suggestion for a fix
> >
> >    < > Kernel automounter version 1,2 support (incompatible with v3,4)
> >    < > Kernel automounter version 3,4 support
> >
>
> That's not right.
>
> The first option is autofs (aka v3).

OK, I don't know what's really going on here. I just know that to get what
I want (expiration of nested nfs mounts), I can't have the first one
activated, and you don't find this out till you read the kernel config
help file.

> 4.1.0 and above should automatically load the v4 module unless the v3
> module is already loaded.

no autofs.o, only autofs4.o loaded on my machine.

> With autofs-4.1.2 add a -d to the master map line and send the log
> fragment.

OK, not knowing where to add the -d, I'd put it in the autofs init.d
script with daemonoptions and it seemed to work

Let me set it up here and I'll post some logs (in another posting)

> What is in your master map then?

/nfs	/etc/auto.nfs.machine_name	-bg,intr,suid,nodev

> And the map your trying to load?

I sent a line with my first posting. It was

server	-fstype=nfs,soft	/ server:/ \
				/usr server:/usr \
				/src server:/src

Thanks Joe

-- 
Joseph Mack NA3T EME(B,D), FM05lw North Carolina
jmack (at) wm7d (dot) net - azimuthal equidistant map
generator at http://www.wm7d.net/azproj.shtml
Homepage http://www.austintek.com/ It's GNU/Linux!
