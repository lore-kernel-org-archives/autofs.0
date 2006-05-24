From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [dubtsov@iis.nsk.su: Bug#319904: autofs: workaround]
Date: Wed, 24 May 2006 14:14:13 -0400
Message-ID: <x4964jvcmtm.fsf@segfault.boston.redhat.com>
References: <20060523104544.GA3982@uio.no>
	<1148482569.8182.33.camel@raven.themaw.net>
	<20060524174858.GB9644@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060524174858.GB9644@uio.no> (Steinar H. Gunderson's message
	of "Wed, 24 May 2006 19:48:58 +0200")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [dubtsov@iis.nsk.su: Bug#319904: autofs: workaround]; "Steinar H. Gunderson" <sgunderson@bigfoot.com> adds:

sgunderson> On Wed, May 24, 2006 at 10:56:09PM +0800, Ian Kent wrote:
>> Is the system using HAL?

sgunderson> According to the user, it is. Should this really affect autofs
sgunderson> any, though? I know there have been problems with autofs+hal
sgunderson> earlier, but I hope there's a better solution than just
sgunderson> removing hal? :-)

As Ian said, I think in this thread, there is a fix in the works for hal.
If the system supports hal, I really think that hal should be used for
removable media, not autofs.

At any rate, turning off hal will help to determine if this is a
hal-related issue.

-Jeff
