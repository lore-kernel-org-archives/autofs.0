From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 15:46:54 +0100
Message-ID: <20050215144654.GA31420@uio.no>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no>
	<16914.2127.559335.703678@segfault.boston.redhat.com>
	<16914.2741.997861.638357@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16914.2741.997861.638357@segfault.boston.redhat.com>
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

On Tue, Feb 15, 2005 at 09:44:05AM -0500, Jeff Moyer wrote:
>> Yes, looks like a problem to me.  Thanks!  Attached is a patch.
> Actually, I fired too quickly on this one.  stderr is used for the error
> reporting, so we shouldn't mark the state as done until we've read
> everything from stdout.

Sounds reasonable; I'll leave it as-is.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
