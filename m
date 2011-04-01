From: David Howells <dhowells@redhat.com>
Subject: Re: stat -L triggering mount (behavior change starting
	with 2.6.38-rc1)
Date: Fri, 01 Apr 2011 15:27:25 +0100
Message-ID: <6929.1301668045@redhat.com>
References: <AANLkTin0X+F15LxXu8f4SVZEV=twHO9kf7=K+w2xj1eO@mail.gmail.com>
	<AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
	<1301632038.2880.11.camel@perseus> <2355.1301649598@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <AANLkTin0X+F15LxXu8f4SVZEV=twHO9kf7=K+w2xj1eO@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: dhowells@redhat.com, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Leonardo Chiquitto <leonardo.lists@gmail.com> wrote:

> open("/data", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
> fcntl(3, F_GETFD)                       = 0x1 (flags FD_CLOEXEC)
> getdents64(3, /* 3 entries */, 32768)   = 72
> lstat("/data/isos", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> lgetxattr("/data/isos", "security.selinux", 0x62ad60, 255) = -1 EOPNOTSUPP (Operation not supported)
> getxattr("/data/isos", "system.posix_acl_access", 0x0, 0) = -1 EOPNOTSUPP (Operation not supported)
> getdents64(3, /* 0 entries */, 32768)   = 0

Yeah, I suspect the getxattr() is the problem.  ls calls libacl to get the
Posix ACL of the target file, but that uses the getxattr() which asserts
LOOKUP_FOLLOW during the pathwalk, causing the automount unconditionally:-/

I'm discussing this with the coreutils and acl package maintainers to see if
we can fix it in userspace.

David
