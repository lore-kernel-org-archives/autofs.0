From: Alexander Larsson <alexl@redhat.com>
Subject: Re: autofs and nautilus
Date: 02 Sep 2003 10:43:34 +0200
Sender: nautilus-list-admin@gnome.org
Message-ID: <1062492213.2993.34.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0309012139520.4150-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <nautilus-list-admin@gnome.org>
In-Reply-To: <Pine.LNX.4.44.0309012139520.4150-100000@raven.themaw.net>
Errors-To: nautilus-list-admin@gnome.org
List-Help: <mailto:nautilus-list-request@gnome.org?subject=help>
List-Post: <mailto:nautilus-list@gnome.org>
List-Subscribe: <http://mail.gnome.org/mailman/listinfo/nautilus-list>,
	<mailto:nautilus-list-request@gnome.org?subject=subscribe>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://mail.gnome.org/mailman/listinfo/nautilus-list>,
	<mailto:nautilus-list-request@gnome.org?subject=unsubscribe>
List-Archive: <http://mail.gnome.org/archives/nautilus-list/>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Nautilus <nautilus-list@gnome.org>

On Mon, 2003-09-01 at 15:55, Ian Kent wrote:
> On 1 Sep 2003, Alexander Larsson wrote:
> 
> > On Sat, 2003-08-30 at 16:55, Ian Kent wrote:
> > > Hi all,
> > > 
> > > I have recently taken on maintenance of autofs v4 and am investigating a 
> > > problem with Nautilus and autofs.
> > > 
> > > It appears that the if the Trash monitor scans the mounts at the time that 
> > > an expire is happening it remounts the the automount entry. I have spent 
> > > quite a while developing an understanding of what is happening but I can't 
> > > think of a way to get around this purely within autofs. I am hoping that 
> > > a solution can be found in discussion here on the list.
> > > 
> > > Please help.
> > 
> > I'm all for fixing this in Nautilus, however i'm hardly an expert in
> > autofs or mounting in general. The nautilus volume handling code is
> > pretty gross, and at some point it will probably be rewritten. 
> 
> In cooperation with autofs we should be able to sort it out.
> 
> > 
> > However, is trash scanning really a problem? Don't we only do that on
> > startup?
> 
> That's the sort of thing I'm here to find out.
> 
> I'm happy to do more experimentation.
> 
> It appears to me that there is probably a call to stat or the like that 
> often (sometimes 3 out of 4, sometimes 1 out of 4, then sometimes not a 
> all) happens when an automount times out, like it is triggered upon 
> seeing the change in the mount table. This, as it should, causes 
> a (re)mount to occur. A quick scan over the source gave me the impression 
> it might be a scan for trash folders but I am by no means sure. One 
> obvious thought is that it's probably not useful to act on umounts but 
> rather on mounts. I'm sure it can't be that simple.
> 
> Perhaps a pointer to the relevant bits of code could shed some light on it 
> for me without the pain of having to go through it bit by bit.

There are some different pieces of code involved.

The core part of nautilus that tracks mounts and removable volumes is
the NautilusVolumeMonitor. The code for this beast (its pretty horrible
unfortunately) is in libnautilus-private/nautilus-volume-monitor.c.
Basically its a singleton object that emits signals when volumes are
mounted/unmounted and the list of removable devices change.

The Nautilus part of trash directories are handles by
libnautilus-private/nautilus-trash-monitor.c and
libnautilus-private/nautilus-trash-directory.c, but the actual searching
for trash directories is handled by gnome-vfs in
gnome-vfs/modules/file-method.c::find_trash_directory().

However, looking at the code it seems like scanning for trash
directories only happen when something actively uses the trash.

I think your problems might just be related to how
nautilus-volume-monitor.c behaves. There is some autofs magic in
mount_volume_nfs_add(), but I really don't know this code all that well,
so i can't tell you what its meant to do.

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                            Red Hat, Inc 
                   alexl@redhat.com    alla@lysator.liu.se 
He's a lonely coffee-fuelled ex-con who must take medication to keep him sane. 
She's a hard-bitten communist pearl diver with a song in her heart and a 
spring in her step. They fight crime! 

-- 
nautilus-list mailing list
nautilus-list@gnome.org
http://mail.gnome.org/mailman/listinfo/nautilus-list
