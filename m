From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?=<ia6432@inbox.ru>
Subject: Re[2]: autofs reload
Date: Fri, 26 Mar 2004 19:35:58 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B6uJK-0003zZ-00.ia6432-inbox-ru@f9.mail.ru>
References: <16484.22082.53177.910078@segfault.boston.redhat.com>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16484.22082.53177.910078@segfault.boston.redhat.com>
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

On Fri, 26 Mar 2004 11:11:46 -0500 at 11:11:46 -0500, Jeff Moyer wrote:

> ia6432> in autofs 4.1.0 (autofs4-20031201 in kernel) it tries to mount
> ia6432> host1 even after 5 hours wait and nscd/nis restart.
> Hmm, was the share ever umounted?  You can check this using either lsof of
> fuser before you try to do the ls.  If this is the case, your only option
> is to kill off users of the mount point and try again.

yes this share was umounted a couple of days prior to auto.home nis map update.

> ia6432> so how to do correct autofs map reload?
> 
> Ok, the automount daemon shouldn't start up if the mountpoint is already
> controlled by autofs.  Attached is a patch which addresses this.
> Comments welcome.
this should fix autofs reload or stop/start? i'll try...
