From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: multiple servers per automount
Date: Thu, 09 Oct 2003 14:23:39 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F85A7AB.8070307@sun.com>
References: <Pine.LNX.4.33.0310091104250.16859-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.33.0310091104250.16859-100000@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

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
