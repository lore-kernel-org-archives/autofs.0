From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/5] logging to stderr
Date: Tue, 15 Feb 2005 09:26:11 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502150923460.22172@wombat.indigo.net.au>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>
	<16912.49643.760509.977965@segfault.boston.redhat.com>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 14 Feb 2005, Jeff Moyer wrote:

> ==> Regarding [autofs] [PATCH 3/5] logging to stderr; Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> adds:
> 
> vda> Add code, but do not switch rest of program to use it, yet.
> 
> I'm curious, what is the motivation for this?

I believe it relates to the patch before this.
Putting autofs in the foreground we want as much debug info as we can get.

Ian
