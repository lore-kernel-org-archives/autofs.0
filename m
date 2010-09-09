From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: How to reload /net "maps"
Date: Thu, 09 Sep 2010 16:04:19 -0400
Message-ID: <x49pqwm8z0c.fsf@segfault.boston.devel.redhat.com>
References: <20100825182738.GC23737@eeg.ccf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20100825182738.GC23737@eeg.ccf.org> (Greg Wooledge's message of
	"Wed, 25 Aug 2010 14:27:38 -0400")
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
To: Greg Wooledge <wooledg@eeg.ccf.org>
Cc: autofs@linux.kernel.org

Greg Wooledge <wooledg@eeg.ccf.org> writes:

> Debian 5.0, autofs 4.1.4, kernel 2.6.26-2-686

Very old autofs version.  You should transition to version 5.

> I may be overlooking some documentation, but I couldn't find out how to
> do this.  Occasionally one of our NFS servers adds a new entry to its
> /etc/exports file, and we'd like the clients to be able to use it.
>
> The clients look like:
>
> # grep -v '^#' /etc/auto.master
> /net    /etc/auto.net
>
> At some point in the past, autofs will have contacted this host and
> somehow "cached" the fact that it was sharing /home, /data, etc.
> Now I've added /opt to the exports file.  But when I do "ls /net/servername"
> I still only see home and data, not opt.

/etc/auto.net is a program map that returns a multimount entry.  What
that means is that once you traverse into the directory /net/servername,
autofs no longer traps lookups (it does it for the initial mount, but
that's it).  You can get the new export to show up if you managed to get
all applications out of that directory hierarchy, then forced automount
to expire the mount, and then accessed it again.

> Rebooting the client works -- after a reboot, I can see home, data and opt.
>
> I'm trying to find a way to get autofs to reload the server's list of
> shared file systems without totally rebooting the client.  If I issue
> a "/etc/init.d/autofs reload" command, I get a few normal-looking messages,
> but no change in the list of results.  If I try "/etc/init.d/autofs restart"
> it tell me it cannot stop the /net daemon, and cannot start a new one.
> Manually attempting "kill PID" or "kill -HUP PID" has no visible effect.

autofs version 5 may be better in this regard.  I'll let Ian comment on
whether what you want to work is expected to work.

Cheers,
Jeff
