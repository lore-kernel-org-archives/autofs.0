From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 3/5] logging to stderr
Date: Tue, 15 Feb 2005 08:28:45 -0500
Message-ID: <16913.63757.849983.485803@segfault.boston.redhat.com>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>
	<16912.49643.760509.977965@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0502150923460.22172@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.58.0502150923460.22172@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [PATCH 3/5] logging to stderr; Ian Kent <raven@themaw.net> adds:

raven> On Mon, 14 Feb 2005, Jeff Moyer wrote:
>> ==> Regarding [autofs] [PATCH 3/5] logging to stderr; Denis Vlasenko
>> <vda@port.imtp.ilyichevsk.odessa.ua> adds:
>> 
vda> Add code, but do not switch rest of program to use it, yet.
>> I'm curious, what is the motivation for this?

raven> I believe it relates to the patch before this.  Putting autofs in
raven> the foreground we want as much debug info as we can get.

I still haven't heard an answer from the original poster.

Putting autofs in the foreground doesn't buy you much, except to debug
initialization.  Much of the "business logic" is executed in forked
processes.  I'm not against this, but I must say that I find all of the
information I need to debug autofs problems in the logs.  That's why I'm
curious as to why someone would invest the time in these patches.

-Jeff
