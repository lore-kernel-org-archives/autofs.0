From: "Francesco P. Lovergine" <f.lovergine@ba.issia.cnr.it>
Subject: Re: Automount USB Drive using Volume Name as Mount Point
Date: Wed, 24 Jan 2007 12:21:00 +0100
Message-ID: <20070124112100.GD3079@mithrandir>
References: <918171.95307.qm@web35503.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

On Mon, Jan 22, 2007 at 02:46:17PM -0800, Sandra Bonus wrote:
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
> 

This is an udev ruling task, you should differentiate by serial id, tags or what ever

-- 
Francesco P. Lovergine
