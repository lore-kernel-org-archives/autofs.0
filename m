From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Fri, 21 Oct 2005 12:41:44 -0400
Message-ID: <17241.6728.530111.716756@segfault.boston.redhat.com>
References: <200510181321.08443.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510192336180.2071@donald.themaw.net>
	<200510210907.20809.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510212347440.2069@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510212347440.2069@donald.themaw.net>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [autofs] Unable to mount with autofs-4.1.4: aquire_lock: can't lock lock file timed out: /var/lock/autofs; Ian Kent <raven@themaw.net> adds:

raven> On Fri, 21 Oct 2005, Rainer Krienke wrote:
>> On Mittwoch 19 Oktober 2005 17:55, Ian Kent wrote: > As Jeff has said
>> this sort of nesting of mounts is, in general, not > supported by autofs
>> and it worked previously because the locking was less > broken in 4.1.3
>> than in 4.1.4 (yes its still broken in 4.1.4).
>> >
>> > Can this case be done safely?
>> >
>> > I'm not entirely sure of the answer to this but I've never liked using
>> > locking in autofs. I introduced it only to prevent mtab corruption
>> during > mount (correct me if you have a different recollection
>> Jeff). It happens > during rapid mount activity such as when there as a
>> largish number of > entries in the master map (of the order of 50 or
>> more).
>> >
>> > The mtab locking should be done in mount which narrows the scope of
>> the > lock enough to allow this case to function as requested.
>> >
>> 
>> For me it would be important to learn if this feature will be possible
>> in the future or if it is decided that for whatever reason it will not
>> be. The former case would be the best thing for me because I would not
>> have to find a new solution for mounting home directories and I guess
>> other people with a large user base would also welcome it. In the latter
>> case I have to think about a alternative way to go for the future. At
>> the moment my solution is to use an older version of autofs for suse10.0
>> installations since this older autofs version simply works for me but
>> this is of course not an ideal solution.
>> 
>> Any comments?

raven> Yes.

raven> I was wondering what can be done about this also.

raven> All that I can offer is to make a patch to remove the locking from
raven> autofs and another for mount (util-linux) to hopefully fix the mtab
raven> locking. If you are prepared to carry these non-standard patches we
raven> can see how it goes. Somewhat more testing would be required before
raven> removing the locking from the distribution.

What, exactly, do you think is broken about the mtab locking?  I remember
spending a few hours with that code, and it looked sane to me.

-Jeff
