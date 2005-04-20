From: raven@themaw.net
Subject: Re: replicated mounts patch
Date: Wed, 20 Apr 2005 20:13:50 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504202006530.1883@donald.themaw.net>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
	<1113941787.1274.84.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.58.0504200922220.7460@wombat.indigo.net.au>
	<1113960613.5879.14.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504201932310.1883@donald.themaw.net>
	<1113997219.9683.3.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113997219.9683.3.camel@barsoom.rdu.redhat.com>
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
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Wed, 20 Apr 2005, Jeffrey Layton wrote:

> On Wed, 2005-04-20 at 19:34 +0800, raven@themaw.net wrote:
>> What about a function to chew up spaces before the colon, then parse.
>>
>> Ian
>
> Yes, after I sent that last night, it hit me that I could just strip out
> all spaces that are adjacent to commas and then run it through the
> current parser. I'll take a crack at writing something to do that soon.

That's great.
I'll look further into the code when I get a chance.

This exersise is likely going to be fairly difficult and take a while as 
we really need to get this right since we've had some much trouble here.

However, the coding style looks good to me so it should be much easier to 
spot the bugs. But we'll work on that as well.

Ian
