From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs v4 patch] log reloads to the system log
Date: Wed, 17 Jan 2007 17:27:02 +0900
Message-ID: <1169022422.4390.19.camel@raven.themaw.net>
References: <m3sleaa2he.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <m3sleaa2he.fsf@redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs <autofs@linux.kernel.org>

On Tue, 2007-01-16 at 20:03 -0500, jmoyer@redhat.com wrote:
> This is a patch to address a request we had on this list not too long ago.
> /etc/init.d/autofs start/stop/restart are all logged to the system log, but
> reload is not.  This makes it so that reloads also get logged.

Yep. I grabbed a copy from the bz already.

Ian
