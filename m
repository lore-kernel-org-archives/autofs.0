From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: writing to fstab or mtab
Date: Fri, 29 May 2009 10:02:37 -0400
Message-ID: <x498wkghurm.fsf@segfault.boston.devel.redhat.com>
References: <4A1FD279.7030009@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A1FD279.7030009@bononline.nl> (Stef Bon's message of "Fri, 29
	May 2009 14:18:01 +0200")
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

Stef Bon <stef@bononline.nl> writes:

> Hello,
> Now to prevent HAL to try to mount the device at /media, the scripts in 
> my contruction write a line to /etc/fstab, like:
>
> /dev/sdb1 /home/sbon/Connections/Devices/USB\040stick auto noauto,user 0 0
>
> This works very good, but this setting in fstab confuses the 
> automounter. I'm not trying to solve my problem here with hal, but how 
> come the setting in fstab to confuse autofs?

Stef, you're going to have to be a bit more specific!  What do you mean
it confuses the automounter?  What behaviour is expected/observed?  Do
you have a debug log?

Cheers,
Jeff
