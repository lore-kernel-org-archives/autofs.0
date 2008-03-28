From: Paul Smith <psmith@netezza.com>
Subject: Re: Cross-compilation still broken on 5.0.3
Date: Thu, 27 Mar 2008 23:05:31 -0400
Message-ID: <1206673532.3615.83.camel@homebase.localnet>
References: <1206658652.23286.2.camel@pioneer.netezza.com>
	<1206669260.2834.29.camel@raven.themaw.net>
Reply-To: psmith@netezza.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1206669260.2834.29.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Fri, 2008-03-28 at 10:54 +0900, Ian Kent wrote:
> But is this patch to configure.in really all that's needed?

What that patch does is assume that PIE is disabled in all
cross-compiled environments.

Jeff feels we should do something different: have a --with-pie flag
rather than assuming no PIE for a cross-compiled environment.  That's
certainly more flexible.  I can try to put something together that does
that if that's the way you'd prefer to go.
