From: raven@themaw.net
Subject: Re: replicated mounts patch
Date: Wed, 20 Apr 2005 19:34:29 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504201932310.1883@donald.themaw.net>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net> 
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net> 
	<1113941787.1274.84.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.58.0504200922220.7460@wombat.indigo.net.au>
	<1113960613.5879.14.camel@tleilax.poochiereds.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113960613.5879.14.camel@tleilax.poochiereds.net>
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
To: Jeff Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Tue, 19 Apr 2005, Jeff Layton wrote:

> On Wed, 2005-04-20 at 09:25 +0800, Ian Kent wrote:
>> But, I've had complaints about it in the past.
>> Call it an added feature.
>>
>> If we choose to not require it we will need to be clear about it in the
>> doco.
>>
>> Personally, I like to be able to add a space after each comma for
>> readability.
>>
>> Ian
>>
>
> It's certainly possible to do it, but will probably require rewriting
> the entire parser since my current approach probably won't work if we
> allow for it. Using POSIX regex'es might make it easier, but I'll need
> to look at how you use them under C.

What about a function to chew up spaces before the colon, then parse.

Ian
