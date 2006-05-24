From: Ian Kent <raven@themaw.net>
Subject: Re: [dubtsov@iis.nsk.su: Bug#319904: autofs: workaround]
Date: Wed, 24 May 2006 22:56:09 +0800
Message-ID: <1148482569.8182.33.camel@raven.themaw.net>
References: <20060523104544.GA3982@uio.no>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060523104544.GA3982@uio.no>
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
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Tue, 2006-05-23 at 12:45 +0200, Steinar H. Gunderson wrote:
> I'm forwarding this here; I hope it's useful somehow. :-) For those not
> following context, it's the "does not umount after timeout" problem, which
> I'm not sure is related to the cache problems etc. or not.
> 
> The entire bug log can be seen at http://bugs.debian.org/319904 .

Is the system using HAL?
Has it been updated recently?

You can tell if it is HAL by stopping it and seeing if the problem goes
away.

Ian
