From: raven@themaw.net
Subject: Re: Patches for 4.1.4 (was: fix multi maps that have an
	implied '/' entry)
Date: Sun, 1 May 2005 21:31:05 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505012121350.2773@donald.themaw.net>
References: <17010.37023.613781.405203@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0504302307230.2229@donald.themaw.net>
	<20050430153923.GA25335@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050430153923.GA25335@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Sat, 30 Apr 2005, Steinar H. Gunderson wrote:

> On Sat, Apr 30, 2005 at 11:12:56PM +0800, raven@themaw.net wrote:
>> I've already placed a patch on kernel.org for that.
>> Check out autofs-4.1.4-multi-parse-fix.patch and let me know what you
>> think.
>
> I'm rapidly losing overview over what's going in and not here, with all the
> traffic :-) I'm planning an upload of autofs 4.1.4 to Debian unstable RSN;
> what patches do I want with this? Vanilla 4.1.4 + multi-parse-fix +
> non-replicated ping?

Sorry, I don't mean to be confusing.

This is the way that I do things normally.
Any smallish bug fixes that I think are really needed I post on kernel.org 
with the tarball.

I would recommend you include both of those patches.

>
> BTW: Ian, have you looked at
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=305872 ? I'm not really sure
> what the & is supposed to mean :-)

Interesting but not nearly enough information to resolve the issue.
The problem that is reported shouldn't be happening.

Debug logs needed.

The & is a placeholder for the key and the * is the wildcard key.

In

*	&:/var/local/bulk


if this map is mounted on /amnt then

ls /amnt/somehost

resolves to somehost:/var/local.bulk

Ian
