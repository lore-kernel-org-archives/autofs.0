From: Jeffery Malloch <jmall@lsil.com>
Subject: RE: auotfs/NFS Issue with WAN mounted filesystem?
Date: Wed, 23 Feb 2005 12:36:03 -0500
Message-ID: <10EE351D89AE1F488B426AC91EF6EDAB012813AC@server-1.ad.lsil.com>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'jmoyer@redhat.com'" <jmoyer@redhat.com>, Ian Kent <raven@themaw.net>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>, "'ges-field-east@lsil.com'" <ges-field-east@lsil.com>, Kevork Kechichian <kkechich@lsil.com>, Michael Gallant <mgallant@lsil.com>

-----Original Message-----
From: Jeff Moyer [mailto:jmoyer@redhat.com] 
Sent: Wednesday, February 23, 2005 11:30 AM
To: Ian Kent
Cc: Jeffery Malloch; 'autofs@linux.kernel.org'; Kevork Kechichian; Michael
Gallant
Subject: RE: [autofs] auotfs/NFS Issue with WAN mounted filesystem?

==> Regarding RE: [autofs] auotfs/NFS Issue with WAN mounted filesystem?;
Ian Kent <raven@themaw.net> adds:

raven> On Tue, 22 Feb 2005, Jeffery Malloch wrote:
>> Hi Ian,
>> 
>> Sorry it's been such a long time but I thought I had gotten my issue
>> down to an issue with IBM Clearcase and their "mvfs" implementation.
>> But as it happens, I believe there still to be issues with autofs in
>> RedHat WS3 U3.  I am currently using autofs-4.1.3-47.  I have been
>> running many automounts on the linux systems in debug mode for some
>> time.  But here's what I have to give you for now:
>> 
>> Feb 21 23:44:33 lserver-11 automount[15042]: rm_unwanted:
>> /lsi/vp/bed_shared Feb 21 23:44:33 lserver-11 automount[15042]: expired
>> /lsi/vp/bed_shared Feb 21 23:44:38 lserver-11 automount[1700]:
>> attempting to mount entry /lsi/vp/bed_shared Feb 22 00:16:51 lserver-11
>> automount[19628]: BUG: /lsi/vp/bed_shared already mounted
>> 

raven> This is usually due to mtab corruption caused by broken file locking
raven> in mount and autofs.

raven> What is the state of mtab when this happens.

Actually, please include the state of /proc/mounts, too, so we can verify
whether there is corruption.  One without the other is pretty much useless.

-Jeff

----------------------------------------------------------------------------

Hi Guys,

I have a machine that went into this state again...  Here's a list of what I
see:

- I can look at the /proc/mounts and /etc/mtab without issue so they don't
appear corrupted in any way
- the automounted filesystems that are hanging appear in the /etc/mtab file
but not in the /proc/mounts
- all automount maps now have 3 processes associated with them
- I can identify that at the same moment a new automount process was being
started an unmount was running like this:

root      3773  1584  0 10:59 ?        00:00:00 /usr/sbin/automount
--timeout=60 /lsi/soft yp auto_lsi_soft rw,intr,noatime
root      3774  1584  0 10:59 ?        00:00:00 /usr/sbin/automount
--timeout=60 /lsi/soft yp auto_lsi_soft rw,intr,noatime
root      3775  3774  0 10:59 ?        00:00:00 /bin/umount //lsi/soft/emt
root      3780  1717  0 10:59 ?        00:00:00 /usr/sbin/automount
--timeout=60 /tools yp auto_tools rw,soft,intr,noatime
root      3781  1717  0 10:59 ?        00:00:00 /usr/sbin/automount
--timeout=60 /tools yp auto_tools rw,soft,intr,noatime
root      3785  3781  0 10:59 ?        00:00:00 /bin/umount //tools/emt

The new automount maps always appear to start before the umount command in
pairs.

- the load on the machine is growing but all usage is in CPU I/O wait

If you would like more data, I will leave this system in this state for
today.  Your input is greatly appreciated.

Thanks,

Jeff
