From: Ian Kent <raven@themaw.net>
Subject: RE: Exporting UID to userspace?
Date: Tue, 8 Jun 2004 09:15:12 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406080901490.17060@wombat.indigo.net.au>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841A3@frodo.avalon.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1B7C89B8DCB084C809A22D7FEB90B3841A3@frodo.avalon.ru>
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

On Mon, 7 Jun 2004, Dimitry V. Ketov wrote:

> > -----Original Message-----
> > From: raven@themaw.net [mailto:raven@themaw.net] 
> > Sent: Saturday, June 05, 2004 7:47 PM
> 
> > I'd like to do it but it isn't trivial so it's in the wait queue.
> > 
> > It's dificult because it requires that the packet which is used to 
> > communicate with the daemon will need to be changed. This will break 
> > backward compatibility with other versions.
> 
> Ok. Is it mean that it will be included only in the next version of
> autofs protocol?

Perhaps but probably not. It means that, if the kernel module changes are 
accepted and the changes are made to the autofs daemon, then from that 
time on the kernel module will only work with the corresponding later 
versions of the autofs daemon and the daemon will require that version or 
later of the kernel module. This is not something that can be taken 
lightly. I will think about this for a while and see if I can come up with 
some way to do it.

Fact is I'm still struggling to get bugs fixed. When that has settled down 
there are a couple of quite serious limitations with autofs that need to 
be addressed. They've been outstanding for many months.

Ian
