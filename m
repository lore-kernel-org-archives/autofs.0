From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 looks up wrong path element when ghosting is
	enabled
Date: Sat, 8 Oct 2005 13:43:00 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0510081341460.2069@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
	<17203.7543.949262.883138@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
	<17205.48192.180623.885538@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
	<17208.24786.729632.221157@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17208.24786.729632.221157@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Jeff Moyer wrote:

> 
> I put together a different patch, but I want to get your input on the
> approach before I post it.  It requires both user-space and kernel-space
> changes.
> 
> Basically, you identify that a given automount tree is a direct map tree.
> This information is passed along to the kernel (I did this via a mount
> option), and recorded (in the super block info).  Then, when a directory
> lookup occurs, if we are in a direct map tree, and ghosting is enabled,
> then we pass the lookup on to the real lookup code.
> 
> I'm not sold on the approach, as I haven't thought through all of the
> implications.  Care to comment?

Can you post your patch please Jeff.

Ian
