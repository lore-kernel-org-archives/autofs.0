From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Wed, 19 Oct 2005 08:10:57 -0400
Message-ID: <17238.14289.81908.986691@segfault.boston.redhat.com>
References: <200510181321.08443.krienke@uni-koblenz.de>
	<Pine.LNX.4.61.0510180915020.8645@xena.cft.ca.us>
	<200510190822.03871.krienke@uni-koblenz.de>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200510190822.03871.krienke@uni-koblenz.de>
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
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Unable to mount with autofs-4.1.4: aquire_lock: can't lock lock file timed out: /var/lock/autofs; Rainer Krienke <krienke@uni-koblenz.de> adds:

krienke> On Dienstag 18 Oktober 2005 18:44, you wrote:
>> On Tue, 18 Oct 2005, Rainer Krienke wrote: > using the autofs package
>> from suse10.0 (autofs-4.1.4-6.i586.rpm; autofs4 > kernel module,
>> Kernel2.6.13-15) NFS mounts of user directories fail ...  > In auto.home
>> there is this entry for each user like "krienke":
>> >
>> > krienke localhost:/import/user2/krienke
>> >
>> > In auto.vol you find another entry to handle the "user2" key starting
>> at > /import from above (there are more than one nfsservers exporting
>> user1, > user2, ... each with about 2000 users):
>> >
>> > user2 nfssrv2:/export/user2 > Oct 18 12:42:30 rzinstal1
>> automount[16793]: aquire_lock: can't lock lock > file timed out:
>> /var/lock/autofs
>> 
>> Now that's a very neat solution to the problem of too many incoming /
>> outgoing mounts.  But unfortunately you're doing the following sequence:
>> 
>> User refers to /home/krienke Autofs starts to mount
>> /import/homesite/fsys/krienke, stats /import/homesite/fsys Second autofs
>> thread starts to mount homesite:/export/fsys Oops, an autofs thread has
>> the lock, 2nd thread either blocks waiting for the lock, or dies.  (The
>> latter, judging from timestamps.)
>> 
krienke> Thanks for the answer but I am not sure if this is the point,
krienke> simply because this setup works an all other (older) machines eg
krienke> with autofs 4.1.3. So it seems autofs had the capabilities to to
krienke> hierachical mounts already but seems to have lost it in its
krienke> current release.

Well, it worked before, but not by design.  The autofs lock was a "best
effort" thing in 4.1.3 and before.  If we didn't obtain the lock within a
certain amount of time, we would reset the lock, and then take it.

I'll defer to Ian for whether we want to support what you are doing.  In
the past, it's my recollection that he said hierarchical mounts simply
aren't supported.

-Jeff
