From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs4 4.1.3-28 with NetApp filer
Date: Mon, 21 Feb 2005 13:03:05 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502211259250.9892@wombat.indigo.net.au>
References: <482A3FA0050D21419C269D13989C611308539786@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
In-Reply-To: <482A3FA0050D21419C269D13989C611308539786@lavender-fe.eng.netapp.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: autofs@linux.kernel.org

On Sun, 20 Feb 2005, Lever, Charles wrote:

> Customer of ours describes this problem:
> 
>   >    We have several netapp boxes that we use as filers and all 
>   >    of them at this site, with the exception of this one box, would
> unmount
>   >    for the linux workstation after the autmount timeout period.
> With the 
>   >    implementation of autofs-4.1.3-28 this particular netapp box
> would not
>   >    only NOT unmount (/net mounts) after timeouts, and would not
> release
>   >    its ports, it would begin to actively take more ports (without
> any
>   >    other mounts of this netapp box taking place).  Within 24 hours a
> linux
>   >    box can be hung by the port-taking activity of this netapp box
> mounted
>   >    via /net.
> 
> They are running on RH 8.0, kernel 2.4.20-20.8smp.  Problem did not
> occur with autofs-4.1.2.
> 
> Does this sound familiar to anyone?

This sounds like the mount order problem we had recently.
Also against a Filer I think.

We can confirm this is the same problem by collecting a log with 
the --debug option set.

I can forward a patch but Jeff may already have included it in his rpm.

Lets confirm it first.

Jeff?
