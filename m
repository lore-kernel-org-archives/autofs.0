From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Subject: Re[4]: autofs reload
Date: Fri, 26 Mar 2004 20:23:58 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B6v3m-0000cJ-00.ia6432-inbox-ru@f25.mail.ru>
References: <16484.25454.659035.551208@segfault.boston.redhat.com>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16484.25454.659035.551208@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org

On Fri, 26 Mar 2004 at 12:07:58 -0500, Jeff Moyer wrote:

> ia6432> yes this share was umounted a couple of days prior to auto.home nis
> ia6432> map update.
> 
> What I meant was, at the time you did an ls, were you sure that there were
> no applications accessing the directory.
yes there're no applications accessing the directory...

>  If nothing was accessing the
> directory (even if it is mounted), then autofs should be able reload just
> fine.  If that's not the case, then I am certainly perplexed.
looks like it now needs HUP signal to update cache as mentioned in
other rely...

> >> controlled by autofs.  Attached is a patch which addresses this.
> >> Comments welcome.
> ia6432> this should fix autofs reload or stop/start? i'll try...
> 
> No, this will prevent the automount daemon from starting more than once for
> a given mount point.  Sorry if that was confusing.
well it works i.e. no more duplicate automount and it's good.
but now we need to fix "stop" because when i did autofs stop, then
installed new version and did autofs start i got unusable /auto and /home.
with autofs stop all automount processes stoped but autofs on /auto and
/home was not umounted (there're directories in use), so when i started
new version no daemon came up for this points.
then i did umount /auto /home and got several "Busy inodes after unmount".
after next autofs restart everything worked...
