From: raven@themaw.net
Subject: Re: autofs-4.1 slow to mount
Date: Thu, 13 May 2004 23:02:50 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405132300580.13693@donald.themaw.net>
References: <200405101900.i4AJ09pH031586@hera.kernel.org>
	<40A0CC37.3080003@gxt.com>
	<Pine.LNX.4.58.0405130639030.16060@www.wm7d.net>
	<16547.34453.14284.235161@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16547.34453.14284.235161@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Thu, 13 May 2004, Jeff Moyer wrote:

> Not sure what the issue here is.  Trying with my latest rpm would provide a
> useful data point.  See below.
> 
> jmack> on another similar machine, automount-4.1.2 won't mount the zip
> jmack> disk, giving "e2fsck: need terminal for interactive repairs".
> jmack> Running fsck from the command line shows a clean zip disk.
> jmack> automount-4.0.0pre10 mounts zip disk OK.
> 
> Hmm.  This second issue sounds like the spawnl issue discovered a little
> while back.  Could you try the autofs package from my people page:
> 
>       http://people.redhat.com/~jmoyer/
> 
> Or, you could try the attached patch.

Ahh Yes. Thanks Jeff. That sounds like it.

Ian
