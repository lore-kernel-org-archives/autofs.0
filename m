From: matt <matt@angalon.org>
Subject: Understanding direct mounts & ghosting
Date: Wed, 10 Mar 2004 22:44:45 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <404FEEBD.70507@angalon.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

I am attempting to use direct mounts with autofs4 and either I'm doing 
something wrong or I'm expecting the wrong behaviour.  Here's my 
situation.  I installed SuSE 9.0 and then downloaded and built 
autofs-4.1.0 and autofs4-2.4 kernel module.  I installed both and added 
the alias line in modules.conf, and when I do 'lsmod' I see 'autofs4' as 
the autofs module so I think I've got the kernel part right.

The reason I am trying to get direct mounts to work is so that I can 
automount /usr/local from my fileserver, however if I put the line:
     /usr/local    server:/usr/local
into my auto.direct file, then all of /usr goes away (except 
/usr/local).  So for testing purposed I changed things to use /mnt. Now 
my auto.master includes the line:
     /-    auto.direct
and the auto.direct file contains:
     /mnt/local      voorg:/usr/local

Once I start the automounter I see the following as part of the output 
of the mount command:

automount(pid27283) on /mnt type autofs 
(rw,fd=5,pgrp=27279,minproto=2,maxproto=4)

and my test directory (/mnt/local.orig) is no longer visible.  If I then 
cd to /mnt/local the mount command shows:

automount(pid27283) on /mnt type autofs 
(rw,fd=5,pgrp=27279,minproto=2,maxproto=4)
voorg:/usr/local on /mnt/local type nfs (rw,addr=192.168.222.5)

So the automount does appear to be working; but not as I expect a direct 
mount to work based on my experience with Solaris (and HPUX).  My 
expecataion is that I should see /mnt/local as the automount point (i.e. 
"automount(pid27238) on /mnt/local type autofs ...") instead of /mnt. 
Is this the expected behavior or am I missing something?

With regards to ghosting, I have another map (auto.nfs) that's mounted 
on /nfs and, as I understand ghosting, I should be able to do:
     ls /nfs
and see a list of mountable directories (i.e. the contents of the 
auto.nfs map) as a result.  I don't.  All I see is . and .. (presuming 
of coure that I haven't cd'd to any of the mount-points).

Anything you can offer to help me understand what's happening would be 
greatly appreciated.  And if I can provide additional info about my 
setup, please let me know.

Thanks much,
Matt
