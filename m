From: Ian Kent <raven@themaw.net>
Subject: Re: autofs RFE
Date: Mon, 8 Dec 2003 11:41:50 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0312081134310.26524-100000@wombat.indigo.net.au>
References: <Pine.LNX.4.44.0312061825240.15355-100000@keen.esi.ac.at>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312061825240.15355-100000@keen.esi.ac.at>
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
To: Gerald Teschl <gerald@esi.ac.at>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sat, 6 Dec 2003, Gerald Teschl wrote:

>
> Hi Ian,
>
> I saw your recent work on autofs and wondered if it would be possible to
> add
> a small but IMHO useful feature to autofs:
>
> I'd like to use autofs for my floppy. pam_console sets the permissiond on,
> e.g., /dev/fd0, such that is owned by the console user and hence,
> when mounting /mnt/floppy it is mounted with the permissions of the owner.
> But this won't help with autofs, since autofs runs as root and hence a
> floppy
> is mounted with owner root.
>
> Would it be possible to make autofs honor the "owner" option for mount and
> mount a dev with the permissions of the owner if this option is present?

I've been thinking about this for a while.

At the moment the userspace daemon has no way of knowing who the owner is.
To change that would break backward compatability. So I'm not sure it's
such a good idea.

How is this handled in v3 Peter?

One way to deal with this is to use groups. The floppy group exists in
RedHat and if you are a member and you allow group write you should have
what you need. The cdrom is a little different. You may wish to create a
new group called, say cdrom, and do the same thing with it.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
