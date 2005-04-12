From: Ian Kent <raven@themaw.net>
Subject: Re: Re: Bug#304226: outdated rsize,wsize overrides
Date: Tue, 12 Apr 2005 12:51:32 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504121250380.11391@wombat.indigo.net.au>
References: <20050411194555.139CED9443922@ninsei.internal.cyberhqz.com>
	<20050411201312.GC24780@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050411201312.GC24780@uio.no>
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
Cc: autofs@linux.kernel.org, 304226@bugs.debian.org, Ryan Murray <rmurray@debian.org>, control@bugs.debian.org

On Mon, 11 Apr 2005, Steinar H. Gunderson wrote:

> tags 304226 + upstream
> thanks
> 
> On Mon, Apr 11, 2005 at 12:45:55PM -0700, Ryan Murray wrote:
> > The defaults in auto.net specify to mount nfs shares with rsize=8192,wsize=8192
> > 
> > AFAIK, this was added back when the kernel defaulted to sizes of 4096, to
> > improve performance.  Recent kernels use a higher value by default (32768).
> > 
> > The default autofs config should probably not specify these values,
> > and leave it up to the kernel's defaults.
> 
> I'll fix this in the next upload (if there will be any before sarge); sending
> it upstream as well.

These options are added by a Debian specific patch.

They aren't in the tar distribution.

Ian
