From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Sat, 22 Oct 2005 16:27:39 -0400
Message-ID: <17242.41147.881422.485363@segfault.boston.redhat.com>
References: <29797.1129916484@plxw9904.pdx.intel.com>
	<Pine.LNX.4.63.0510221233290.2552@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510221233290.2552@donald.themaw.net>
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
Cc: autofs mailing list <autofs@linux.kernel.org>, Joseph V Moss <jmoss@ichips.intel.com>

==> Regarding Re: [autofs] Unable to mount with autofs-4.1.4: aquire_lock: can't lock lock file timed out: /var/lock/autofs ; Ian Kent <raven@themaw.net> adds:

raven> On Fri, 21 Oct 2005, Joseph V Moss wrote:
>> > > What, exactly, do you think is broken about the mtab locking?  I
>> remember > spending a few hours with that code, and it looked sane to
>> me.
>> 
>> We used to see the problem of the mtab getting corrupted due to too many
>> filesystems getting mounted within a short time frame.  We started using
>> this patch a while ago and have continued to do so, even though autofs
>> now has locking.  The mtab problems stopped after making this change.
>> 
>> ===============================================================================
>> If there are lots of mounts happening simultaneously (usually due to
>> autofs), the locking of /etc/mtab could fail, in which case, the mount
>> succeeds, but doesn't get properly recorded in the mount table.  This
>> patch greatly increases the number of tries to lock the mtab, before
>> giving up.  The chance that the lock will fail due to contention from
>> lots of other mount processes should be very close to nil.
>> 
>> -- Joseph Moss <jmoss@ichips.intel.com> 13-Nov-2002
>> 
>> --- util-linux-2.11g/mount/fstab.c.waitlock Wed Nov 13 11:45:40 2002 +++
>> util-linux-2.11g/mount/fstab.c Wed Nov 13 12:04:55 2002 @@ -441,8
>> +441,12 @@ alarm(0); /* Limit the number of iterations - maybe there
>> still is some old /etc/mtab~ */ - if (tries++ > 3) { - if (tries > 5) +
>> if (tries++ > 2) { + if ((tries % 20) == 0) + printf(_("Warning: Unable
>> to create link %s" + " after %d tries\n"), + MOUNTED_LOCK, tries); + if
>> (tries > 115) die (EX_FILEIO, _("Cannot create link %s\n" "Perhaps there
>> is a stale lock file?\n"), MOUNTED_LOCK);
>> 
>> 

raven> Yes, I can see how that would help. I think you have identified the
raven> symptom but I may have stumbled onto the cause.

raven> This is the mail I sent to Adrain the other day regarding this
raven> problem.

>> From raven@themaw.net Sat Sep 24 17:35:46 2005
raven> Date: Sat, 24 Sep 2005 17:32:58 +0800 (WST) From: Ian Kent
raven> <raven@themaw.net> To: Adrian Bunk <bunk@stusta.de> Subject: Re:
raven> mtab locking - who wants to talk abou this

raven> On Fri, 23 Sep 2005, Adrian Bunk wrote:

>> On Tue, Sep 20, 2005 at 09:32:28AM +0800, Ian Kent wrote:
>> > 
>> > Hi Adrian,
>> 
>> Hi Ian,
>> 
>> > I'm looking for someone that is involved in maintaining util-linux.
>> > 
>> > I have been looking, on and of, for quite a while now without any >
>> success, at least I haven't found anyone willing to reply. Well that's a
>> > bit of an exaggeration. I sent mail to Andries Bouwer and got no
>> reply.
>> 
>> Andries passed maintainership of util-linux to me last year, so I'm the
>> right contact.

raven> Cool.

raven> I've had trouble with mtab corruption for a long time now.  With
raven> rapid mounting requests from autofs.

raven> I have not been able to see what the problem was with the locking
raven> until I had another look the other day.

raven> I'm not sure if I'm right but hopefully another set of eyes will
raven> sort that out.

raven> What I think is happening is, in mount/fstab.c:lock_mtab when there
raven> is a lock held and another process attempts to wait for it, it
raven> doesn't. The tries are rapidly exhausted resulting in a lock
raven> failure.

raven> I believe the reason is because the code assumes that, when
raven> attempting to wait for the lock file a flock is held on it by the
raven> owner, which is not the case. The culprit is the position of the
raven> close, which releases any locks held by the process when called.

raven> I made a little patch but haven't had time to test it yet. I'll have
raven> to rip out the locking I introduced to autofs to do that so it will
raven> likely be little while before I can. The close at the exit is
raven> probably not needed as the flock will also be released at process
raven> termination. I included it for completeness. I had some difficulty
raven> patching different versions of util-linux so I'm not sure it will
raven> apply cleanly to your tree. The patch is straight forward though.

raven> Please let me know what you think.

Funny, I sent a similar patch along several months ago!  Or, at least I
described the problem.  At that time, I thought it would only result in us
failing a little too quickly.

I'm surprised the issue hasn't been addressed yet.

-Jeff
