From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Cross-compilation still broken on 5.0.3
Date: Thu, 27 Mar 2008 21:26:52 -0400
Message-ID: <x49iqz763kz.fsf@segfault.boston.devel.redhat.com>
References: <1206658652.23286.2.camel@pioneer.netezza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1206658652.23286.2.camel@pioneer.netezza.com> (Paul Smith's
	message of "Thu\, 27 Mar 2008 18\:57\:32 -0400")
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
To: psmith@netezza.com
Cc: autofs@linux.kernel.org

Paul Smith <psmith@netezza.com> writes:

> Hi all;
>
> I still can't cross-compile autofs in the latest build 5.0.3; I'm having
> the same problems as described in this thread, back in Nov 2006.
>
> http://linux.kernel.org/pipermail/autofs/2006-November/003432.html
>
> Is there any interest in getting this working properly and supporting
> it?  It would be really helpful if it could be done.

If you're going to get rid of the run-time check, then we need to add
it as a "with" option or equivalent.  PIE is Position Independent
Execution, and it is recommended that long running processes be built
with said flag.  If you're cross compiling, hopefully you know whether
the platform supports it.

Cheers,

Jeff
