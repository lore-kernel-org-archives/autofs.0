From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [weasel@debian.org: Bug#296238: autofs breaks nis
	auto.master when there is a tab in nsswitch]
Date: Tue, 22 Feb 2005 18:38:33 +0100
Message-ID: <20050222173833.GA18046@uio.no>
References: <20050221112243.GA18164@uio.no>
	<Pine.LNX.4.61.0502220039110.20458@donald.themaw.net>
	<20050222130204.GA16052@uio.no>
	<Pine.LNX.4.61.0502222237240.1806@donald.themaw.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502222237240.1806@donald.themaw.net>
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

On Tue, Feb 22, 2005 at 10:39:19PM +0800, raven@themaw.net wrote:
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=295723
> Thanks Steinar, I'll unroll the expression in a loop to fix this.
> 
> Would you like an interim patch or would you prefer to wait for beta3?

I can wait for beta3, no problem. Do you do s/sh/bash/ in it while you're at
it (or optionally POSIXify the script)?

/* Steinar */
-- 
Homepage: http://www.sesse.net/
