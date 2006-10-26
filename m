From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: --timeout doesn't do anything on fedora3 or 5
Date: Thu, 26 Oct 2006 10:47:13 -0400
Message-ID: <x49bqnzyw0e.fsf@segfault.boston.devel.redhat.com>
References: <000301c6f89d$ce6afdb0$9600a8c0@home>
	<1161832308.3789.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1161832308.3789.2.camel@localhost> (Ian Kent's message of "Thu,
	26 Oct 2006 11:11:48 +0800")
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
Cc: autofs@linux.kernel.org, marty <leisner@rochester.rr.com>

==> Regarding Re: [autofs] --timeout doesn't do anything on fedora3 or 5; Ian Kent <raven@themaw.net> adds:

raven> On Wed, 2006-10-25 at 21:26 -0400, marty wrote:
>> On both fedora3 and fedora5, I can't get the --timeout option on autofs
>> to do anything useful.
>> 
>> I saw a bug report on fedora3, but getting a newer release doesn't seem
>> to make a difference.
>> http://linux.derkeiler.com/Mailing-Lists/Fedora/2005-02/0488.html
>> 
>> Is there anyway to "monitor" the timeout interactively from user space
>> (instead of "waiting" to see if it happens, watch to see its counting
>> down?)

raven> To start with more information is needed.  See
raven> http://people.redhat.com/jmoyer and provide the information
raven> described.

raven> Enabling debug as described in Jeffs page will log the startup and
raven> specify the timeout being used and log entries every time there is a
raven> check.

It's worth noting that most times when users report that mounts aren't
timing out, the problem is another app periodically accessing the mounted
directory.

-Jeff
