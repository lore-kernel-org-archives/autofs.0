From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [NFS] Re: multiple servers per automount
Date: Fri, 10 Oct 2003 11:54:20 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F86D62C.9000102@sun.com>
References: <6AB920CC10586340BE1674976E0A991D0C6B7D@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <6AB920CC10586340BE1674976E0A991D0C6B7D@slexch2.sugarland.unocal.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; format="flowed"; charset="us-ascii"
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net, "Lever, Charles" <Charles.Lever@netapp.com>, Ian Kent <raven@themaw.net>

Ogden, Aaron A. wrote:

>Aha! Wisdom from the heavens... :-)
>I assume that the RPC code is doing that to comply with reserved-port
>restrictions, ie. ports < 1024.  Solaris needs to do the same thing
>(with nfssrv:nfs_portmon=1) so it seems that there would be an inherent
>limit of 1024 ports or mountpoints to work with.  Actually less, since
>some ports will be in use.  How does Sun get 260,000 active mounts if
>they can only use ports < 1024?  Do we really need one port for each
>mountpoint?
>  
>


Don't take my word for it, because I don't know any better..   But 
Solaris may multiplex different NFS servers on the same udp port.  They 
may also have their tests done with TCP instead of udp, which solves 
that problem elegantly.

>Perhaps this has something to do with the fact that solaris autofs is
>multithreaded (ie. one process) whereas linux autofs has many processes,
>one for each mountpoint.  Feel free to correct me if I'm wrong...
>  
>

Nah, this sounds alot like an NFS issue.  See Charles Lever's post.

Mike Waychison
