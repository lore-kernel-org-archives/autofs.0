From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs5 early daemonization side effects
Date: Wed, 18 Mar 2009 10:32:18 -0400
Message-ID: <x49sklahpfx.fsf@segfault.boston.devel.redhat.com>
References: <c2d0b6ec0903180710s63e5aaa7r567c66d1139dd718@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <c2d0b6ec0903180710s63e5aaa7r567c66d1139dd718@mail.gmail.com>
	(Leonardo Chiquitto's message of "Wed, 18 Mar 2009 11:10:21 -0300")
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

Leonardo Chiquitto <leonardo.lists@gmail.com> writes:

> Hello,
>
> I've been doing some tests with AutoFS5 and I'd like to confirm that
> the behavior I'm seeing during the daemon initialization is expected
> or not.
>
> The problem: when the autofs initscript returns, autofs is not really
> ready.

Strange.  I originally wrote the code to return a status via a pipe, so
that the init script would not return status until the daemon was ready
to service requests.  It also took care of the problem of the init
script returning success when the daemon actually failed.

Ian, has this changed?

-Jeff
