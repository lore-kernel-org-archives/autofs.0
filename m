From: Ian Kent <raven@themaw.net>
Subject: Re: stat -L triggering mount (behavior change starting with
 2.6.38-rc1)
Date: Wed, 27 Mar 2013 12:06:02 +0800
Message-ID: <1364357162.2011.32.camel@perseus.fritz.box>
References: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
	 <loom.20130326T135119-763@post.gmane.org>
	 <CAEySpB7frBeNDFAZM8+magDZqSNwf4XEQqzUK652hrak9H5tXA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=SdnHc0UDE5g1RgbzrIUjSU3i6iU=; b=hp5SlSYZ7lFGzmtPlurpQZG1aiXY
	NHthwE9/hsnydTa+4/U0G0/F36YWIprU/ew1AujL4gL7CRNuUBeihV9maNbztBfv
	QHVrEyLIB3iZ07mzsqf1djpimcEN/VlpsBDVAvYCwB1WeyKUEatfAMTwV4mwYb4+
	F7UwpKqX99vGcA8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=SdnHc0UDE5g1RgbzrIUjSU
	3i6iU=; b=aJZn5hBdkrMYdXtb/CWaQrV1jCbPpi4wmqcpsy3qtLkRIYsAWxIxFv
	Jh/dFr3kJqeTUZh1rfnShlIP8LZL3TE60xJm/Weco7lqzghhAg3Lj3W0Jnes6kME
	6pKUMEQGwbUXnKhccHGN+xFHuAFGG6SbC9g++dv78qvf0ZDYQS2Hs=
In-Reply-To: <CAEySpB7frBeNDFAZM8+magDZqSNwf4XEQqzUK652hrak9H5tXA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: toto <guillaume@apostoly.com>, autofs@vger.kernel.org

On Tue, 2013-03-26 at 17:41 -0300, Leonardo Chiquitto wrote:
> On Tue, Mar 26, 2013 at 9:56 AM, toto <guillaume@apostoly.com> wrote:
> > Leonardo Chiquitto <leonardo.lists <at> gmail.com> writes:
> >
> >>
> >> Hello,
> >>
> >> After the update to 2.6.38, I noticed that AutoFS started to mount volumes
> >> at times it normally wouldn't. More specifically, "ls -la" inside an AutoFS
> >> mount point will trigger the mount of all available maps.
> > __________
> >> autofs mailing list
> >> autofs <at> linux.kernel.org
> >> http://linux.kernel.org/mailman/listinfo/autofs
> >>
> >
> > Hi,
> 
> Hi,
> 
> > When you are saying that "ls -la" should not trigger
> >  the automounting of the volumes inside the directory,
> > what would be then the good command line to
> > trigger the mounting of volumes declared in auto.master ?
> 
> The problem that was discussed in this thread was about
> accesses to a parent directory triggering mounts of volumes
> in sub-directories. An example:
> 
> /nfs/volume1
> /nfs/volume2
> 
> Here volume1 and volume2 are two automounted directories.
> What was happening is that "ls -la /nfs" was triggering the
> mounts of volume1 and volume2.

That's right, hence the problem could only occur with indirect mount
maps that used the "browse" option. When the browse option isn't used
the mount point directories don't get pre-created so the mount occurs
with access by create type usage (create being a vfs lookup, not
necessarily a create type system call).

> 
> > I am using Mac OS X 10.8.3 and by default,
> > the elements defined in automaster are mounted when
> > accessed by an application (like the Finder,
> >  which is if you don't know the file manager of OS X), but how
> > then to trigger the silent mounting at startup
> > with a shell script ?
> 
> You just need to access the volume. Using the example above,
> any of these should work:
> 
> $ stat /nfs/volume1/    #  the slash at the end is important
> $ cd /nfs/volume1
> $ ls /nfs/volume1

Yes, the trailing "/" causes the vfs to treat the lookup as a directory
lookup which will cause the automounter to be sent a mount request for
the directory. It should only be needed when the browse option is used
with an indirect mount map.

There were some transitional kernel revisions from 2.6.38, resulting
from the vfs-automount infrastructure introduction (a large change),
where the behavior would cause excessive mounting, AFAICR it was mostly
due to inconsistent system call usage by user space utilities.

> 
> > Are there parameters to pass to "mount"
> > command to say "mount this folder
> > NOW as defined in auto master" ?

Not sure what that means, it sounds like it amounts to the same as
adding entries to the fstab ....

Mount(8) doesn't (and shouldn't) know anything about the automount
master map or automount itself since it isn't involved in the automount
function (other than to be called upon to perform a mount) and it would
add unacceptable dependencies, possibly circular, to mount itself.

Umm ... you may be able to get different behavior by using a direct
mount map instead of an indirect mount map. But if you have very large
maps that could introduce, possibly too much, additional overhead.

Ian


