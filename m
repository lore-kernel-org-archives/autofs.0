From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to
	thousands	of	entries
Date: Fri, 16 Jan 2009 09:33:31 +0900
Message-ID: <1232066011.3166.25.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
	<1231813498.3057.12.camel@zeus.themaw.net>
	<1231820126.3057.14.camel@zeus.themaw.net>
	<408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
	<1231823945.3057.20.camel@zeus.themaw.net>
	<408431290901131943t2c678c8ej10c1829c71b5a557@mail.gmail.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
	<408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
	<1231939076.3168.53.camel@zeus.themaw.net>
	<408431290901140620k11a8cf7evb667895a59c7e204@mail.gmail.com>
	<1231983710.3100.38.camel@zeus.themaw.net>
	<x49vdsgvcdk.fsf@segfault.boston.devel.redhat.com>
	<1232032573.3100.53.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232032573.3100.53.camel@zeus.themaw.net>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Paul Wankadia <junyer@google.com>

On Fri, 2009-01-16 at 00:16 +0900, Ian Kent wrote:
> > 
> > Sure, just read the whole map.  Even large maps aren't that big.  What
> > are we talking, 10k?  50k?  You're better off reading the whole thing in
> > at once.

As far as I can tell, up to about 10k is most common for large
configurations. But people also have maps as large as 30 - 40k entries,
so we should be thinking maps of that order in this discussion.
