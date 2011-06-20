From: "Colin Simpson" <Colin.Simpson@iongeo.com>
Subject: Re: Thoughts on dynamic networking with AutoFS/NFS
Date: Mon, 20 Jun 2011 17:55:14 +0100
Message-ID: <1308588914.2438.20.camel@bhac.iouk.ioroot.tld>
References: <6E56BACC0FDACB4E88FD63C76CE749460D39CA@edi1exch01.iouk.ioroot.tld>
	<1308455985.3300.42.camel@perseus.themaw.net>
	<1308519497.27829.87.camel@shyster>
	<1308544462.3306.35.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1308544462.3306.35.camel@perseus.themaw.net>
Content-Class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Mon, 2011-06-20 at 05:34 +0100, Ian Kent wrote:
> The problem with that is "just gone" can't be defined.
> The remove server could be rebooting and be available soon.

That's true, but I wonder if it is largely machine type dependant. On a
server or a workstation it may pay to wait for ever. If on a laptop it's
not only unreachable but is "no route to host", it's very likely gone.
Maybe something that could be configurable? 


> The lockup is usually due to NFS not being willing to discard RPC ios,
> as I mentioned above. The trade off is shorter wait and likely data
> corruption or wait!
> 
> One source of the blocking is trying to umount a mount when the server
> is unavailable. That's actually fixable by simply not attempting to
> send
> the MOUNTPROC_UMNT to the server if it appears down. The consequence
> of
> that is "showmount -d <server>" becomes out of date since the list of
> client with mounts isn't updated. I'm not sure if the current
> umount.nfs
> does this. It certainly doesn't send the MOUNTPROC_UMNT at all for the
> lazy umount.

I'm guessing one option would be to remove the mount and queue the
MOUNTPROC_UMNT's somewhere? Does the server remove from this list if it
hasn't heard from the client for a while?

I think I'm now venturing in to the world of NFS more than autofs. I'll
redraft and follow up to the NFS mailing list as suggested.


Thanks again

Colin

This email and any files transmitted with it are confidential and are intended solely for the use of the individual or entity to whom they are addressed.  If you are not the original recipient or the person responsible for delivering the email to the intended recipient, be advised that you have received this email in error, and that any use, dissemination, forwarding, printing, or copying of this email is strictly prohibited. If you received this email in error, please immediately notify the sender and delete the original.
