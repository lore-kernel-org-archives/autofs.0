From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: ghost parameter not working
Date: Mon, 09 Mar 2009 17:07:27 -0400
Message-ID: <x49wsaybe28.fsf@segfault.boston.devel.redhat.com>
References: <20090309182006.GA3046@SamZwo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090309182006.GA3046@SamZwo> (Nathan Huesken's message of "Mon, 
	9 Mar 2009 19:20:07 +0100")
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
To: Nathan Huesken <autofs@lonely-star.org>
Cc: autofs@linux.kernel.org

Nathan Huesken <autofs@lonely-star.org> writes:

> Hi,
>
> I am on arch-linux.
> I have installed autofs 4.1.4
> My auto,master:
> /media/auto          /etc/autofs/auto.misc --timeout=1 --ghost
>
> /etc/autofs/auto.misc:
> cdrom -fstype=iso9660,ro,nodev,nosuid :/dev/cdrom
> usbstick -fstype=auto,async,nodev,nosuid,umask=000 :/dev/sdb1
>
> It all works! I can change into /media/auto/usbstick and see the
> usbstick.
> But the ghost option does not work! If I do ls /media/auto it shows not
> directories at all.
> What could be wrong?

Please post a debug log, and let us know your kernel version.  Directions
for obtaining a debug log can be found on my people page:
  http://people.redhat.com/jmoyer

Cheers,
Jeff
