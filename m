From: Greg Wooledge <wooledg@eeg.ccf.org>
Subject: Re: [PATCH 3/5] logging to stderr
Date: Tue, 15 Feb 2005 10:29:40 -0500
Message-ID: <20050215152940.GX1535@eeg.ccf.org>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>
	<16912.49643.760509.977965@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0502150923460.22172@wombat.indigo.net.au>
	<16913.63757.849983.485803@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16913.63757.849983.485803@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Tue, Feb 15, 2005 at 08:28:45AM -0500, Jeff Moyer wrote:
> Putting autofs in the foreground doesn't buy you much, except to debug
> initialization.  Much of the "business logic" is executed in forked
> processes.  I'm not against this, but I must say that I find all of the
> information I need to debug autofs problems in the logs.  That's why I'm
> curious as to why someone would invest the time in these patches.

My first guess would be that he wants to manage autofs under daemontools
or runit.

http://cr.yp.to/daemontools.html
http://smarden.org/runit/
