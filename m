From: Ian Kent <raven@themaw.net>
Subject: Re: automounted symlink to automount sometimes fails,
	doing DNS query of partial path
Date: Mon, 29 Jan 2007 12:09:50 +0900
Message-ID: <1170040191.3404.9.camel@raven.themaw.net>
References: <CECD6E8A589E8447BC6E836C8369AFF50C2E88F6@us-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <CECD6E8A589E8447BC6E836C8369AFF50C2E88F6@us-email.terastack.bluearc.com>
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
To: Martin Dorey <mdorey@bluearc.com>, Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Mon, 2007-01-22 at 21:52 -0800, Martin Dorey wrote:
> The machine it happened on today is running a Debian
> 2.6.16-2-amd64-k8-smp.  aptitude show autofs reckons it's running

I don't really know what that means in term of patch levels.
Would it be possible to update a test machine to 2.6.19 or at least a
2.6.17 kernel and re-test.

Lukas, can we find out what autofs patches, if any, have been added to
this kernel?

Ian
