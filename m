From: Ian Kent <raven@themaw.net>
Subject: Re: multiple servers per automount
Date: Thu, 9 Oct 2003 11:07:28 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0310091104250.16859-100000@wombat.indigo.net.au>
References: <3F848163.2050803@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F848163.2050803@sun.com>
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
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org, "H. Peter Anvin" <hpa@zytor.com>

On Wed, 8 Oct 2003, Mike Waychison wrote:

> H. Peter Anvin wrote:
>
> >This should not be an autofs feature but an NFS feature, for obvious
> >reasons: it's equally applicable for static mounts.
> >
> >Furhtermore, failover HAS to be done at the NFS layer.
> >
> >The fact that Slowlaris does it in autofs is not a good motivation --
> >it's idiotic design.

Ohh .. Nasty .... mmmmaaahhh.

> >
> >
>
> *Ahem*.  Solaris has had NFS client failover since 2.6.   Linux is still
> playing catch up in this arena.
> Failover is not handled in the automount layer, but rather passed on to
> nfs layer itself.  man mount_nfs.
>

On a related not Mike.

Is the number of NFS mounts on Solaris unlimited or is it table driven?
I can't find a reference to it anywhere.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
