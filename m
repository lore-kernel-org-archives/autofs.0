From: Ian Kent <raven@themaw.net>
Subject: Re: autofs and smb shares
Date: Fri, 2 Apr 2004 09:20:51 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404020914030.19038@wombat.indigo.net.au>
References: <003001c41752$8e510cd0$657ba8c0@mobylines.it>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <003001c41752$8e510cd0$657ba8c0@mobylines.it>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Amodiovalerio [Hypo] Verde" <valerio.verde@moby.it>
Cc: autofs@linux.kernel.org

On Wed, 31 Mar 2004, Amodiovalerio [Hypo] Verde wrote:

> Hi,
> 
> I have a problem with autofs ( well I think is autofs related ).
> 
> Using fedora, kernel 2.6.4, autofs 4.1.1.
> 
> Set up a smb share and it works quite fine mounting and unmounting it.
> 
> The problem is that autofs seems not be able to umount the share when the
> share became unavailable ( like stopping sharing the directory ).

But autofs doesn't know that you have stopped sharing it.
Does smbfs know?

> 
> When I'm in the share, and share goes away, autofs won't umount it, also if
> timeout is expired.

And when your'e "in" the share it's busy as far as autofs is concerned.
If that's what you mean?

> 
> (with previos version of autofs, I could see in message log all the
> timeouts, so I assume it will try to umount the share).

Don't understand this.
You can choose what you see in the log with "--verbose" or "--debug".

> 
> If I do an ls it just give me a "ls: testdir: Invalid slot" until I manually
> umount the share. ( I'm able to umount the share manually without forcing
> and without any error )

Is the mount point busy or not?
If it's not then autofs should umount it after the timeout.

Ian
