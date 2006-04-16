From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: kernel panic when accessing local filesystems on NFS
	server
Date: Sun, 16 Apr 2006 19:29:46 +0200
Message-ID: <44427F0A.5060306@inria.fr>
References: <443CF70F.90001@inria.fr>
	<x49vete1wr5.fsf@segfault.boston.redhat.com>
	<443E41B1.50804@inria.fr>
	<Pine.LNX.4.63.0604131540270.6043@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0604131540270.6043@simba.math.ucla.edu>
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
Cc: autofs@linux.kernel.org

Jim Carter wrote:
> On Thu, 13 Apr 2006, Guillaume Rousse wrote:
>> However, it seems automount is still taking priority on direct access if
>> a mount point is activated.
>>
>> If my /etc/fstab says:
>> /dev/hda1 /home
>>
>> and /etc/init.d/autofs status says:
>> /usr/sbin/automount /home/graves ldap
>> ou=auto.home.graves,ou=autofs,dc=village,dc=inria,dc=fr
>>
>> Any attempt to access /home/graves on graves host will mount it through
>> autofs, and access it through NFS, masking local filesystem and probably
>> wasting resources.
> 
> I'm not 100% sure of your configuration; however, my experience is that if 
> I use autofs to access a filesystem on the same host, it will do a bind 
> mount rather than a NFS mount, and the bind mount has (I think) totally 
> zero cost once made.
Right, it was a bind mount, not a NFS mount.

> As an example, here's what we do:
> 
> On host1, the homedir of userA is /h3/userA (not really capitalized).
> On host2, the homedir of userB is /h4/userB.
> 
> On both hosts we do: automount /net file /etc/auto.net
> /etc/auto.net says:
> * -other,options,fstype=autofs,-DSERVER=&  file:/etc/auto.net.generic
> /etc/auto.net.generic says:
> * ${SERVER}:/&
> 
> In other words, if you refer to /net/$anyhost/$anything, the leader process 
> will spawn a submount process specific to $anyhost which will attempt to 
> mount /$anything off of $anyhost.  ($anyhost only delivers directories 
> (filesystems) in /etc/exports, and off-site traffic is blocked at the 
> firewall, but the mount will be attempted even so.)
> 
> The password map says that the homedir of userA is /net/host1/h3/userA,
> and ~userB is /net/host2/h4/userB.  
> 
> Executing on host1, you use /net/host2/h4/userB and the automount process
> does "mount -t nfs host2:/h4 /net/host2/h4".  On the other hand, if you
> refer to /net/host1/h3/userA it is smart enough to do "mount --bind /h3 
> /net/host1/h3", and /proc/mounts says:
> /dev/sdb4 /h3 ext3 rw 0 0
> /dev/sdb4 /net/sunset/h3 ext3 rw 0 0
> 
> We have the actual filesystems (here, /h3) separated from the automounted 
> path names (here, /net/host1/h3).  If we tried to have both "real" 
> directories and automount points in the same containing directory, I doubt
> it would work; at best it would be a can of worms.
Yes, that's my point :)
