From: Ian Kent <raven@themaw.net>
Subject: Re: autofs and nautilus
Date: Tue, 2 Sep 2003 17:34:41 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0309021732000.3087-100000@raven.themaw.net>
References: <1062492213.2993.34.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1062492213.2993.34.camel@localhost.localdomain>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Larsson <alexl@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Nautilus <nautilus-list@gnome.org>

On 2 Sep 2003, Alexander Larsson wrote:

> There are some different pieces of code involved.
> 
> The core part of nautilus that tracks mounts and removable volumes is
> the NautilusVolumeMonitor. The code for this beast (its pretty horrible
> unfortunately) is in libnautilus-private/nautilus-volume-monitor.c.
> Basically its a singleton object that emits signals when volumes are
> mounted/unmounted and the list of removable devices change.
> 
> The Nautilus part of trash directories are handles by
> libnautilus-private/nautilus-trash-monitor.c and
> libnautilus-private/nautilus-trash-directory.c, but the actual searching
> for trash directories is handled by gnome-vfs in
> gnome-vfs/modules/file-method.c::find_trash_directory().
> 
> However, looking at the code it seems like scanning for trash
> directories only happen when something actively uses the trash.
> 
> I think your problems might just be related to how
> nautilus-volume-monitor.c behaves. There is some autofs magic in
> mount_volume_nfs_add(), but I really don't know this code all that well,
> so i can't tell you what its meant to do.
> 

Thanks for this.

I'll have a look and see what I can come up with.

I have several things going at the moment so I'm not likely to spend much 
time on it till the weekend.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
