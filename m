From: "Fletcher Mattox" <fletcher+autofs@cs.utexas.edu>
Subject: Re: autofs illustrations
Date: Tue, 7 Nov 2006 11:19:28 -0600 (CST)
Message-ID: <200611071719.kA7HJSvl002639@cs.utexas.edu>
References: <x49y7qoxgk2.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49y7qoxgk2.fsf@segfault.boston.devel.redhat.com>
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
To: autofs@linux.kernel.org

Jeff Moyer writes:

> http://people.redhat.com/jmoyer/autofs_linux_kongress.pdf

Jeff,

Nice paper.  Thanks!  I'm suffering from RPC port exhaustion (you
responded to one of my queries last week), so I am especially interested
in your section on port allocation.  You state

	When a service requests an RPC connection, binding to
	a reserved port is the default.  The RPC layer scans
	ports starting from 800 down until it finds one that
	is unallocated.

My experience is that the 2.6.17.4 kernel allocates between 512 and 1024
and then begins with unreserved ports >33000.  Yeah, I know.  It's just
a nit, but I thought I'd tell you anyway.

The most interesting part of the paper was the comment about a practical
limit of 100 mounts in rapid succession.  I am certain this is the limit
we have bumped into.  Do you see any improvement in this in autofs 5?

Unprivileged ports and/or UDP are not viable options for us, so I am
forced to increase the timeout from 5 minutes to 24 hours, which in
practice means they are always mounted.  We have about 400 automounted
filesystems, so the only long term solution for us is to try to coalesce
them to less than 100.  Very painful.

Thanks again,
Fletcher
