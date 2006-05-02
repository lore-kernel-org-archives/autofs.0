From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Tue, 2 May 2006 19:33:28 +0200
Message-ID: <20060502173328.GA5006@uio.no>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Tue, May 02, 2006 at 11:35:02PM +0800, Ian Kent wrote:
> - Master map is now read and parsed by the `automount' daemon
>   - the parameters for the `automount' daemon are now very different.
>     See automount(8).

Ouch. Are there any plans for a conversion tool?

> - `autofs' version 5.0.0 will refuse to run if it cannot find an
>    autofs4 kernel module that supports protocol version 5.00 or above.

What kernels are this?

/* Steinar */
-- 
Homepage: http://www.sesse.net/
