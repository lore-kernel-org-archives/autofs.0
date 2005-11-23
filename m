From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Tue, 22 Nov 2005 19:21:26 -0500
Message-ID: <17283.46598.750040.812177@segfault.boston.redhat.com>
References: <1132670358.4039.37.camel@brilong-lnx>
	<17283.15738.978933.591442@segfault.boston.redhat.com>
	<1132676478.4039.57.camel@brilong-lnx>
	<Pine.LNX.4.63.0511230739130.2069@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511230739130.2069@donald.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds; Ian Kent <raven@themaw.net> adds:

raven> On Tue, 22 Nov 2005, Brian Long wrote:
>> On Tue, 2005-11-22 at 10:47 -0500, Jeff Moyer wrote:
>> 
>> > This is likely a side-effect of the cache expiry code.  Try this patch
>> on > for size.
>> 
>> I took the SRPM from autofs-4.1.3-154 (RHEL 3 U6) and applied your
>> patch.  I installed this RPM on a test host, rebooted the host and ls
>> /users/nosuchuser came back immediately.
>> 
>> Is this patch something that would be accepted upstream Ian?  Jeff, any
>> chance this patch can be put into RHEL 3 U7 and RHEL 4 U3?  I know it's
>> last-minute, but I really need this fixed (and supported by Red Hat).

raven> It's never a problem including this type of fix once we've decided
raven> the root cause which is happening now. And then this also needs to
raven> be done for the LDAP lookup module and probably best to do same for
raven> file lookup module and tested .....

raven> The real problem for me is time and keeping track of the bug fixes
raven> for the different autofs versions and which patches have been
raven> applied while there in my queue for the next version.

And this is important.  Perhaps we should limit the bug reports here to
those reported on the upstream variant of autofs, currently 4.1.4 (and
potentially with some patches from your ftp site).

I would be completely okay with that.

-Jeff
