From: Ian Kent <raven@themaw.net>
Subject: Re: swap space (off topic)
Date: Tue, 4 Oct 2005 09:48:25 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0510040944390.6153@wombat.indigo.net.au>
References: <215ff4410510030159h205c3588xa432510af1940f3d@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <215ff4410510030159h205c3588xa432510af1940f3d@mail.gmail.com>
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
To: Chris Fanning <christopher.fanning@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 3 Oct 2005, Chris Fanning wrote:

> Hello all,
> 
> I know this hasn't got much to do with the list but I thought someone
> here might put me in the right direction.
> 
> I've recently installed a Debian testing. When it boots, it reports
> "activating swap space: failed"
> However, I can see swap space using the 'top' command.(although it
> doesn't get used).
> 
> Does anyone know how I can test the swap partition?

Have you, check what the swap partitions are, listed your swap (swapon 
-s) and checked against the fstab?

Ian
