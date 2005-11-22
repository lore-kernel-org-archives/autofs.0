From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automount never umount
Date: Tue, 22 Nov 2005 11:50:00 -0500
Message-ID: <17283.19512.49399.338448@segfault.boston.redhat.com>
References: <4381E865.4070908@bppiac.hu>
	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>
	<4382E835.3020904@bppiac.hu>
	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>
	<438344F7.8020503@bppiac.hu>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <438344F7.8020503@bppiac.hu>
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
To: Farkas Levente <lfarkas@bppiac.hu>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] automount never umount; Farkas Levente <lfarkas@bppiac.hu> adds:

lfarkas> Ian Kent wrote:
>> That wasn't what I had in mind.
>> 
>> I was thinking more along the lines of the definition of what constitues
>> "use". For example any access, such as a directory listing, will update
>> the "last used" value whereas if I change the definition of "last used"
>> to "currently in use" then to be busy there would have to be an open
>> file or a process working directory set. This may solve the GUI scanning
>> problem we see but wouldn't solve immediate remounting that occurs due
>> to the scanning as well.

lfarkas> that would be useful and may be solve our problem. without it the
lfarkas> current implementation is not usable to umount. think about just
lfarkas> the daily process like slocate database update, tripwire and may
lfarkas> be others.

Things that run infrequently are not at fault, here.  I'd really like to
know precisely what is going on, in your case.

Ian, I think it would be easy enough to instrument the autofs4 module.
Simple things, like figuring out which process is triggerring the lookup.
We can either log it, or just keep a ring buffer.

I don't think I'll have time to put together any code this week, but may
next week.

-Jeff
