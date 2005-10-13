From: Ian Kent <raven@themaw.net>
Subject: Re: Using autofs with USB Devices
Date: Thu, 13 Oct 2005 09:43:58 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0510130942190.26706@wombat.indigo.net.au>
References: <20051011135319.58411.qmail@web60016.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20051011135319.58411.qmail@web60016.mail.yahoo.com>
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
To: "Dr. Harold K. Brown, P.E." <hbrown_usa@yahoo.com>
Cc: autofs@linux.kernel.org

On Tue, 11 Oct 2005, Dr. Harold K. Brown, P.E. wrote:

> 
> The issues at play here is when there are several
> usb-storage devices, (i.e. ipod, memory cards, and
> cameras) mounted in different order and in different
> usb ports the (/dev/sd?) assignment is somewhat random
> from a user standpoint.  The goal is to resolve this
> problem and document the solution.  Note also other
> devices such as iPODS may also be plugged into the USB
> ports during the same time period.

I thought that device name persistence was one of the issues
that udev addressed?

Ian
