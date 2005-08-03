From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Here's a new really odd auto.net bug
Date: Wed, 3 Aug 2005 09:24:14 -0400
Message-ID: <17136.50558.41690.889861@segfault.boston.redhat.com>
References: <200508022052.j72Kqs8F015586@cornholio.qualcomm.com>
	<Pine.LNX.4.63.0508032052460.19691@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0508032052460.19691@donald.themaw.net>
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
Cc: autofs@linux.kernel.org, Michael Marion <mmarion@qualcomm.com>

==> Regarding Re: [autofs] Here's a new really odd auto.net bug ; Ian Kent <raven@themaw.net> adds:

raven> On Tue, 2 Aug 2005, Michael Marion wrote:
>> Had a similar problem in the past that turned out to be my fault, wrong
>> /etc/auto.net script in place.  Today, I'm seeing similar mount issue, but
>> I've made sure the right script is in place.
>> 
>> If a host has >1 export, it works sort of as expected:
>> kydland mmarion {728}$ /etc/auto.net cornholio
>> -fstype=nfs,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,nodev,nosuid
>> \
>> /local/mnt cornholio:/local/mnt \
>> /tftpboot cornholio:/tftpboot
>> kydland mmarion {729}$ ls /net/cornholio
>> local  tftpboot
>> kydland mmarion {730}$ mount | grep cornholio
>> cornholio:/local/mnt on /net/cornholio/local/mnt type nfs
>> (rw,nosuid,nodev,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,addr=129.46.234.38)
>> 
>> but /tftpboot isn't there and debug/verbose output in syslog shows:
>> Aug  2 13:43:01 kydland automount[32588]: attempting to mount entry
>> /net/cornholio
>> Aug  2 13:43:01 kydland kernel: nfs_get_root: getattr error = 116
>> Aug  2 13:43:01 kydland kernel: nfs_read_super: get root inode failed
>> Aug  2 13:43:01 kydland kernel: nfs_get_root: getattr error = 116
>> Aug  2 13:43:01 kydland kernel: nfs_read_super: get root inode failed
>> Aug  2 13:43:01 kydland automount[581]: >> mount: wrong fs type, bad option,
>> bad superblock on cornholio:/tftpboot,
>> Aug  2 13:43:01 kydland automount[581]: >>        or too many mounted file
>> systems
>> Aug  2 13:43:01 kydland automount[581]: mount(nfs): nfs: mount failure
>> cornholio:/tftpboot on /net/cornholio/tftpboot
>> 
>> trying to ls that tftpboot path gives more logs:
>> Aug  2 13:43:54 kydland automount[32588]: attempting to mount entry
>> /net/cornholio/tftpboot
>> Aug  2 13:43:54 kydland automount[631]: >> showmount: can't get address for
>> cornholio/tftpboot
>> Aug  2 13:43:54 kydland automount[631]: lookup(program): lookup for
>> cornholio/tftpboot failed
raven>   ^^^^^^^^^^^^^^^^^^
raven> This looks a bit like the bad lookup bug.

raven> The patch below is for 2.6 so you may need to apply it by had for a 2.4 
raven> kernel.

raven> Give it a try.

I thought we would only hit that bug if ghosting was enabled?

-Jeff
