From: raven@themaw.net
Subject: Re: Badness in interruptible_sleep_on
Date: Sat, 8 May 2004 13:29:32 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405081324440.2371@donald.themaw.net>
References: <Pine.LNX.4.58.0405070532500.1979@fogarty.jakma.org>
 <Pine.LNX.4.58.0405071426500.11299@wombat.indigo.net.au>
 <Pine.LNX.4.58.0405072321530.1979@fogarty.jakma.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405072321530.1979@fogarty.jakma.org>
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
Cc: Linux autofs <autofs@linux.kernel.org>, Arjan van de Ven <arjanv@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 7 May 2004, Paul Jakma wrote:

> On Fri, 7 May 2004, Ian Kent wrote:
> 
> > Not sure what needs to be done about this Paul.
> > 
> > I eliminated the interruptible_sleep_on in my autofs4 patches long
> > ago.  The current updates are in 2.6.6-rc3-mm2.
> 
> Ah excellent news. I'm using Arjan van de Ven's 2.6.3-1.96 kernel at 
> the moment. So that problem will dissappear with a kernel update at 
> some stage. Thanks!
> 
> PS: Arjan, any chance of a kernel with davej's NFS stack fixes and 
> the autofs badness fixes? would be much appreciated!

While I have some patch sets around for earlier 2.6 kernels I advise 
against using them.

I'm in the process of making "single file" patches for the earlier kernels 
with all the updates that are in 2.6.6-rc3-mm2.

As an aside the same goes for the 2.4 patches.

I'll let you know when it's done. I expect to finish this weekend.

Ian
