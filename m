From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: AutoFS5 for 2.6.27.x?
Date: Mon, 03 Nov 2008 10:50:54 -0500
Message-ID: <x49abcgkdup.fsf@segfault.boston.devel.redhat.com>
References: <490EFB81.3060102@aei.mpg.de>
	<x49r65ski5k.fsf@segfault.boston.devel.redhat.com>
	<490F13B1.7000508@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <490F13B1.7000508@aei.mpg.de> (Carsten Aulbert's message of "Mon, 
	03 Nov 2008 16:07:29 +0100")
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
To: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Cc: autofs@linux.kernel.org

Carsten Aulbert <carsten.aulbert@aei.mpg.de> writes:

> Hi all
>
> Jeff Moyer wrote:
>> The kernel module is named autofs4 for reasons I won't get into.  The
>> latest userspace package is autofs version 5.  The autofs4 kernel
>> modules speaks the autofs version 5 protocol.
>> 
>> In short, you want the autofs version 5 userspace packages.
>
> Jumping up and down too early I guess:
>
> I've userland autofs5 version 5.0.3 installed, the kernel 2.6.27.2 has
> AUTOFS4 set
> $ zgrep AUTOFS /proc/config.gz
> CONFIG_AUTOFS_FS=y
> CONFIG_AUTOFS4_FS=y

Don't build them both into the kernel.  Ian, we should see if there's a
way to disallow that.

You want:

CONFIG_AUOTFS_FS=n
CONFIG_AUTOFS4_FS=m

Cheers,

Jeff
