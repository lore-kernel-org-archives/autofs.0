From: Ian Kent <raven@themaw.net>
Subject: Re: Problems with automounts dying
Date: Mon, 3 Apr 2006 09:35:18 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0604030929090.2400@eagle.themaw.net>
References: <20060326140544.GA5749@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060326140544.GA5749@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Sun, 26 Mar 2006, Steinar H. Gunderson wrote:

> Hi,
> 
> Lately I've been receiving multiple bug reports about autofs starting to
> forget mountpoints, for instance:
> 
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=349073

Ya. Chasing this one for a while now.
The bug report really looks like stale dentries in the mount point 
directory but I thought we fixed that. I'll think about it some more.

> 
> Does anybody else experience this? I can't reproduce it myself, but it sounds
> very much real :-) Any ideas?

Jeff and I are trying to work out what's causing it.

Ian
