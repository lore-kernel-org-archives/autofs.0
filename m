From: Ian Kent <raven@themaw.net>
Subject: Re: Re: autofs RFE
Date: Wed, 10 Dec 2003 18:15:16 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312101805510.3238-100000@raven.themaw.net>
References: <3FD6DEB5.3090800@univie.ac.at>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FD6DEB5.3090800@univie.ac.at>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Gerald Teschl <gerald.teschl@univie.ac.at>

On Wed, 10 Dec 2003, Gerald Teschl wrote:

> H. Peter Anvin wrote:
> >
> > Actually, it's handled just fine by mount(8); the autofs daemon 
> > doesn't need to do anything special.
> >
> > Just pass the -owner filesystem option and mount(8) will use the 
> > ownership of the device node.
> 
> Not sure if I understand you right, but just adding the owner option to 
> the list of options in the
> autofs config file does not work right now.
> 
> So IMHO the autofs daemon needs to change uid
> (to the uid owning the device) before doing the mount call if the owner 
> option is present.

Looking at the mount source it appears the 'owner' option is fstab only.

I can't make this work in testing either.

It looks like, if we use the device file owner, we need to change 
option 'owner' to 'uid=<dev owner>' for this to work. We probably need to 
force 'nodev' and 'nosuid' as well as does mount.

What badness does this bring to us.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
