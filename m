From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: multiple servers per automount
Date: Thu, 9 Oct 2003 13:45:59 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D5955F1@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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
To: Mike Waychison <Michael.Waychison@Sun.COM>, Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


Ouch.  As you may know, the limit is *much* lower in linux.  Something
that I've been struggling with recently...

Under normal circumstances I would not be concerned with 'limitations'
of a few hundred active NFS mounts, but such limitations certainly limit
scalability for the extreme cases.

-----Original Message-----
From: Mike Waychison [mailto:Michael.Waychison@Sun.COM] 
Sent: Thursday, October 09, 2003 1:24 PM
To: Ian Kent
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] multiple servers per automount


Ian Kent wrote:

>On a related not Mike.
>
>Is the number of NFS mounts on Solaris unlimited or is it table driven?
>I can't find a reference to it anywhere.
>
>  
>
I've asked around, and I'm told that there is no set limit (besides 
having enough memory).  I'm told that more recent Solaris releases have 
been tested up to around 260,000 concurrent NFS mounts.

Mike Waychison

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
