From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [VFS-RFC] autofs4 and bind,
	rbind and move mount requests
Date: Tue, 24 May 2005 12:28:13 -0400
Message-ID: <17043.22045.971680.964834@segfault.boston.redhat.com>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

==> Regarding [VFS-RFC] autofs4 and bind, rbind and move mount requests; raven@themaw.net adds:

raven> I've been investigating a bug report about bind mounting an autofs
raven> controlled mount point. It is indeed disastrous for autofs. It would
raven> be simple enough it to check and fail silently but that won't give
raven> sensible behavior.

raven> What should the semantics be for these type of mount requests
raven> against autofs?

raven> First, a move mount doesn't make sense as it places the autofs
raven> filesystem in a location that is not specified in the autofs map to
raven> which it belongs. It looks like the user space daemon would loose
raven> contact with the newly mounted filesystem and so it would become
raven> useless and probably not umountable, not to mention how the daemon
raven> would handle it. I believe that this shouldn't be allowed. What do
raven> people think? If we don't treat these as invalid then how should
raven> they behave?

I think it is reasonable to not allow this.

[snip]

raven> Bind mount requests are another question.

raven> In the case of a bind mount we can find ourselves with a dentry in
raven> the bound filesystem that is marked as mounted but can't be followed
raven> because the parent vfsmount is in the source filesystem.

raven> Should the automount functionality go along with the bind mount
raven> filesystem? At this stage there's no straight forward way for autofs
raven> to handle two independent mount trees from the same automount
raven> daemon. It's just not designed to do that.

raven> It's probably possible to make this behave as though the automounted
raven> filesystem is mirrored under the filesystem to which it is
raven> bound. But it's likely problematic. What do people think about this?

raven> I've not really thought enough about recursive bind mounts yet but
raven> on the face of it they look fairly ugly as well.

raven> I know this post is short on detail but hopefully that will come out
raven> if there are people interested in discussing it further.

raven> I look forward to some feedback and hope I can find a realistic
raven> approach to solving this problem.

Yeah, this is really a tricky matter.  On the surface, it really doesn't
make sense to me to do a mount -bind with a source directory of the
automount point.  Given the current semantics of bind mounts, what does
this gain you?  Likely it gains you access to an emtpy directory, or a
directory full of empty directories (in the case of ghosting).

Mount -rbind is equally nonsensical, if you agree with the last paragraph.
You will only get a copy of the vfsmount tree at the time of the mount
-rbind call.  Who knows what was mounted at that time, it really isn't
deterministic.

-Jeff
