From: Ian Kent <raven@themaw.net>
Subject: Re: Fwd: autofs Bug ?
Date: Thu, 8 Apr 2004 19:58:50 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404081954130.3363@raven.themaw.net>
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

> 
> In the above stop function, immediately after sending the USR2 signal in the 
> else-Branch, the automount process is still alive, because it takes a while
> to go down. And therefore, the while-loop begins working and sends a second USR2.
> This was the moment when the automount process crashed, especially when there
> were umountable (not busy) (Network-) filesystems mounted.

Yes this was from the original autofs-3 RedHat package I took the patches 
from. It has been modified somewhat in 4.1.1 to reduce the signalling as 
it causes problems with umount. I put back some code I previously had. 
This may not be the problem you describe but please try 4.1.1 or later and 
let me know how you go.

Ian
