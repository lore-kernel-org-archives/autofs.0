From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Thu, 8 Jan 2004 08:48:35 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0401080846410.9294-100000@wombat.indigo.net.au>
References: <Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@sun.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 7 Jan 2004, Jim Carter wrote:

>
> > The exception to this rule is when the map entry for /home contains the
> > option 'browse':
>
> Solaris 2.6 and above has the -browse option on indirect maps, so the set
> of subdirs potentially mountable can be seen, without mounting them. I
> don't see where this is implemented in Linux, nor do I see how it's done,
> documented in Solaris NFS man pages, but I didn't put a lot of time into
> the search.  I *hope* rpc.mountd has an opcode to enumerate every
> filesystem it's willing to export.  Does it "stat" and return the stat
> data?  That would be important for "ls".

So, even after our most recent email conversation, you still haven't
checked out autofs 4.1.0 and my kernel module kit.
