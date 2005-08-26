From: Ian Kent <raven@themaw.net>
Subject: Re: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port
	usage problems
Date: Fri, 26 Aug 2005 11:44:21 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0508261141230.2586@wombat.indigo.net.au>
References: <20050825221428.GC1867@robsims.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050825221428.GC1867@robsims.com>
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
To: Rob Sims <robsims@robsims.com>
Cc: autofs@linux.kernel.org

On Thu, 25 Aug 2005, Rob Sims wrote:

> > THE PROBLEM DESCRIPTION:
> 
> > Autofs hangs and refuses to mount any directories for a period of time
> > after cd'ing to /net/<Netapp>/vol/vol[0-3] and waiting a while.
> > The only way to clear this is to reboot the client.
> 
> I didn't see a resolution to this in the archive - was it resolved?
> How?

This has come up several times and as far as I know we can resolve or 
work around these problems.

If you have a problem then we need to establish versions and symptoms to 
know what needs to be done to resolve it.

Ian
