From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Read-only map
Date: Thu, 30 Oct 2008 09:32:40 -0400
Message-ID: <x49prliyzrb.fsf@segfault.boston.devel.redhat.com>
References: <49087C73.6080502@s3group.cz>
	<3ddb09290810291711k1c3980bfjb65dcd2f517c9d48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3ddb09290810291711k1c3980bfjb65dcd2f517c9d48@mail.gmail.com>
	(Steve Linn's message of "Wed, 29 Oct 2008 17:11:45 -0700")
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
To: Steve Linn <steve.linn@gmail.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>, raven@themaw.net

"Steve Linn" <steve.linn@gmail.com> writes:

> We had the same problem.  The kernel we were running had a
> "feature" where if the client mounts the same server and directory
> it would bind them together.  You would get RO or RW depending

The RHEL 5.2 kernel does not have that issue.

Cheers,

Jeff
