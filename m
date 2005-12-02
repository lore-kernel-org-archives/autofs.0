From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: problem with symbolic links and autofs
Date: Fri, 2 Dec 2005 08:20:25 -0500
Message-ID: <17296.18969.432471.988427@segfault.boston.redhat.com>
References: <554e24be0512012010y31604850l3259e98254511440@mail.gmail.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <554e24be0512012010y31604850l3259e98254511440@mail.gmail.com>
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
To: Chris Walker <christopher.walker@gmail.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] problem with symbolic links and autofs; Chris Walker <christopher.walker@gmail.com> adds:

> Hello, I'm having a problem that I think is related to
> autofs; I apologize in advance if it isn't.  I have a
> cluster with two partitions, /home/cw and /misc_data,
> that are automounted to all nodes in the cluster. There
> is a symbolic link, /home/cw/DATA3D, that points to
> /misc_data/cw/DATA3D.  Most of the time this link works
> without a problem.  When I run code that writes to
> /home/cw/DATA3D, however, it crashes, complaining that
> there is no such file or directory.  If I log in to the
> node and ls -l /misc_data_cw, it gives me a flashing
> red name for DATA3D as if it is a broken link, even
> though the rest of the partition is mounted and acting
> normally.  Furthermore, I can avoid the whole problem
> by logging in to the node before the job runs and
> entering /misc_data/cw/DATA3D.  We didn't have this
> problem when we were running RedHat 3.3; it's only
> since we upgraded to 4.0 (with autofs-4.1.3-155) that
> this has shown up.

> Any advice is appreciated.

File a bug with Red Hat (bugzilla.redhat.com).  When doing so, please
provide the information listed in the "Filing bug reports" section of:
http://people.redhat.com/jmoyer/

Thanks,

Jeff
