From: Mike Waychison <michael.waychison@sun.com>
Subject: Re: auotfs v4
Date: Thu, 06 Nov 2003 15:25:41 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FAAAE45.7030702@sun.com>
References: <3FAA8EE3.1060109@rhythm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FAA8EE3.1060109@rhythm.com>
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
To: Greg Bradner <gregb@rhythm.com>
Cc: autofs@linux.kernel.org

Greg Bradner wrote:

> Any ideas what 'mount table full' means?
> Nov  6 10:08:44 linn automount[27555]: >> NFSv3 not supported!
> Nov  6 10:08:44 linn automount[27555]: >> mount table full
> Nov  6 10:08:44 linn automount[27555]: mount(nfs): nfs: mount failure 
> fs7:/vol/vol0/systems/celia/utils on /celia/utils/
> Nov  6 10:09:15 linn automount[1899]: attempting to mount entry 
> /misc/hsm_cache
> Nov  6 10:09:15 linn automount[27589]: >> NFSv3 not supported!
> Nov  6 10:09:15 linn automount[27589]: >> mount table full
> Nov  6 10:09:15 linn automount[27589]: mount(nfs): nfs: mount failure 
> fs8:/vol/vol0/hsm_cache on /misc/hsm_cache/
>
> Everything works fine after a reboot.
>
It means that you have more than 256 mounts that don't have a 
block-device back-end.  These include NFS, autofs, procfs, sysfs...

This is a known limitation in linux 2.4.  You may want to try a patch 
like the following:

http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-unmaj.diff

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
