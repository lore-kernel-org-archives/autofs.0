From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [autofs PATCH] Add -c option when calling /bin/umount - if
 supported.
Date: Wed, 7 Jun 2017 17:55:46 +0200
Message-ID: <20170607155546.os45xr6zv5emhf7g@ws.net.home>
References: <87d1agd4cu.fsf@notabene.neil.brown.name>
 <20170607155202.5zyzuvy6l3fsawkl@ws.net.home>
Mime-Version: 1.0
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com ACB3937EEF
Content-Disposition: inline
In-Reply-To: <20170607155202.5zyzuvy6l3fsawkl-xkT7n84Rsxv/9pzu0YdTqQ@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>
Cc: Ian Kent <raven-PKsaG3nR2I+sTnJN9+BGXg@public.gmane.org>, autofs mailing list <autofs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, util-linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Jun 07, 2017 at 05:52:02PM +0200, Karel Zak wrote:
> On Wed, Jun 07, 2017 at 10:32:49AM +1000, NeilBrown wrote:
> > 
> > The "-c" option has been supported by umount since util-linux 2.17.
> > It tells umount that the path name is "canonical", meaning no
> > symlinks or ".." etc.
> > This is appropriate for autofs to use and it always uses canonical
> > path names.
> > The advantage of "-c" is that it means umount doesn't need to
> > 'lstat()' the path so much.
> 
> It would be also nice to force systemd to use "umount -c" on shutdown
> to avoid automount storm...

$ git blame -L889,+1 src/core/mount.c
83897d54 (Neil Brown 2017-06-07 22:28:23 +1000 889)         r = exec_command_set(m->control_command, UMOUNT_PATH, m->where, "-c", NULL);

OK.... ;-)

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
