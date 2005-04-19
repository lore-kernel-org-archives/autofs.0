From: Ian Kent <raven@themaw.net>
Subject: Re: sgi IRIX-6.5 autofs
Date: Tue, 19 Apr 2005 17:33:47 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504191732380.21257@wombat.indigo.net.au>
References: <16995.31446.632122.928444@kuku.melbourne.sgi.com>
	<Pine.LNX.4.62.0504182128250.14946@donald.themaw.net>
	<16996.51860.889578.213550@kuku.melbourne.sgi.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16996.51860.889578.213550@kuku.melbourne.sgi.com>
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
To: Max Matveev <makc@sgi.com>
Cc: autofs@linux.kernel.org

On Tue, 19 Apr 2005, Max Matveev wrote:

> >>>>> "ian" == raven  <raven@themaw.net> writes:
> 
> 
>  ian> Colour ls will mount everything when you list an autofs
>  ian> directory and this (the mount storm on large autofs directories)
>  ian> was seen as undesirable for lazy mounting in a browsable tree.
> 
> It sounds like an attempt to fix appliction bug in the kernel - color
> ls should've used lstat(2) instead of stat(2). But if people are happy
> with such behaviour then there is no need to change it.

Yea.

Oddly, Solaris automounter seems to behave this way as well.

> 
> BTW, Greg's problem with 30 sec timeout could be because server does
> not reply - tcpdump/ethereal run on a client should confirm or refute
> this hypothesis.

Greg?

Ian
