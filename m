From: Ian Kent <raven@themaw.net>
Subject: Re: Here's a new really odd auto.net bug
Date: Mon, 15 Aug 2005 21:54:50 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0508152152090.2111@donald.themaw.net>
References: <200508150602.j7F62LNq023532@neophyte.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200508150602.j7F62LNq023532@neophyte.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Sun, 14 Aug 2005, Mike Marion wrote:

> On 10 Aug, Ian Kent wrote:
> 
> > OK. I thought you were talking about kernel patches. Sorry.
> 
> No, sorry.. daemon patches.
> 
> BTW, so far I've only seen one bug in the updated daemon with those patches,
> with ghosting and direct maps.  If a mount gets hung, then HUPing the daemons,
> even ones not related to the hung path (/net path hung and direct maps on
> paths /prj and /iceng) doesn't seem to work.
> 
> e.g. had a host where some new paths under /prj added to map weren't taking 
> effect.  Numerous hups to daemons didn't help.  Finally noticed an error about 
> stating a filesystem in /net.  Was able to force umount that path, and next 
> HUPs made new paths now accessible.   
> 
> Can recreate and strace daemon(s) sometime this week for more data.

That would be useful, thanks.

I fear that the resolution may not be simple as the daemon works as a 
finite state machine. If something blocks state transitions then 
everything stops.

Bummer.

Ian
