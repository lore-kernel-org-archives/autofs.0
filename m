From: Derrell.Lipman@unwireduniverse.com
Subject: Re: Program map for USB devices
Date: Wed, 17 Dec 2003 10:37:34 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1xr3cv5t.fsf@random.localnet.unwireduniverse.com>
References: <200312171548.57310.ext-dirk.heinrichs@nokia.com>
Reply-To: Derrell.Lipman@unwireduniverse.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200312171548.57310.ext-dirk.heinrichs@nokia.com> (Dirk
 Heinrichs's message of "Wed, 17 Dec 2003 15:48:50 +0100")
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
Content-Transfer-Encoding: 7bit
To: Dirk Heinrichs <ext-dirk.heinrichs@nokia.com>
Cc: autofs@linux.kernel.org

Dirk Heinrichs <ext-dirk.heinrichs@nokia.com> writes:

> I've got several USB devices which are all accessed as SCSI disc through the 
> usb-storage driver. Since the device node they are attached to depends on 
> plugin order, I need to know how to find out which hardware is attached to 
> which /dev/sd*, so that I can write a program map.

Your program map could look at /proc/scsi/* to determine what's what.

Derrell
