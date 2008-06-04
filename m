From: Paul Smith <psmith@netezza.com>
Subject: Re: System hanging in /proc/mounts almost every
	night...	help!
Date: Wed, 04 Jun 2008 11:55:53 -0400
Message-ID: <1212594953.7000.24.camel@psmithub.netezza.com>
References: <1212521944.7156.93.camel@psmithub.netezza.com>
	<x49ve0picd3.fsf@segfault.boston.devel.redhat.com>
Reply-To: psmith@netezza.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49ve0picd3.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 2008-06-04 at 09:00 -0400, Jeff Moyer wrote:
> This .Trash madness has to end.  It keep autofs from expiring mounts
> in other situations.  *grumble*

I'm looking into this and it absolutely does not make any sense, you're
right.  I've got a sample patch that will solve it that I'll propose to
the Gnome folks, but I think personally that my patch is just a quick
hack and something more comprehensive would be better (the types of
filesystems that are checked should be configurable, at least through
gconf or similar--my patch just hardcodes a check for "autofs").

Note this won't help the problem of non-expiring mounts: if you DO have
a .Trash file on the filesystem then, as you point out, this will keep
the partition mounted all the time.  Gross.

FYI, it happened again last night and again, the last thing in the log
was the .Trash thing.  However, I don't think that's the instigator per
se but rather a signpost.  It appears that whenever any filesystem is
mounted or unmounted, that silly .Trash search is triggered; apparently
the gvfsd-trash applet has an inotify or dbus or something set up to
find out when a mount or unmount happens.

I think it's the mount or (more likely) unmount that is both causing the
problem, AND triggering the .Trash search.

Anyway, I get those annoying .Trash messages many times a day but it
never seems to cause any problem.  But soon after I lock my system and
go home for the night, then it happens.  Last night I left about 7pm,
and the problem occurred at 9:43pm.


I'll set up the debugging you asked for, thanks.  Stay tuned for
tomorrow!
