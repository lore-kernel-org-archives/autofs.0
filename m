From: Eric Werme USG <werme@zk3.dec.com>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 15:42:13 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200401132042.i0DKgDR0001085265@anw.zk3.dec.com>
References: <40044F2A.9080305@zytor.com>
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Tue, 13 Jan 2004 12:03:54 PST."
             <40044F2A.9080305@zytor.com> 
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
To: "H. Peter Anvin" <hpa@zytor.com>
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
   > "mailhub" is where Email here winds up.  I send mail via SMTP to mailhub, 
  and
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

*the same system* as the server?  I don't know much about Linux internals,
one reason I don't post here often, but I try to offer insight to other
systems.  Tru64 Unix has a lot of BSD heritage. If mailhub1 is providing the
mailhub service and mounts something from mailhub, messages sent to mailhub
will be caught in the routing code and directed to the loopback "NIC" lo0. 
If the mailhub service (IP address) is relocated to mailhub2, the routing
code will see that no NIC on mailhub1 has the mailhub IP address and will
give the message to a NIC that can reach it.  (And ARP resolves the MAC
address and it all runs like a normal remote mount.)

Ah.  Back to automount/autofs.  I made many fixes to Sun's old automount,
one of them was to rummage among all the NICs looking to see if the
FS was really a local mount and provide the appropriate symlink.  The
cluster folks didn't realize I also checked the alias addresses too,
so I had to add an option to disable that to force a real NFS call.

You mention "you can't just move the IP address away," is that something
Linux doesn't support yet?  No problem on Tru64.  A NIC has one permanent
address and a bunch of aliases that can come and go at the whims of the
admins or load balancing software:

  # ifconfig ee0
  ee0: flags=200c63<UP,BROADCAST,NOTRAILERS,RUNNING,MULTICAST,SIMPLEX,MULTINET>
       inet 16.xx.yy.213 netmask ffffff00 broadcast 16.xx.yy.255 ipmtu 1500 
       inet 16.xx.yy.192 netmask ffffff00 broadcast 16.xx.yy.255 ipmtu 1500 

  # ifconfig ee0 -alias 16.xx.yy.192

  # ifconfig ee0
  ee0: flags=c63<UP,BROADCAST,NOTRAILERS,RUNNING,MULTICAST,SIMPLEX>
       inet 16.xx.yy.213 netmask ffffff00 broadcast 16.xx.yy.255 ipmtu 1500 

	-Ric Werme
-- 
Eric (Ric) Werme         |  werme@zk3.dec.com
Hewlett-Packard Co.      |  http://werme.8m.net/
