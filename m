From: Ian Kent <raven@themaw.net>
Subject: Re: submount vs automount
Date: Tue, 29 Jun 2004 09:41:15 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406290932010.5546@wombat.indigo.net.au>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
	<Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
	<40DC6F84.5020701@sun.com><40E03CC2.7020601@sun.com>
	<40E04693.1010507@sun.com>
	<Pine.LNX.4.60.0406281749540.13910@fogarty.jakma.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0406281749540.13910@fogarty.jakma.org>
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
To: Paul Jakma <paul@clubi.ie>
Cc: autofs@linux.kernel.org, Mike Waychison <Michael.Waychison@sun.com>

On Mon, 28 Jun 2004, Paul Jakma wrote:

> On Mon, 28 Jun 2004, Mike Waychison wrote:
> 
> > This policy has to be determined on a machine-by-machine basis.  I 
> > think we can agree to that.
> 
> Or site by site. (yeah, pam_console, eg, doesnt do directory lookups 
> for config, but hey, maybe one day)
> 
> > I just chose to examine the :0 policy because doing so allows us to 
> > explore the implications of such an implementation.
> 
> ok.
> 
> > For example, after considering the 'owner' bit, I realize now that
> > autofs would:
> >
> > - still have to parse for such an option as it runs as root and would
> > likely have to setuid to the user in question (so umount(8) still works).
> >
> > - which implies that automount would need to know who triggered the
> > mount, which isn't possible without a protocol jump.
> 
> Yes, it would. I didnt realise automount did not have access to 
> credentials of the process which triggered the 'lookup'.

This came up recently and I've given it some thought.

A pipe is used to talk from the kernel to the automount process.
So either the info must be included in the packet or the mount seperated 
from the daemon and called using a helper.

The first option requires changing the packet size and so breaks backward 
compatibility. Not necessarily bad but would need to be carefully managed.

Thinking about it, the second seems quite feasibile.

It is similar to the method to be used by Mike.

Ian
