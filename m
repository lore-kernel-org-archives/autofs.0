From: Ian Kent <raven@themaw.net>
Subject: Re: Fedora 8 And Autofs SOLVED!!
Date: Fri, 15 Aug 2008 23:50:45 +0800
Message-ID: <1218815446.12073.16.camel@raven.themaw.net>
References: <797320.57650.qm@web54306.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <797320.57650.qm@web54306.mail.re2.yahoo.com>
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
To: ttran7700@yahoo.com
Cc: autofs@linux.kernel.org


On Fri, 2008-08-15 at 06:22 -0700, Thanh Tran wrote:
> After a lot of digging and lot of help from Ian, I have solved the
> problem.  It might not be the best answer, but it works good enough
> for now.  In my auto.master file I reference several map files (one
> for cdrom's, one for usb HD/solid state memory, and one for floopy).
> After examining the debug output from the service, I noticed only one
> of the map files was being read.  My solution was to combine the
> contents of all the map files into one file.  I also had an error when
> referencing a usb device.  I didn't realize Fedora 8 maps usb drives
> to /dev/sdb1.  I always used sda1 under Fedora 5.  I'm not sure why
> autofs version 5 didn't let me reference more than one map file in my
> auto.master.  Thanks for all the help.

You can't have multiple entries for the same mount point in the master
map but that's also the case in version 4.

Direct maps in version 5 are an exception to this.

That's just the way it is.

You could do something like:

/-	auto.cdrom
/-	auto.floppy

And then auto.cdrom:
/mnt/cdrom	:/dev/cdrom

etc.

or just:

/-	auto.removable

and auto.removable as
/mnt/cdrom	:/dev/cdrom
/mnt/floppy	:/dev/fd0
