From: raven@themaw.net
Subject: Re: automount does not close file descriptors at start
Date: Wed, 16 Feb 2005 23:04:07 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502162301590.8161@donald.themaw.net>
References: <20050216125350.GA6031@uio.no>
Mime-Version: 1.0
In-Reply-To: <20050216125350.GA6031@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Wed, 16 Feb 2005, Steinar H. Gunderson wrote:

> Hi,
>
> My latest autofs package for Debian (4.1.3+4.1.4beta2-1) had problems
> installing, freezing after install; I've worked around this now
> (4.1.3+4.1.4beta2-2 is on its way up to the archive), but I've been told this
> is really a bug in automount. What I've been told is along the lines of:
>
> "Any daemon going into the background should close all file descriptors from
> zero up to MAXFDS minus the ones it actually wants to have open."

And you would like to substantiate that, right!

Ian
