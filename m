From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Fri, 21 Oct 2005 12:46:17 -0400
Message-ID: <17241.7001.581589.222635@segfault.boston.redhat.com>
References: <200510181321.08443.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510192336180.2071@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510192336180.2071@donald.themaw.net>
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
Cc: autofs mailing list <autofs@linux.kernel.org>, Adrian Bunk <bunk@stusta.de>

==> Regarding Re: [autofs] Unable to mount with autofs-4.1.4: aquire_lock: can't lock lock file timed out: /var/lock/autofs; Ian Kent <raven@themaw.net> adds:

raven> On Tue, 18 Oct 2005, Rainer Krienke wrote:
>> Hello,
>> 
>> using the autofs package from suse10.0 (autofs-4.1.4-6.i586.rpm; autofs4
>> kernel module, Kernel2.6.13-15) NFS mounts of user directories fail when
>> using indirect mounts. The problem can be reproduced in a certrain setup
>> describes below. Because of this, the description is a bit lenghty.

raven> It's good to see that SuSE is attempting to keep up with the autofs
raven> versions. If you have the oppertunity, Rainer, please thank them for
raven> me.

>> The maps for automount are taken from NIS. To mount a users directory
>> via NFS eg. /home/krienke on a client entries from the NIS-maps
>> auto.home and auto.vol are used.  auto.master is configured like this:
>> 
>> /home auto.home -intr /import auto.vol -intr
>> 
>> In auto.home there is this entry for each user like "krienke":
>> 
>> krienke localhost:/import/user2/krienke
>> 
>> In auto.vol you find another entry to handle the "user2" key starting at
>> /import from above (there are more than one nfsservers exporting user1,
>> user2, ... each with about 2000 users):
>> 
>> user2 nfssrv2:/export/user2
>> 
>> nfssrv2 ist one of our NFS servers for home directories. So basically we
>> nfs mount a volume containing all the users on this server on
>> /import/user2 on the client and then we mount /home/krienke on
>> /import/user2/krienke on the client (the advantage of this indirect 2
>> layer mount is that we avoid problems with too many mounts for users on
>> one client since bind mounts are used for the users home). This mount
>> was (up to 9.3) automatically mounted as a bind mount by automount. Up
>> to suse9.3 (using autofs4-4.1.3) this worked without problems and if I
>> replace the suse10 autofs rpm by the suse9.3 autofs4 rpm it again does
>> work. I can also manually issue the mount command logged by automunt
>> below (mount -t nfs -s -o intr nfssrv2:/export/user2 /import/user2) and
>> it works without any problems.

raven> As Jeff has said this sort of nesting of mounts is, in general, not
raven> supported by autofs and it worked previously because the locking was
raven> less broken in 4.1.3 than in 4.1.4 (yes its still broken in 4.1.4).

raven> Can this case be done safely?

raven> I'm not entirely sure of the answer to this but I've never liked
raven> using locking in autofs. I introduced it only to prevent mtab
raven> corruption during mount (correct me if you have a different
raven> recollection Jeff). It happens during rapid mount activity such as
raven> when there as a largish number of entries in the master map (of the
raven> order of 50 or more).

I'm not sure why it was introduced.  When looking at the code, the only
thing I could deduce was that we do locking in autofs in order to not issue
a ton of mounts all at once.  Because the mount command has a timeout for
each mount, and because each mount will take some amount of time to
complete, there exists a possibility of getting failed mounts due to a
timeout or lack of resources.  That was my only guess.

I have seen mtab corruption in the field, but typically only in the
presence of mvfs (the clearcase file system).

-Jeff
