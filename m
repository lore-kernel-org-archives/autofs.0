From: "Ruslan U. Zakirov" <cubic@wildgate.miee.ru>
Subject: Re: Program map for USB devices
Date: Wed, 17 Dec 2003 18:59:48 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FE07D74.10107@wildgate.miee.ru>
References: <200312171548.57310.ext-dirk.heinrichs@nokia.com>
	<1xr3cv5t.fsf@random.localnet.unwireduniverse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1xr3cv5t.fsf@random.localnet.unwireduniverse.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Derrell.Lipman@unwireduniverse.com
Cc: autofs@linux.kernel.org

Derrell.Lipman@unwireduniverse.com wrote:
> Dirk Heinrichs <ext-dirk.heinrichs@nokia.com> writes:
> 
> 
>>I've got several USB devices which are all accessed as SCSI disc through the 
>>usb-storage driver. Since the device node they are attached to depends on 
>>plugin order, I need to know how to find out which hardware is attached to 
>>which /dev/sd*, so that I can write a program map.
> 
> 
> Your program map could look at /proc/scsi/* to determine what's what.
> 
> Derrell
First of all look at `mount` for mount point of procfs(type proc).
For 2.6 kernels, as i think, you also could look into new sysfs for 
needed info.
		Good luck. Ruslan.
