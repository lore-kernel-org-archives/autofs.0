From: Joseph Mack NA3T <jmack@wm7d.net>
Subject: Re: automount doesn't expire nested nfs mounts for certain
 kernel configs
Date: Mon, 10 May 2004 06:52:06 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405100644140.12924@www.wm7d.net>
References: <409E4AB5.6A3CCEB1@wm7d.net>
	<Pine.LNX.4.58.0405100913350.14283@wombat.indigo.net.au>
	<Pine.LNX.4.58.0405100504440.7687@www.wm7d.net>
	<Pine.LNX.4.58.0405102051180.19425@donald.themaw.net>
	<Pine.LNX.4.58.0405100605110.10734@www.wm7d.net>
	<Pine.LNX.4.58.0405102123390.19425@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405102123390.19425@donald.themaw.net>
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

> Do you have anything running that may be scanning the directories?

thought of that. There's nothing I know of that's doing it at 10sec
intervals (my timeout) and I saw nothing with lsof or fuser.  Also didn't
see anything the logs (although didn't regard this as definitive). If
anything was scanning directories, then disabling the first line in the
kernel config wouldn't have fixed it.

> The compaq stuff has done this in the past or sometimes gnome destops have
> this problem.

I use fvwm2 with a pile of xterms. I can't handle the fancy graphics
interfaces.

> You might like to apply the 4.1.2 patches at the same location you got the
> tar.

OK, will go get them

Thanks

Joe

-- 
Joseph Mack NA3T EME(B,D), FM05lw North Carolina
jmack (at) wm7d (dot) net - azimuthal equidistant map
generator at http://www.wm7d.net/azproj.shtml
Homepage http://www.austintek.com/ It's GNU/Linux!
