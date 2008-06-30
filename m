From: Steffen Grunewald <steffen.grunewald@aei.mpg.de>
Subject: Re: More autofs problems
Date: Mon, 30 Jun 2008 15:45:34 +0200
Message-ID: <20080630134534.GU11428@casco.aei.mpg.de>
References: <4868946B.7050801@aei.mpg.de>
	<1214815665.3008.11.camel@raven.themaw.net>
	<4868B0BA.9040208@aei.mpg.de>
	<1214822142.3008.18.camel@raven.themaw.net>
	<4868DD3C.5020706@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <4868DD3C.5020706@aei.mpg.de>
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
To: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Mon, Jun 30, 2008 at 03:18:52PM +0200, Carsten Aulbert wrote:
> Hi Ian,
> 
> Ian Kent wrote:
> > 
> > This patch is a combined diff of the current bug fixes for autofs4,
> > against 2.6.24 (it applied OK to vanilla 2.6.24.4).
> 
> It applies fine and we are about to test it on a single test node now.
> If that succeeds we will push it onto the cluster.

It will also apply to 2.6.25.9 (with minor offsets).
Any estimate when the patch will make it into the mainstream kernel?

> Keeping my fingers crossed

Good luck. (If you need the 25.9 kernel package, you know where to get it :)

Steffen
