From: Sev Binello <sev@bnl.gov>
Subject: automount[ ]: failed to mount
Date: Fri, 04 Mar 2005 17:30:46 -0500
Message-ID: <4228E196.4090303@bnl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
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


Can anyone shed any light on the significance of the error messages below?

We constantly get messages of the form ....

Mar  4 11:28:57 acnlin43 automount[2740]: attempting to mount entry /cfs/g
Mar  4 11:29:00 acnlin43 automount[14890]: mount(nfs): no host elected
Mar  4 11:29:00 acnlin43 automount[14890]: failed to mount /cfs/g

or just simply....

   Mar  4 09:58:17 acnlin42 automount[30250]: failed to mount /cfs/ad



Followed by a successful mount not too long afterward...
Mar  4 11:33:54 acnlin43 automount[2740]: attempting to mount entry /cfs/g

The failure bounces around to different filesystems -- using /cfs/g here 
as an example --
even though the nfs severs for these filesystems are up and running.

We are running Redhat WS updates 1,2,3,4  and autofs-3.1.7-41 
autofs-4.1.3-47
our mounts look something like this ( we normally use udp, but also 
tested with tcp)...
in auto.master
        /cfs    /etc/auto.cfs   --timeout 60
in auto.cfs
            g    -ro,intr,noquota,proto=tcp                
acnlin34.pbn.bnl.gov:/cfsg



Thanks,
-Sev
