From: Ian Kent <raven@themaw.net>
Subject: Re: Low priority question: negative cache in autofs5
Date: Fri, 05 Dec 2008 22:44:02 +0900
Message-ID: <1228484642.14030.31.camel@zeus.themaw.net>
References: <493910C7.9010308@s3group.cz>
	<1228477716.3033.37.camel@zeus.themaw.net>
	<49391C76.8030704@s3group.cz>
	<1228482604.14030.15.camel@zeus.themaw.net>
	<49392CE0.8010004@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49392CE0.8010004@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2008-12-05 at 14:30 +0100, Ondrej Valousek wrote:
> > The negative cache working properly will return a fail immediately so
> > you shouldn't see this.
> >
> > But then it shouldn't happen for the first case either.
> > There are quite a few changes scheduled for the next update and I
> > haven't seen this for a while now so it's a bit hard to get exited about
> > it.
> >
> >   
> Ok, I understand - in summary:
> #1 problem should go [hopefully] away with 5.3
> #2 problem is known bug being worked on....

Right, but problem #1 may be tied to problem #2, not quite sure yet.
A fix for the negative cache issue is way too late for 5.3.
We would need to get a test package to you for that, once it's done.

> Thanks!
> O.
