From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Please help
Date: Mon, 3 May 2004 09:21:34 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16534.18270.556651.276566@segfault.boston.redhat.com>
References: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding [autofs] Please help; raven@themaw.net adds:

raven> Hi all,

raven> The recent post regarding replicated server mounts has caused me a
raven> bit of work.

raven> Basically, I broke the functionality a bit when I merged the patch I
raven> received from Michael Blandford.

raven> I believe the included patch fixes this.

raven> Additionally, while fixing it I stumbled on the "BUG: dir already
raven> mounted" message that has been annoying us for so long.

raven> I think I've fixed that as well. It's only about my third attempt at
raven> it so I'm not expecting it's final. Maybe third time lucky.

raven> Anyway, since the change is a bit more than straight forward I'd
raven> like as many people as can to test it out before I commit and
raven> release it in 4.1.3. I've probably broken something else.

I've posted RPMS with this patch applied on my people page:
     http://people.redhat.com/~jmoyer/

Version 4.1.2-4 is what you want.  I'll make the page a bit more
user-friendly when I get some free time.  Packages for RHEL 3, Fedora Core
1, and Fedora core 2 are available.  I also have the source rpms posted.

Happy testing,

Jeff
