From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Fri, 16 Jan 2009 07:57:57 +1100
Message-ID: <408431290901151257i70400351yc3ab9360136c8e9c@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
	<408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
	<1231939076.3168.53.camel@zeus.themaw.net>
	<408431290901140620k11a8cf7evb667895a59c7e204@mail.gmail.com>
	<1231983710.3100.38.camel@zeus.themaw.net>
	<x49vdsgvcdk.fsf@segfault.boston.devel.redhat.com>
	<1232032573.3100.53.camel@zeus.themaw.net>
	<408431290901151233q33699529r6119788c998866ed@mail.gmail.com>
	<x49d4eouwt6.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49d4eouwt6.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On 1/16/09, Jeff Moyer <jmoyer@redhat.com> wrote:

> My argument is that you're not really saving much.  Just cache the whole
> file.  I agree that you probably want to detect changes, still.  For
> that, you can use mtime or inotify.  You could make a case for either
> side, though I think I'd argue for keeping the mtime approach (as the
> map may change multiple times before we actually try to read it, and
> doing the read in the lookup path really shouldn't be that big of a
> deal).  Of course, I haven't profiled this, so that may be worth doing.

If we can simply flag the cached version as stale, then lazy reloads
should be possible.
