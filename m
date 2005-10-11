From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Using autofs with USB Devices
Date: Tue, 11 Oct 2005 19:40:33 +0200
Message-ID: <20051011174033.GA527@uio.no>
References: <20051011135319.58411.qmail@web60016.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Tue, Oct 11, 2005 at 06:53:19AM -0700, Dr. Harold K. Brown, P.E. wrote:
> What is missing is how to determine which usb dev
> mount point (i.e. /dev/sd?) the device is being
> associated with within this same context.

sysfs will give you this information; look in
/sys/bus/usb/drivers/usb-storage/, IIRC.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
