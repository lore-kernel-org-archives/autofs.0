From: raven@themaw.net
Subject: Re: [PATCH] replicated mounts overhaul
Date: Tue, 3 May 2005 23:07:17 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505032303380.8405@donald.themaw.net>
References: <1115040578.3594.9.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.62.0505022157230.9314@donald.themaw.net>
	<1115043862.3594.21.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1115043862.3594.21.camel@barsoom.rdu.redhat.com>
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
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Mon, 2 May 2005, Jeffrey Layton wrote:

> On Mon, 2005-05-02 at 22:01 +0800, raven@themaw.net wrote:
>> On Mon, 2 May 2005, Jeffrey Layton wrote:
>>
>>> Here's the latest version of the replicated mounts patch that I've been
>>> working on. I sent this a couple of weeks ago and got no response.
>>
>> I've been trying to get my direct mount stuff working.
>
> Sounds good, just wanted to make sure it didn't slip thru the cracks. I
> also wanted to make sure I don't allow any regressions as I update my
> patch for new CVS versions.
>
> Also, I've been doing some looking at what it will take to do the
> "subnet" locality check. The problem seems to be quite a bit more
> complicated than it seems at first glance. I'm trying to wrap my brain
> around netlink sockets as that seems to be the best way to get
> routing/netmask info out of the kernel.

Yep. Sounds good.

An interesting sideline to this might be to consider how this would apply 
to discovering hosts for a "-hosts" map type. Much later, but worth some 
thought.

>
> We might also want to consider patching "mount" for that effort since
> the current mount command just picks the first address when given a
> hostname that resolves to more than one address.

Ouch.

>
> If/when my other patch goes in, I'll start focusing on that.

It's a big change.
It would be good if we could get it right as the follow on overhead of 
subtle bugs is huge.

Ian
