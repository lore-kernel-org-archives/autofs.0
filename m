From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 12:03:54 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40044F2A.9080305@zytor.com>
References: <200401131958.i0DJwlV0001078000@anw.zk3.dec.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200401131958.i0DJwlV0001078000@anw.zk3.dec.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Eric Werme USG <werme@alpha.zk3.dec.com>
Cc: autofs@linux.kernel.org, alexander.marx@hp.com

Eric Werme USG wrote:
> 
> The stop-gap cluster system in Tru64 Unix did this.  Typically pairs
> of servers had system names (service names in the jargon) and bound
> the IP address to a NIC on one server.  When the service was relocated
> manually or on a crash, the IP address was moved to a NIC on the other
> server.  Disks were on a shared SCSI bus, and the file system would also
> go through a umount/mount cycle.  Note that no changes to DNS' database
> are necessary, just an update to clients' arp tables.
> 
> For example, we have systems "mailhub1" and "mailhub2".  The service name
> "mailhub" is where Email here winds up.  I send mail via SMTP to mailhub, and
> read it via NFS from mailhub.  Normally I don't care which of mailhub1
> and mailhub2 handles it.  For the most part they're just servers, but
> sometimes there are reasons to login to one or both of those systems.

However, this doesn't address the issue of the client being *the same
system*, in which case you can't just move the IP address away from it,
since local == remote; you can no longer send packets to the server and
get a response back.  You can do it if you can get the client and the
server sides to bind to *different* IP addresses, in which case the
current autofs behaviour will correctly see them as being separate and
mount NFS.

	-hpa
