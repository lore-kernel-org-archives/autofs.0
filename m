From: Stew Smith <stew.smith@sun.com>
Subject: Re: Status of >800 mounts
Date: Thu, 6 May 2004 14:15:49 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040506211549.GA6202@crashy.west.sun.com>
References: <409A7A7C.2000109@sedona.intel.com>
	<20040506185528.GA5149@crashy.west.sun.com>
	<1083872373.5887.463.camel@d158140025182>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1083872373.5887.463.camel@d158140025182>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Thu, May 06, 2004 at 12:39:33PM -0700, Chris Croswhite wrote:
> Why only up to 800 (although this is a large number)?  There are
> instances where I could have 1200-1600 clients connecting to the same
> server (4 way opteron) if I could that many...
> 

this limit has been hardcoded in the sunrpc layer since the
birth of time. it starts at 800 and counts down to 0 until
it find an unused port. requring a privileged port gets
you the default level of security NFSv3 provides...

anybody know why rpc doesn't use the full port 0-1023 range?

--
Stew Smith
