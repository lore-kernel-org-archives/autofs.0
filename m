From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Tue, 13 Jan 2009 14:19:05 +0900
Message-ID: <1231823945.3057.20.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
	<1231692176.10063.10.camel@zeus.themaw.net>
	<408431290901111525y578a5ba4n634ee8b071718790@mail.gmail.com>
	<1231723189.3073.7.camel@zeus.themaw.net>
	<1231732946.3073.44.camel@zeus.themaw.net>
	<1231736307.3073.68.camel@zeus.themaw.net>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
	<1231813498.3057.12.camel@zeus.themaw.net>
	<1231820126.3057.14.camel@zeus.themaw.net>
	<408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
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
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Tue, 2009-01-13 at 16:07 +1100, Paul Wankadia wrote:
> On Tue, Jan 13, 2009 at 1:24 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         > Why do you think that you've miscalculated the minimum?
>         
>         Well, maybe I haven't but I thought min should be > 0.
>         But, it's not worth worrying about as I think we've managed to
>         show a
>         clear improvement.
> 
> The minimum was zero because there were empty buckets.

Probably, but I used a separate variable to count zero buckets so the
chain lengths should be at least 1, but hey, unless the analysis here is
wrong (and I don't think it is) I'm not not going to spend time on it.

> 
> 
>         > I plotted the number of elements in each bucket.
>         >
>         > As you now see, the additive hash function doesn't scale.
>         
>         Sure and now we can say why it doesn't scale in the patch
>         description.
> 
> More importantly, who's the scapegoat? :P

That would be me, ;)

> 
> 
>         > Perhaps you could make it configurable?
>         
>         Perhaps, but I don't think this is the sort of thing that
>         should be
>         configurable so I'd prefer to make it a compile time option
>         rather than
>         a run time configuration setting.
> 
> On Tue, Jan 13, 2009 at 3:15 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         I've changed my mind, ;), configurable it is with a default of
>         977.
> 
> The hash function is good now, so the size of the hash table can be a
> power of two.

So your suggesting 1024 then, does it matter?

Ian
