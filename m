From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 12:54:49 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40045B19.2040301@zytor.com>
References: <200401132042.i0DKgDR0001085265@anw.zk3.dec.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200401132042.i0DKgDR0001085265@anw.zk3.dec.com>
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
To: Eric Werme USG <werme@zk3.dec.com>
Cc: autofs@linux.kernel.org, alexander.marx@hp.com

Eric Werme USG wrote:
> 
> *the same system* as the server?  I don't know much about Linux internals,
> one reason I don't post here often, but I try to offer insight to other
> systems.  Tru64 Unix has a lot of BSD heritage. If mailhub1 is providing the
> mailhub service and mounts something from mailhub, messages sent to mailhub
> will be caught in the routing code and directed to the loopback "NIC" lo0. 
> If the mailhub service (IP address) is relocated to mailhub2, the routing
> code will see that no NIC on mailhub1 has the mailhub IP address and will
> give the message to a NIC that can reach it.  (And ARP resolves the MAC
> address and it all runs like a normal remote mount.)
> 

That one is not a problem.  The problem is that you either need to force
the local address of the mount explicitly at the application layer (in
this case this would require a localaddr= option to mount, or something
similar) or it needs to be done by setting up the appropriate rules in
the kernel.

> Ah.  Back to automount/autofs.  I made many fixes to Sun's old automount,
> one of them was to rummage among all the NICs looking to see if the
> FS was really a local mount and provide the appropriate symlink.  The
> cluster folks didn't realize I also checked the alias addresses too,
> so I had to add an option to disable that to force a real NFS call.
> 
> You mention "you can't just move the IP address away," is that something
> Linux doesn't support yet?  No problem on Tru64.  A NIC has one permanent
> address and a bunch of aliases that can come and go at the whims of the
> admins or load balancing software:

No, the problem is: which local address will the socket be bound to.

	-hpa
