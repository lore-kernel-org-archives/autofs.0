From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 3/5] logging to stderr
Date: Mon, 14 Feb 2005 17:21:45 +0100
Message-ID: <20050214162145.GA26266@uio.no>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>
	<16912.49643.760509.977965@segfault.boston.redhat.com>
	<20050214160739.GH9056@lenin.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20050214160739.GH9056@lenin.net>
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

On Mon, Feb 14, 2005 at 08:07:40AM -0800, Peter C. Norton wrote:
> There are sometimes good reasons to log to stderr instead of syslog.
> syslog is slow, loses messages, inflexable, and can introduce delays
> and huge volumes of crap to the disk.  Using stderr loggers can
> filter, or do things like rotate logs actively, etc.

OTOH, syslog makes it a lot easier to have unified systems for log rotation
etc. -- and I don't really see what you mean by "inflexible". I'd rather have
it all in one place than inventing a thousand new systems for (say) remote
logging.

Of course, having both isn't bad.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
