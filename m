From: raven@themaw.net
Subject: Re: [weasel@debian.org: Bug#296238: autofs breaks nis
	auto.master when there is a tab in nsswitch]
Date: Tue, 22 Feb 2005 22:39:19 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502222237240.1806@donald.themaw.net>
References: <20050221112243.GA18164@uio.no>
	<Pine.LNX.4.61.0502220039110.20458@donald.themaw.net>
	<20050222130204.GA16052@uio.no>
Mime-Version: 1.0
In-Reply-To: <20050222130204.GA16052@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Tue, 22 Feb 2005, Steinar H. Gunderson wrote:

> On Tue, Feb 22, 2005 at 12:41:41AM +0800, raven@themaw.net wrote:
>>> BTW, there's also multiple people complaining about the new auto.* scripts
>>> (see the Debian BTS), but I haven't had time to look into it yet.
>> It would be good if you could check it out.
>> I'm keen to know what's is broken.
>
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=295723

Thanks Steinar, I'll unroll the expression in a loop to fix this.

Would you like an interim patch or would you prefer to wait for beta3?

Ian
