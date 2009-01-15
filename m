From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands
	of	entries
Date: Thu, 15 Jan 2009 12:02:04 +0900
Message-ID: <1231988524.3100.46.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<1231825886.3057.30.camel@zeus.themaw.net>
	<408431290901131958ncc1b2f9j5a736a4b5d03f1b4@mail.gmail.com>
	<1231922889.3168.39.camel@zeus.themaw.net>
	<20090115024748.GA25050@shell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090115024748.GA25050@shell>
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
To: Valerie Aurora Henson <vaurora@redhat.com>
Cc: autofs@linux.kernel.org, Paul Wankadia <junyer@google.com>

On Wed, 2009-01-14 at 21:47 -0500, Valerie Aurora Henson wrote:
> On Wed, Jan 14, 2009 at 05:48:09PM +0900, Ian Kent wrote:
> > On Wed, 2009-01-14 at 14:58 +1100, Paul Wankadia wrote:
> > > On Tue, Jan 13, 2009 at 4:51 PM, Ian Kent <raven@themaw.net> wrote:
> > > 
> > >         I think were about done with this.
> > >         Here's a patch with a few changes by me, please comment.
> > > 
> > > LGTM. Thanks.
> > 
> > Great.
> > I'll wait and see if Val spots anything before I commit it.
> 
> Just a quick note - I'm very sick right now (just a cold, but a nasty
> one) and not up to writing or reviewing patches.  I'll take a look as
> soon as my brain is reliable, hopefully in the next couple of days.

Bummer, hope you recover soon.

I'm about to commit it so we'll have to deal with any concerns you have
as update patches. It's not much different to the original anyway. We
also need to spend a bit more time on the other three patches you posted
when your up to it. I think Jeff got some regressions when testing
these. In any case the most recent issue Paul has flagged is probably a
higher priority atm.

> 
> Thanks to both of you!  BTW, Paul found and wrote the one-at-a-time
> hash algorithm, credit where credit is due.

Yep, I noted both of you in the CHANGELOG.

> 
> -VAL
