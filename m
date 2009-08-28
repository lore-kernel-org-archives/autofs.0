From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Using autofs with on non-mounted directory
Date: Fri, 28 Aug 2009 10:49:30 -0400
Message-ID: <x49tyzs3sed.fsf@segfault.boston.devel.redhat.com>
References: <h6h1jt$bbh$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <h6h1jt$bbh$1@ger.gmane.org> (Lukas Haase's message of "Wed, 19
	Aug 2009 16:18:35 +0200")
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Lukas Haase <lukashaase@gmx.at>
Cc: autofs@linux.kernel.org

Lukas Haase <lukashaase@gmx.at> writes:

> Hi,
>
> I have the problem that I have an indirect mount in
> "/var/lib/vz/root/500/media/media". Unfortunately this directory does
> not always exists (particulary not on system startup).

So it doesn't get mounted automatically?  If it *is* mounted as part of
startup, then it sounds like you just need to move that sooner in your
boot order.

> The directory exists as soon as another filesystem
> "/var/lib/vz/root/500" is mounted. I have the possibility to execute a
> script when that filesystem is mounted and umounted.

> Do I have the possibility to add/remove this indirect mount somehow
> "on the fly"?

You would have to script this yourself.  There is no real api to tell
the automounter to add map entries.

Cheers,
Jeff
