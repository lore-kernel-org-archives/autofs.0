From: "Peter C. Norton" <spacey-autofs@lenin.net>
Subject: Re: [PATCH 3/5] logging to stderr
Date: Mon, 14 Feb 2005 08:07:40 -0800
Message-ID: <20050214160739.GH9056@lenin.net>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>
	<16912.49643.760509.977965@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16912.49643.760509.977965@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, Feb 14, 2005 at 10:21:15AM -0500, Jeff Moyer wrote:
> ==> Regarding [autofs] [PATCH 3/5] logging to stderr; Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> adds:
> 
> vda> Add code, but do not switch rest of program to use it, yet.
> 
> I'm curious, what is the motivation for this?
> 
> -Jeff

There are sometimes good reasons to log to stderr instead of syslog.
syslog is slow, loses messages, inflexable, and can introduce delays
and huge volumes of crap to the disk.  Using stderr loggers can
filter, or do things like rotate logs actively, etc.

I don't know if any of these are the motivations for the patch, but if
its not intrusive its a good idea.

-Peter

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.
