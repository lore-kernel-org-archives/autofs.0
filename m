From: Ian Kent <raven@themaw.net>
Subject: Re: New Debian packages
Date: Tue, 5 Apr 2005 11:03:23 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504051101400.25453@wombat.indigo.net.au>
References: <20050403000945.GB22336@uio.no>
	<Pine.LNX.4.58.0504041046400.27508@wombat.indigo.net.au>
	<20050404144805.GA20880@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050404144805.GA20880@uio.no>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Mon, 4 Apr 2005, Steinar H. Gunderson wrote:

> On Mon, Apr 04, 2005 at 10:51:36AM +0800, Ian Kent wrote:
> > I'm tempted to release 4.1.4. Most of the current issues are with the 
> > Debian portion of the init script which we have been working on.
> > 
> > Do you think we can get this bit right and go straight to release?
> 
> The only gripe I can find seems to be the replication, but that is probably
> too much to fix for 4.1.4. So a release seems OK, yes.

Do you mean the replicated server code. Yes it was broken and still needs 
more work. However I've tickled it again and it should be at least 
functional.

Ian
