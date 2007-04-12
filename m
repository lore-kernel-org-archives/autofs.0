From: Ian Kent <raven@themaw.net>
Subject: Re: determining which process triggered an automount
Date: Thu, 12 Apr 2007 18:05:04 +0800
Message-ID: <1176372304.3441.63.camel@raven.themaw.net>
References: <20070411234847.GH21698@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070411234847.GH21698@pixar.com>
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
To: Chris Walker <cwalker@pixar.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-04-11 at 16:48 -0700, Chris Walker wrote:
> I'd like to determine which process triggered an automount. Might I have
> to use Systemtap or some other tool to determine this?

Can't really do that with autofs version 4.
It's a bit of information that the daemon doesn't get in the request
packet from the kernel. This information is passed to the daemon in
autofs version 5 and is logged when debug logging is enabled so you
could try that.

Sorry I can't be more help.
Ian
