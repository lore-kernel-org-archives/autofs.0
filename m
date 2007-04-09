From: Paul Smith <psmith@netezza.com>
Subject: Re: How exactly does timeout work?
Date: Mon, 09 Apr 2007 13:36:35 -0400
Message-ID: <1176140195.30046.225.camel@psmithub>
References: <1176133554.30046.175.camel@psmithub>
	<x49wt0ly17p.fsf@segfault.boston.devel.redhat.com>
	<x49slb9xzu6.fsf@segfault.boston.devel.redhat.com>
	<1176137315.30046.185.camel@psmithub>
	<x49odlxxz70.fsf@segfault.boston.devel.redhat.com>
	<1176138870.30046.203.camel@psmithub>
	<x49k5wlxy4i.fsf@segfault.boston.devel.redhat.com>
Reply-To: psmith@netezza.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49k5wlxy4i.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org

On Mon, 2007-04-09 at 13:21 -0400, Jeff Moyer wrote:
> I'm not sure that the internals are really worth discussing in the man
> page

I agree with you to some extent, and I don't think the underlying method
(using an ioctl, etc.) should be documented there, but I think the
details of this algorithm can make a difference to how you decide set
the timeout value, especially for larger timeouts.  It's not even really
clear (from my reading of the man page) that the timeout is "time from
the last access of the filesystem", as opposed to "how often we check to
see if anyone is using it".  At the least it seems like that should be
made clear, even if the other details (how often the daemon checks for
example) are not spelled out.  Maybe the text:

-t, --timeout
        Set the minimum timeout, in seconds, until directories are
        unmounted.  The default is 5 minutes.  Setting the timeout to
        zero disables unmounts completely.

could be rewritten as:

-t, --timeout
        Set the minimum timeout, in seconds, from the last access of the
        directory until it is unmounted.  The default is 5 minutes.
        Setting the timeout to zero disables unmounts completely.

An extra sentence could also be added: "Access times are checked
periodically, so the actual timeout will be greater than this value.
The longer the timeout, the less frequently the access times are
checked." or something.

> We'll see what Ian thinks.

OK, cheers!

-- 
-----------------------------------------------------------------------------
 Paul D. Smith <psmith@netezza.com>                       http://netezza.com
 "Please remain calm--I may be mad, but I am a professional."--Mad Scientist
-----------------------------------------------------------------------------
      These are my opinions--Netezza takes no responsibility for them.
