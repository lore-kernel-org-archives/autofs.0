From: raven@themaw.net
Subject: Re: [PATCH] semi-trivial patches
Date: Mon, 11 Apr 2005 23:05:21 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504112303000.3448@donald.themaw.net>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
	<200504111101.13933.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0504111704160.18235@wombat.indigo.net.au>
	<200504111526.23279.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200504111526.23279.vda@port.imtp.ilyichevsk.odessa.ua>
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
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Mon, 11 Apr 2005, Denis Vlasenko wrote:

> On Monday 11 April 2005 12:14, Ian Kent wrote:
>> I remember applying several of your patches to do with this some time ago.
>> On my development machine (an Ultra 2), the autofs daemon failed
>> completely when trying to log. I mailed you asking about it but received
>> no answer.
>
> I decided to return to it on next non-beta. This is what I've found:
>
> Crash was caused by me erroneously using syslog() instead of vsyslog().
> (I didn't test logging to syslog back then, and bug slipped through).
>
>> Are you able to help merging them when I get to it?
>
> Sure.
>
> Also please find attached patches which implement
> running in foreground and stderr logging.

Saved em.
Will get to them later.

I really, really want to fix the direct mounts so I'm going to spend some 
time on that before I get into merging the enhancements I have. If I could 
just get 4.1.4 out without those silly errors....

Ian
