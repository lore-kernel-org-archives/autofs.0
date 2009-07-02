From: Filipe Brandenburger <filipe.brandenburger@idilia.com>
Subject: mount: mount point /home/user does not exist
Date: Thu, 02 Jul 2009 17:36:44 -0400
Message-ID: <4A4D286C.3080401@idilia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hello,

I am using autofs-4.1.3-234 on a RHEL 4 machine, using kernel 
2.6.9-78.0.1.ELsmp, getting automount maps from LDAP.

Recently I had failures in some hosts when mounting home directories, in 
some cases more than one host at a time.

I found this on the NFS client's log:

> Jun 30 16:51:21 clnt automount[9458]: >> mount: mount point /home/user does not exist
> Jun 30 16:51:21 clnt automount[9458]: mount(nfs): nfs: mount failure srvr:/export/home/user on /home/user
> Jun 30 16:51:21 clnt automount[9458]: failed to mount /home/user

But on the NFS server, this is all I see:

> Jun 30 16:51:21 srvr rpc.mountd: authenticated mount request from clnt.example.com:731 for /export/home/user (/export/home) 

This is the same log I have when the mount succeeds.

I believe the NFS server might have been overloaded at that time, and 
for that reason the mount request might have taken longer than expected.

 From what I've seen, I believe the ">> mount" message is the message 
returned by the /bin/mount command spawned from automount, and it means 
when it tried to mount the directory, the local /home/user directory was 
no longer there.

I also believe this might have happened because it was previously 
mounted but not used for the timeout period (I am using 5 minutes as 
timeout), so the last mount was expired (and the directory removed) just 
before this /bin/mount process was able to run.

I tried to google for it, but all I found was this message:
http://lkml.indiana.edu/hypermail/linux/kernel/9910.3/1105.html

It looks like the problem I am having, however it is very old, from 
about 10 years ago...

Is this still a known issue in autofs? Is there a patch for it?

I also know that autofs 5 is in many ways different than autofs 4 (I run 
it in my RHEL 5 machines). Now (since RHEL 4.7) I believe autofs 5 is 
available for RHEL 4. Is it possible that upgrading to autofs 5 might 
fix this issue?

Any help trying to figure out what is going on would be very 
appreciated. Also, if you need more logs or for me to execute some 
commands or tests I can do it for sure. I was thinking of a way to 
trying to reproduce this problem (maybe replace /bin/mount with a script 
that does "sleep N" before calling the actual mount) but could not come 
up with something good enough to validate my hypothesis, so I decided to 
ask the list first.

Thanks!
Filipe
