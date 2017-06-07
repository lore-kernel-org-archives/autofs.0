From: Karel Zak <kzak@redhat.com>
Subject: Re: [autofs PATCH] Add -c option when calling /bin/umount - if
 supported.
Date: Wed, 7 Jun 2017 17:52:02 +0200
Message-ID: <20170607155202.5zyzuvy6l3fsawkl@ws.net.home>
References: <87d1agd4cu.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 4872680E7D
Content-Disposition: inline
In-Reply-To: <87d1agd4cu.fsf@notabene.neil.brown.name>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: NeilBrown <neilb@suse.com>
Cc: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>, linux-nfs@vger.kernel.org, util-linux@vger.kernel.org

On Wed, Jun 07, 2017 at 10:32:49AM +1000, NeilBrown wrote:
> 
> The "-c" option has been supported by umount since util-linux 2.17.
> It tells umount that the path name is "canonical", meaning no
> symlinks or ".." etc.
> This is appropriate for autofs to use and it always uses canonical
> path names.
> The advantage of "-c" is that it means umount doesn't need to
> 'lstat()' the path so much.

It would be also nice to force systemd to use "umount -c" on shutdown
to avoid automount storm...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
