From: raven@themaw.net
Subject: Re: automount 4.1.3: unmount timeout not working
Date: Sat, 29 Jan 2005 11:59:53 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501291154590.1607@donald.themaw.net>
References: <20050122215228.GA14303@tangens.sinus.cz>
	<Pine.LNX.4.61.0501262240140.1716@donald.themaw.net>
	<20050126194824.GA3627@tangens.sinus.cz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050126194824.GA3627@tangens.sinus.cz>
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
To: Pavel Troller <patrol@sinus.cz>
Cc: autofs@linux.kernel.org

On Wed, 26 Jan 2005, Pavel Troller wrote:

>>
>> But you leave out the crucial log trace following the mount?
>>
>> Can we see more of what follows here please.
>>
>> Ian
> Hello Ian,
>  OK, I'm sending the full system log during the mount/umount... I don't know
> which part You are interested in, but I don't see anything special...

Maybe because what I'm looking for is not there.
So this is probably the cause of the probem.

I think that what is happening is that for the short timeouts you are 
using the expire timer is being set to 0, disabling expiration.

I'll have a look but does this work if you set the timeout to 4 seconds or 
above?

Ian
