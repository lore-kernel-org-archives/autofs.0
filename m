From: raven@themaw.net
Subject: Re: Exporting UID to userspace?
Date: Sat, 5 Jun 2004 23:52:10 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406052350020.15861@donald.themaw.net>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841A0@frodo.avalon.ru>
 <Pine.LNX.4.58.0406052343120.15861@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406052343120.15861@donald.themaw.net>
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
To: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Cc: autofs@linux.kernel.org

On Sat, 5 Jun 2004 raven@themaw.net wrote:

> On Sat, 5 Jun 2004, Dimitry V. Ketov wrote:
> 
> > Hi, autofs hackers!
> > 
> > Is it possible with the current autofs protocol to export UID of (mount)
> > requesting process to the userspace automount daemon? If not, I guess
> > that it is rather trivial feature enhancement request ;)
> > The matter of this RFE is need to mount smbfs shares on behalf of
> > requestng users, with their own passwords...
> 
> This has been raised before.
> 
> I'd like to do it but it isn't trivial so it's in the wait queue.
> 
> It's dificult because it requires that the packet which is used to 
> communicate with the daemon will need to be changed. This will break 
> backward compatibility with other versions.
> 

In fact it gets worse.

How will you provide a consistent Unix UID <-> Windows UID mapping?

And on multiple machines for the same user, over OS re-install?

Ian
