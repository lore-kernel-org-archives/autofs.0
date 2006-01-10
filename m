From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Debugging hung autofs /home?
Date: Tue, 10 Jan 2006 18:59:12 -0500
Message-ID: <17348.19024.416286.278340@segfault.boston.redhat.com>
References: <43C29C28.5090407@deragon.biz> <43C4405B.7050706@cs.arizona.edu>
	<17348.18543.789713.377209@segfault.boston.redhat.com>
	<43C4490B.2010301@cs.arizona.edu>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43C4490B.2010301@cs.arizona.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Jim Davis <jdavis@cs.arizona.edu>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Debugging hung autofs /home?; Jim Davis <jdavis@CS.Arizona.EDU> adds:

jdavis> Jeff Moyer wrote:
>> ==> Regarding [autofs] Debugging hung autofs /home?; Jim Davis <jdavis@cs.arizona.edu> adds:
>> 
>> And you left off the version of autofs you're running. 
>> 
jdavis> Ooops; autofs-4.1.4-5.  'yum update' doesn't seem to find a newer one.

Interesting.  Then I'd suggest you provide the information requested in the
"Filing bug reports" section of my people page:

	http://people.redhat.com/jmoyer/

We previously saw automount processes hung in FUTEX_WAIT when making syslog
calls from a signal handler (a definite no no).  This has been fixed in the
version of autofs that you are running.  So, we'll need more information to
debug this one.

Thanks,

Jeff
