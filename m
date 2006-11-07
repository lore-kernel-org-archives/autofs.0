From: Peter Staubach <staubach@redhat.com>
Subject: Re: autofs illustrations
Date: Tue, 07 Nov 2006 15:40:03 -0500
Message-ID: <4550EF23.4050901@redhat.com>
References: <200611071719.kA7HJSvl002639@cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200611071719.kA7HJSvl002639@cs.utexas.edu>
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
To: Fletcher Mattox <fletcher+autofs@cs.utexas.edu>
Cc: autofs@linux.kernel.org

Fletcher Mattox wrote:
> Jeff Moyer writes:
>
>   
>> http://people.redhat.com/jmoyer/autofs_linux_kongress.pdf
>>     
>
> Jeff,
>
> Nice paper.  Thanks!  I'm suffering from RPC port exhaustion (you
> responded to one of my queries last week), so I am especially interested
> in your section on port allocation.  You state
>
> 	When a service requests an RPC connection, binding to
> 	a reserved port is the default.  The RPC layer scans
> 	ports starting from 800 down until it finds one that
> 	is unallocated.
>
> My experience is that the 2.6.17.4 kernel allocates between 512 and 1024
> and then begins with unreserved ports >33000.  Yeah, I know.  It's just
> a nit, but I thought I'd tell you anyway.
>
> The most interesting part of the paper was the comment about a practical
> limit of 100 mounts in rapid succession.  I am certain this is the limit
> we have bumped into.  Do you see any improvement in this in autofs 5?
>
> Unprivileged ports and/or UDP are not viable options for us, so I am
> forced to increase the timeout from 5 minutes to 24 hours, which in
> practice means they are always mounted.  We have about 400 automounted
> filesystems, so the only long term solution for us is to try to coalesce
> them to less than 100.  Very painful.

You have 400 automounted file systems, all of which need to be mounted at
the same time?  If so, I might suggest that static mounts might better serve
your needs.  Or, rethink the application and deployment.

    Thanx...

       ps
