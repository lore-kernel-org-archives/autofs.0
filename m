From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: multiple servers per automount
Date: Thu, 09 Oct 2003 17:36:42 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F85D4EA.5030708@sun.com>
References: <6AB920CC10586340BE1674976E0A991D0C6B77@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <6AB920CC10586340BE1674976E0A991D0C6B77@slexch2.sugarland.unocal.com>
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
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

Ogden, Aaron A. wrote:

>Yes, we are using the RH kernels as a base, the limit is supposed to be
>1200+ but my experiments have shown it to be just shy of 800.  Or maybe
>that results is due to a bug in the autofs code.  
>

I don't see how the autofs code would cause such a problem...

>I think the real
>solution to this problem is Richard Gooch's devfs and kernel 2.6.  It's
>anyone's guess when there will be a distribution using both of those but
>I think Fedora might be the first.
>

2.6 mainline still has the 256 pseudo-block device limit.  Fortunately, 
the patches used in distros should still apply with minimal fuzz.  Devfs 
probably won't help matters here.  

I think the next step in 2.6 is to change the bitmap used to grow as 
needed..  especially now that minors are 20 bits, or 1048576 minors  :))

Mike Waychison
