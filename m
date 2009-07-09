From: Steve Linn <steve.linn@gmail.com>
Subject: Re: mount: mount point /home/user does not exist
Date: Thu, 9 Jul 2009 15:03:16 -0700
Message-ID: <3ddb09290907091503k6ad1a31av1eba12f6e2721763@mail.gmail.com>
References: <4A4D3408.40103@idilia.com> <4A4D8B40.9020402@themaw.net>
	<4A52038C.9090008@idilia.com> <4A52A8E1.7030307@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:in-reply-to:references
	:date:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=Zb1dLY0/LFyzEDGMVKR/j8qDQBJIesiVPMSfsfiaOJk=;
	b=mD24ZptHEFckLWLbyx+8TV6zAF08G4FOp6KVfHZvhJ/yCWHIfx3b6RbGGzDsfml5IL
	ZIPspNObnfysdDbPa6q1luJmaY0KYSTp27ly/Vp3YOVRc7JGUa/GJomshO5GdJUzaeW3
	oqQEEak4u5EruJo5yddIt5x0RU94c1LtLUxvA=
In-Reply-To: <4A52A8E1.7030307@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

We have the same problem with our file servers when they become
overloaded or get rebooted.  There seems to be at least two issues that
need to be  dealt with. The first issue seems to be the mount/mount.nfs
does not seem to work as advertised. Here is an example of a mount
failing within 3 seconds:

# time mount lidx:/export /mnt
mount.nfs: mount to NFS server 'lidx:/export' failed: System Error: No
route to host
0.000u 0.004s 0:03.00 0.0%      0+0k 0+0io 0pf+0w

man nfs says:

 retry=n
 The  number  of  minutes  that  the mount(8) command retries an NFS
 mount operation in the foreground or background before  giving  up.
 If  this  option is not specified, the default value for foreground
 mounts is 2 minutes, and the default value for background mounts is
 10000 minutes (80 minutes shy of one week)...

3 seconds instead of 2 minutes if the host is on the same network.


The second issue is that -hosts mount does not seem to want to wait
very long either:

Here is an example of /net mount.  The -hosts option
seems to wait only 3 seconds then caches the negative
entry.

# grep ^/net /etc/auto.master
/net -hosts

Here it is taking 3 seconds:
# time ls /net/google.com
ls: /net/google.com: No such file or directory
0.000u 0.000s 0:03.03 0.0%      0+0k 24+0io 0pf+0w


# time ls /net/google.com
ls: /net/google.com: No such file or directory
0.000u 0.004s 0:00.00 0.0%      0+0k 0+0io 0pf+0w

# time showmount -e google.com
portmap getport: RPC: Timed out
0.000u 0.000s 3:12.01 0.0%      0+0k 40+0io 0pf+0w

I found this to be fixable by the following patch which changes the
UDP timeout from 3 seconds to 30 and TCP timeout from 5 seconds to
50. I am not sure what a good value would be but our file servers can
take a couple minutes to reboot.


diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index 87fd568..d3c1d9f 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -39,8 +39,8 @@
 #define RPC_CLOSE_ACTIVE       RPC_CLOSE_DEFAULT
 #define RPC_CLOSE_NOLINGER     0x0001

-#define PMAP_TOUT_UDP  3
-#define PMAP_TOUT_TCP  5
+#define PMAP_TOUT_UDP  30
+#define PMAP_TOUT_TCP  50


Program mounts seem to wait long enough. You can write something like
to auto.net script which could be modified to wait for the showmount
to get something back or retry on failures so that if a file server is
down that it might give automount something to mount.  I have also
found that /usr/sbin/showmount which can be used by /etc/auto.net has
changed its behavior at some point.

It use to be 3 minutes+ for it to timeout:

% time showmount -e 10.1.1.1
portmap getport: RPC: Timed out
0.000u 0.004s 3:12.00 0.0%      0+0k 40+0io 0pf+0w
% rpm -qf /usr/sbin/showmount
nfs-client-1.1.0-11


Now a newer version seems to give up in 13 seconds for some
reason...

% time showmount -e 10.1.1.1
showmount: RPC: Timed out
0.000u 0.004s 0:13.00 0.0%      0+0k 0+0io 0pf+0w
% rpm -qf /usr/sbin/showmount
nfs-client-1.1.3-14.1

So to summarize, mount failures due to timeouts seem do have at least
5 different values in my environment.  The range seems to be between 3
seconds to greater 3 minutes depending on the type of map and the
binaries used.

The following is automount entry has a time out which is determined by
/usr/sbin/automount and seems to be 3 seconds if the host is
unreachable:

/nethosts -hosts

The following entry /etc/auto.net will fail if showmount or kshowmount
times out.  This seems to vary between 3+ minutes to 13 seconds
depending on the version of showmount:

/netauto                        /etc/auto.net

A plain file timeout seems to be controlled by the version of
mount/mount.nfs.  My version of mount.nfs seems to wait 31 seconds
before giving up if the host is unreachable on a remote network, but
if the machine is on the same network mount.nfs times out after 3
seconds with a "No route to host" message.

# mount.nfs 10.1.1.1:/export /mnt
mount.nfs: mount to NFS server '10.1.1.1:/export' failed: timed out, giving up
0.00user 0.00system 0:31.02elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+8outputs (0major+197minor)pagefaults 0swaps

# mount.nfs 192.168.1.222:/export /mnt
mount.nfs: mount to NFS server '192.168.1.222:/export' failed: System
Error: No route to host
0.00user 0.00system 0:03.00elapsed 0%CPU (0avgtext+0avgdata 0maxresid

Here is some output from showing 4 of the results:

 % time ls /nethosts/10.1.1.1
ls: cannot access /nethosts/10.1.1.1: No such file or directory
0.000u 0.000s 0:03.00 0.0%      0+0k 0+0io 0pf+0w
 % time ls /netauto/10.1.1.1
ls: cannot access /netauto/10.1.1.1: No such file or directory
0.000u 0.000s 0:13.01 0.0%      0+0k 0+0io 0pf+0w
 % time ls /netfile/10.1.1.1
ls: cannot open directory /netfile/10.1.1.1: No such file or directory
0.000u 0.004s 0:31.03 0.0%      0+0k 0+0io 0pf+0w

And the most patient version is a machine with an earlier version of
showmount.

% time ls /netauto/10.1.1.1
ls: /netauto/10.1.1.1: No such file or directory
0.004u 0.000s 3:12.04 0.0%      0+0k 0+0io 0pf+0w


steve

On Mon, Jul 6, 2009 at 6:46 PM, Ian Kent<raven@themaw.net> wrote:
> Filipe Brandenburger wrote:
>> Hi Ian,
>>
>> Ian Kent wrote:
>>> Filipe Brandenburger wrote:
>>>> Recently I had failures in some hosts when mounting home directories, in
>>>> some cases more than one host at a time.
>>>
>>> This does sound a bit like a known problem.
>>> A bunch of patches have gone into RHEL-4 U8 which resolved almost all
>>> reported problems. You will need to log a bug or update to U8 to check.
>>
>> Thanks for your answer.
>>
>> Would upgrading autofs from 4.1.3-234 to 4.1.3-238 be enough, or do I
>> need to upgrade to the latest kernel as well?
>
> Above I was actually referring to the kernel, although I didn't make
> that clear. The RHEL-4.8 kernel update fixed almost all reported kernel
> related problems (there were a couple).
>
>>
>> Would using the "autofs5" package in RHEL4 be better in this sense? Do
>> you know if that package is as stable as autofs 4 is in RHEL4?
>
> That a trick question, right?
> As the maintainer I will always recommend version 5.
>
> The RHEL-4 autofs5 package is essentially the same as the RHEL-5 autofs
> package except that it's a release behind, as updates are back ported.
> The back porting of RHEL-5 updates will be somewhat more selective from
> RHEL-4.9 onward.
>
> Ian
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
