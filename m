From: ramana <ramana@intraperson.com>
Subject: Re: [PATCH 3/5] logging to stderr
Date: Mon, 14 Feb 2005 22:02:48 +0530
Message-ID: <4210D2B0.9080601@intraperson.com>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>	<200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>	<200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>	<200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>	<16912.49643.760509.977965@segfault.boston.redhat.com>
	<20050214160739.GH9056@lenin.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Peter C. Norton" <spacey-autofs@lenin.net>
Cc: autofs@linux.kernel.org

Peter C. Norton wrote:

>There are sometimes good reasons to log to stderr instead of syslog.
>syslog is slow, loses messages, inflexable, and can introduce delays
>and huge volumes of crap to the disk.  Using stderr loggers can
>filter, or do things like rotate logs actively, etc.
>
>I don't know if any of these are the motivations for the patch, but if
>its not intrusive its a good idea.
>
>-Peter
>
>  
>
I put this feature right from the beginning in Autodir, not intended for 
above reasons but it helped and helps debugging many bugs.

Regards
ramana

-- 
http://www.intraperson.com
