From: "Kevin Muller" <k.muller@sideshowdigital.com>
Subject: autofs / davfs
Date: Mon, 21 May 2007 12:36:47 +0300
Message-ID: <4104f1cf0705210236tc433e67mc3d36eca30b53631@mail.gmail.com>
References: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
	<4104f1cf0705172308pdd3a3f9l4b4a558e290bebbc@mail.gmail.com>
	<x49zm428auy.fsf@segfault.boston.devel.redhat.com>
	<4104f1cf0705180737o4de54aa9wf2e73de733dc446b@mail.gmail.com>
	<x49sl9u8a3k.fsf@segfault.boston.devel.redhat.com>
	<4104f1cf0705210043y66c2ff79qd1f39792c49e0e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4104f1cf0705210043y66c2ff79qd1f39792c49e0e6@mail.gmail.com>
Content-Disposition: inline
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

Hi There!

Thank you for your response. I have tried it with fs=davfs, and
fs=autofs, just to make sure that it was not a type setting.

The mount command to mount would be:
mount -t davfs <weburl> <mountpoint>

so in my case it would be:
mount -t davfs http://192.168.200.40/repos/   home/automount/web.site.com

or alternativly, if a fstab entry is created, then just:
mount -t davfs <mountpoint>

The davfs is a kernel filesystem module that provides a way to mount a
webdav resource as a local filesystem. The reason for using it is to
have a transparent mounted filesystem into a  webdav repository, that
has automatic versioning. And the webdav repository can be anywhere on
the intern, the davfs, using the fuse, and neon libraries, will
auto-cache the files from the repository. So the access from the user
point will be live, and the file versioning up to date, And completely
transparent. The auto-mount is there for the simple reason that there
will be many many mount points for the different projects, and having
them all mounted at the same time will use all the machines resources.

-Kevin

On 5/18/07, Jeff Moyer <jmoyer@redhat.com> wrote:
> Why didn't you reply to the list, as well?
>
> ==> On Fri, 18 May 2007 17:37:10 +0300, "Kevin Muller" <k.muller@sideshowdigital.com> said:
>
> Kevin> [rpm -q autofs]
> Kevin> autofs-5.0.1-0.rc2.43.0.2
>
> Kevin> [uname -r]
> Kevin> 2.6.18-8.1.3.el5
>
> Kevin> [auto.master:]
> Kevin> /misc   /etc/auto.misc
> Kevin> /net    -hosts
> Kevin> /home/automount         autodav.auto --ghost --timeout=120 --debug
>
> Kevin> [autodav.auto:]
> Kevin> web.site.com          -fstype=autofs          http://192.168.200.40/repos
>
> This entry should not be fstype=autofs.  If you can provide an example
> of the command you use to mount this manually, I can help you write
> your automount maps.
>
> -Jeff
>


p.s excuse the not replying to the list, I have got all my replies,
and stuff in a confusion here, kinda put a spanner in the works,
