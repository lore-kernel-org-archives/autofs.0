From: Ian Kent <raven@themaw.net>
Subject: Re: Fwd: autofs Bug ?
Date: Thu, 8 Apr 2004 20:04:02 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404082001010.3363@raven.themaw.net>
References: <200404061002.i36A2s905388@NGEW05.math.tu-dresden.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200404061002.i36A2s905388@NGEW05.math.tu-dresden.de>
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
To: Roland Pfretzschner <pfr@math.tu-dresden.de>
Cc: autofs@linux.kernel.org, John Saalwaechter <bababooey182@yahoo.com>

On Tue, 6 Apr 2004, Roland Pfretzschner wrote:

> > > make the problem worse.  After the restart the load on the
> > > Linux box will rise until it's high, and there will be multiple
> > > automount daemons for the same mount point.  A full system

Oh as well.

Jim Carter identified a possible infinite expire loop. I'm not sure that 
this is what is happening here but I applied his work around in 4.1.1 
also.

Please try this out.

Ian
