From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Re[2]: autofs reload
Date: Fri, 26 Mar 2004 12:07:58 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16484.25454.659035.551208@segfault.boston.redhat.com>
References: <16484.22082.53177.910078@segfault.boston.redhat.com>
	<E1B6uJK-0003zZ-00.ia6432-inbox-ru@f9.mail.ru>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1B6uJK-0003zZ-00.ia6432-inbox-ru@f9.mail.ru>
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
To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Cc: autofs@linux.kernel.org

==> Regarding Re[2]: [autofs] autofs reload; "Peter Lojkin" <ia6432@inbox.ru> adds:

ia6432> On Fri, 26 Mar 2004 11:11:46 -0500 at 11:11:46 -0500, Jeff Moyer
ia6432> wrote: in autofs 4.1.0 (autofs4-20031201 in kernel) it tries to
ia6432> mount host1 even after 5 hours wait and nscd/nis restart.
>> Hmm, was the share ever umounted?  You can check this using either lsof
>> of fuser before you try to do the ls.  If this is the case, your only
>> option is to kill off users of the mount point and try again.

ia6432> yes this share was umounted a couple of days prior to auto.home nis
ia6432> map update.

What I meant was, at the time you did an ls, were you sure that there were
no applications accessing the directory.  If nothing was accessing the
directory (even if it is mounted), then autofs should be able reload just
fine.  If that's not the case, then I am certainly perplexed.

>> ia6432> so how to do correct autofs map reload?
>> Ok, the automount daemon shouldn't start up if the mountpoint is already
>> controlled by autofs.  Attached is a patch which addresses this.
>> Comments welcome.
ia6432> this should fix autofs reload or stop/start? i'll try...

No, this will prevent the automount daemon from starting more than once for
a given mount point.  Sorry if that was confusing.

-Jeff
