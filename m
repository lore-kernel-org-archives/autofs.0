From: Michael Marion <mmarion@qualcomm.com>
Subject: Re: Here's a new really odd auto.net bug
Date: Thu, 4 Aug 2005 17:48:12 -0700 (PDT)
Message-ID: <200508050048.j750mC8F007763@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: INLINE
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On  3 Aug, Ian Kent wrote:

>> Aug  2 13:43:54 kydland automount[631]: lookup(program): lookup for
>> cornholio/tftpboot failed
>   ^^^^^^^^^^^^^^^^^^
> This looks a bit like the bad lookup bug.
> 
> The patch below is for 2.6 so you may need to apply it by had for a 2.4 
> kernel.
> 
> Give it a try.

Didn't seem to fix at least the one problem:
rs-workstation mmarion {527}$ ls /net/tau
licenses  lost+found  mlb  usr2  workspace
rs-workstation mmarion {528}$ /etc/auto.net tau
-fstype=nfs,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,nodev,nosuid
\
        /local/mnt tau:/local/mnt
rs-workstation mmarion {530}$ mount | grep tau
tau:/local/mnt on /net/tau type nfs
(rw,nosuid,nodev,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,addr=129.46.234.39)

Logs are same:
Aug  4 17:31:58 rs-workstation automount[9487]: mount(nfs): host /local/mnt:
lookup failure
Aug  4 17:31:58 rs-workstation automount[9487]: >> nfs server reported tcp not
available, falling back to udp
Aug  4 17:31:58 rs-workstation automount[9487]: >> Using NFS over UDP can
cause data corruption.
Aug  4 17:31:58 rs-workstation automount[9487]: >> Please refer to the
WARNINGS section of the nfs(5) manual page.

2.6.8-24.16-smp amd64 sles9-sp2 system btw.. but I've seen the problem on 
sles9 and -sp1 hosts too.  

This is the _really_ confusing part:
cornholio ~ {605}$ /etc/auto.net tau
-fstype=nfs,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,nodev,nosuid
\
	/local/mnt tau:/local/mnt
cornholio ~ {606}$ ls /net/tau
local
cornholio ~ {607}$ mount | grep tau
tau:/local/mnt on /net/tau/local/mnt type nfs
(rw,nosuid,nodev,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,addr=129.46.234.39)

Suse 9.2 host, but exact same kernel as the sles9 and sp1 hosts (used a
src.rpm from suse 9.2 for autofs4 patches that sles9 didn't have) and exact
same automount daemon.. only other difference is this is a 32bit host vs the
rest are 64bit.

Trying some more things...
-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Frasier: "Well I had to, what with you underneath the covers with a flashlight 
looking at the National Geographics." 
Niles: "I was looking at the maps!"
Frasier: "THAT'S what makes it so scary!" -- Frasier
