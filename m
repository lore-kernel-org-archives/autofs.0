From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] FD_CLOEXEC cleanups
Date: Wed, 02 Apr 2008 12:08:10 -0400
Message-ID: <x49myocgryt.fsf@segfault.boston.devel.redhat.com>
References: <x49od8te2wh.fsf@segfault.boston.devel.redhat.com>
	<1207152164.23879.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1207152164.23879.11.camel@raven.themaw.net> (Ian Kent's message
	of "Thu\, 03 Apr 2008 00\:02\:44 +0800")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent <raven@themaw.net> writes:

> On Tue, 2008-04-01 at 16:27 -0400, Jeff Moyer wrote:
>> Hi, Ian,
>> 
>> We set the close on exec flag all over the place.  This patch just
>> cleans things up a bit.
>
> Yep, good idea.
>
> I would like to postpone this till after the mount control work is done
> because a number of these will be moved to the single open routine.

OK, I'll hold off on further cleanups until that work is in.

Thanks!

Jeff
