From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Mon, 19 Jan 2009 15:13:17 +0900
Message-ID: <1232345597.3136.85.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
	<1232079714.3166.56.camel@zeus.themaw.net>
	<408431290901152204i8d2da71vbf8ee5f2e2f84fa@mail.gmail.com>
	<1232087057.3166.88.camel@zeus.themaw.net>
	<1232087952.3166.98.camel@zeus.themaw.net>
	<408431290901170911q1af268b1o5576f46e0bee2129@mail.gmail.com>
	<1232249174.3106.5.camel@zeus.themaw.net>
	<408431290901181728u5b01c262u1b2640595deaac95@mail.gmail.com>
	<1232330605.3136.7.camel@zeus.themaw.net>
	<408431290901182123w63b5ef4aw676fdc1bb60a93bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901182123w63b5ef4aw676fdc1bb60a93bd@mail.gmail.com>
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
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Mon, 2009-01-19 at 16:23 +1100, Paul Wankadia wrote:
> On Mon, Jan 19, 2009 at 1:03 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         
>         > It's just that your earlier comment regarding a concurrency
>         issue led
>         > me to wonder about the use of Pthreads. In particular, I'm
>         not sure
>         > what the rationale was, but I'd also like to understand the
>         control
>         > flow, so that's why I was interested in a design document of
>         some
>         > sort.
>         
>         
>         Right.
>         
>         One of the things that v5 does is to move the master map
>         parsing out of
>         the init script and into the daemon itself. That means that
>         the daemon
>         then has to manage each of the master map mounts as well.
>         Using
>         individual sub-processes has a whole set of problems related
>         to the
>         supervising process communicating with and knowing the state
>         of those
>         sub-processes so v5 changed to a threaded model which of
>         course has it's
>         own set of difficulties.
> 
> Does the daemon need multiple processes/threads because of the
> ioctl(2) calls that block?

A whole bunch of things can block, for example stat(2) on a path against
a down server.

There is one thread for each master map mount which creates worker
threads to do mounts and expires. Ideally any mount blocking will not
affect other mounts and hopefully an expire blocked for some reason
won't stop mount requests. That seems to pretty much work now so things
aren't too bad.

> 
> On a related note, is the autofs device a step towards a completely
> revised kernel interface? I've started to contemplate the use of
> socket pairs instead of pipes and ioctl(2) calls. (NBD seems to be a
> simple example of this style.)

Kind of. The change was needed to solve a fairly significant problem. I
can't see how using sockets can make a difference really because the
source of blocking isn't the interface but rather the things it needs to
do.

But it gets worse as Generic Netlink is a socket based interface, a
recommended ioctl replacement and trying to use that for the
re-implementation was nothing short of a nightmare. I failed to get a
working implementation after several weeks of work. I have the broken
implementation around somewhere, at least as far as I got, if you want
to run with that as a project. Mind you, if user space libnl becomes
thread safe at some point we may want to re-consider this as a viable
approach. It depends on other things as well, but mostly on how we might
change the expire infrastructure post 5.0 (it isn't going to change for
5.0 and we need to retain backward compatibility), namely. whether we
change to using the in kernel VFS mount expire mechanism and whether
that will resolve the significant overhead when expiring large maps that
use the "browse" option or how that issue will be otherwise resolved.
So, yes, I'm thinking about these things but there is still enough to do
with 5.0 to not spend a lot of time on it.

So this interface is the one that will be used until we can come up with
a better one. The reason for the re-implementation is described in
detail in Documentation/filesystems/autofs4-mount-control.txt. The most
important part of this, as it relates to this thread of work, is the
AUTOFS_DEV_IOCTL_ISMOUNTPOINT ioctl. We observed that is_mounted() was
by far and away the top CPU user because it is used a lot and scans
either /proc/mounts or /etc/mtab. My testing showed that using an
updated kernel had a big effect on CPU usage.

Ian
