From: Ian Kent <raven@themaw.net>
Subject: Re: direct map shut down?
Date: Fri, 20 Feb 2004 21:04:56 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402202102020.4573@raven.themaw.net>
References: <1077211015.19371.32.camel@brilong-lnx2.cisco.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1077211015.19371.32.camel@brilong-lnx2.cisco.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Long <brilong@cisco.com>
Cc: autofs@linux.kernel.org

On Thu, 19 Feb 2004, Brian Long wrote:

> /tools nisplus:auto_tools rw,hard,intr,noquota,timeo=15
> /auto /etc/auto.indirect rsize=32768,wsize=32768,tcp
> /users nisplus:auto_home rw,hard,intr,rsize=32768,wsize=32768,tcp
> /- /etc/auto.direct rsize=32768,wsize=32768,tcp

I thought that should be proto=tcp?

> 
> /etc/auto.direct
> /netapp/rtp-filer01a    rtp-filer01a:/vol/vol0

Looks OK?

> 
> Also, is there a version of the kernel module or user utils that would
> support multiple direct mounts under the same mount point?  For example,
> I want to mount rtp-filer01a:/vol/local1 under
> /netapp/rtp-filer01a/vol/local1  :)

Not for direct mount maps.
It should work OK for multi-mount maps. Unfortuneately, there is no lazy 
mounting for them yet.

Ian
