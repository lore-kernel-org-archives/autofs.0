From: Eric Werme USG <werme@alpha.zk3.dec.com>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 14:58:47 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200401131958.i0DJwlV0001078000@anw.zk3.dec.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: alexander.marx@hp.com, hpa@zytor.com

hpa@zytor.com wrote:

MARX,ALEXANDER (HP-Germany,ex1) wrote:
> 
>> In some scenarios (e.g. HA), the nfs server could switch from local to
>> remote, therefore having local binds is not a desirable scenario, there
>> should always be nfs mounts.
>
>How would you expect this to work?  The local bind only happens when 
>local and destination address are the same, therefore keeping anything 
>from going across the network no matter how you slice it.
>
>Changing the DNS name of the NFS server has no effect, since once the 
>mount has happened the name was already resolved, and it can't be 
>redirected.
>
>Changing the IP address runs into the problem that local == remote.

The stop-gap cluster system in Tru64 Unix did this.  Typically pairs
of servers had system names (service names in the jargon) and bound
the IP address to a NIC on one server.  When the service was relocated
manually or on a crash, the IP address was moved to a NIC on the other
server.  Disks were on a shared SCSI bus, and the file system would also
go through a umount/mount cycle.  Note that no changes to DNS' database
are necessary, just an update to clients' arp tables.

For example, we have systems "mailhub1" and "mailhub2".  The service name
"mailhub" is where Email here winds up.  I send mail via SMTP to mailhub, and
read it via NFS from mailhub.  Normally I don't care which of mailhub1
and mailhub2 handles it.  For the most part they're just servers, but
sometimes there are reasons to login to one or both of those systems.

Several vendors have similar products.  Personally, I always hated the
weird problems we'd get into on loopback mounts, like the client
deciding to flush out some pages because memory was low.  The server,
being the same system, didn't have any more memory....

One of the benefits of the loopback mounts was that unmounting wasn't
a problem as long as local access was via NFS.  Kill the NFS server,
accesses would end, unmount.  Clients would retransmit a couple times,
but things would resume quickly.

	-Ric Werme

-- 
Eric (Ric) Werme         |  werme@zk3.dec.com
Hewlett-Packard Co.      |  http://werme.8m.net/
