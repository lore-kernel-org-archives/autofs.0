From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] make autofs understand the -[no]browse option
Date: Tue, 16 Nov 2004 08:54:09 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0411160853060.9913@wombat.indigo.net.au>
References: <16793.2017.226139.516137@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16793.2017.226139.516137@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 15 Nov 2004, Jeff Moyer wrote:

> Hi, Ian, list,
> 
> The patch below makes the Linux automounter a bit more compatibile with the
> Sun automounter, by parsing the -[no]browse options, and converting them
> into the equivalent --ghost option.
> 
> Ian, I've not made this patch against vanilla 4.1.3.  This is the patch
> that went into the Red Hat RPM.  I will generate a diff to whatever version
> you like, but I didn't want to do extra work since your tree may be quite
> different from 4.1.3 at this point.

Quite likely.

Doesn't look to complicated. I might do it by hand if needed.

Ian
