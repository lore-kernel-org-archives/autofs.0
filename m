From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 2/2] autofs4 - fix string validation check order
Date: Tue, 28 Oct 2008 09:25:37 -0400
Message-ID: <x49prlk6ecu.fsf@segfault.boston.devel.redhat.com>
References: <20081028053047.29379.19919.stgit@zeus.themaw.net>
	<20081028053053.29379.15598.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20081028053053.29379.15598.stgit@zeus.themaw.net> (Ian Kent's
	message of "Tue, 28 Oct 2008 14:30:53 +0900")
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
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Ian Kent <raven@themaw.net> writes:

> In function validate_dev_ioctl() we check that the string we've
> been sent is a valid path. The function that does this check
> assumes the string is NULL terminated but our NULL termination
> check isn't done until after this call. This patch changes the
> order of the check.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
