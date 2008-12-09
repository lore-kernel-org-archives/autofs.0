From: Ian Kent <raven@themaw.net>
Subject: Re: Caching negative lookups
Date: Tue, 09 Dec 2008 15:11:31 +0900
Message-ID: <1228803091.3044.40.camel@zeus.themaw.net>
References: <e28c2a430811030703w654ffafcuf47a95b450e6de37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <e28c2a430811030703w654ffafcuf47a95b450e6de37@mail.gmail.com>
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
To: Mike K <mrkfact@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2008-11-03 at 10:03 -0500, Mike K wrote:
> Hello,
> 
> Based on what I have found, autofs5 supports caching negative lookups,
> but it doesn't appear to be working for me.  Although my understanding
> of how it is supposed to work is very limited, so I may just be
> mistaken.
> 
> My client system:  Red Hat 5.2, autofs-5.0.1-0.rc2.88.x86_64,
> kernel-2.6.18-92.el5.x86_64, with automounter maps in a NIS+ server
> (client in niscompat mode).
> NFS Server: A popular NAS appliance
> 
> auto_master snippet:
> /home/dev auto_dev
> 
> By default (and a recommended setting), the NAS appliance requires
> that all mounts from uid 0 come from a reserved port (0-1024) on the
> client.  On our client system, repeated yp lookups for entries which
> don't exist will consume all ports in 0-1024, causing other legit
> mount attempts to fail since they are denied by the NAS appliance.
> This does not happen on Red Hat 4 or 3 systems.
> 
> Reproducer: 'while true; do cd /home/dev/example; done'.  "watch -n 1
> 'netstat -an | grep TIME_WAIT | wc -l'" will show the number of
> sockets in TIME_WAIT increase rapidly.
> 
> In this case, each 'cd /home/dev/example' causes a yp lookup for a
> directory that doesn't exist in the NIS table, consuming a socket and
> leaving it in TIME_WAIT for 60 seconds.
> 
> Is this situation supposed to be prevented with caching negative
> lookups?

I have committed a patch for this to the autofs git repository and
uploaded the patch to kernel.org. So it is against version 5.0.4 of
autofs.

You may be able to view RHEL bug 469387, in which case you could
contribute to the resolution of this issue in RHEL.

Ian
