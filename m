From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Bug#304226: outdated rsize,wsize overrides
Date: Mon, 11 Apr 2005 22:13:12 +0200
Message-ID: <20050411201312.GC24780@uio.no>
References: <20050411194555.139CED9443922@ninsei.internal.cyberhqz.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050411194555.139CED9443922@ninsei.internal.cyberhqz.com>
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
To: Ryan Murray <rmurray@debian.org>, 304226@bugs.debian.org
Cc: autofs@linux.kernel.org, control@bugs.debian.org

tags 304226 + upstream
thanks

On Mon, Apr 11, 2005 at 12:45:55PM -0700, Ryan Murray wrote:
> The defaults in auto.net specify to mount nfs shares with rsize=8192,wsize=8192
> 
> AFAIK, this was added back when the kernel defaulted to sizes of 4096, to
> improve performance.  Recent kernels use a higher value by default (32768).
> 
> The default autofs config should probably not specify these values,
> and leave it up to the kernel's defaults.

I'll fix this in the next upload (if there will be any before sarge); sending
it upstream as well.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
