From: Ian Kent <raven@themaw.net>
Subject: Re: Automount USB Drive using Volume Name as Mount Point
Date: Tue, 23 Jan 2007 10:21:45 +0900
Message-ID: <1169515305.3594.28.camel@raven.themaw.net>
References: <918171.95307.qm@web35503.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <918171.95307.qm@web35503.mail.mud.yahoo.com>
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
To: Sandra Bonus <mrsbonus1@yahoo.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-01-22 at 14:46 -0800, Sandra Bonus wrote:
> I'm not sure if this question is an autofs question or perhaps for some other software component.
> I have a couple of external USB hard drives with NTFS partitions each with different volume names eg HDD1 and HDD2
> If I connect these one at a time they both come up as /dev/sde and I have an autofs entry like 
> usb     -fstype=ntfs-3g :/dev/sde1
> 
> This mounts one drive as /misc/usb
> 
> This works fine except it would be ideal if each drive actually mounted as 
> /misc/HDD1 and /misc/HDD2 so that scripts can more easily differentiate the disks
> 
> If I log in using Gnome then this seems to have no problem mounting each drive and placing an icon on the desktop using the volume label. However, I almost never use Gnome and the machine in question is a server. 

I thought all that was needed for this is hald, not Gnome but I'm not
sure. Perhaps it should be that way.

This type of hotplug device is better managed by HAL.

Perhaps logging a bz against HAL and asking would be the best way to
resolve this.

Ian
