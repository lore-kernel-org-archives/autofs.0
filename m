From: raven@themaw.net
Subject: Re: is there an autofs roadmap somewhere?
Date: Fri, 25 Jun 2004 22:46:03 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
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
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: autofs@linux.kernel.org

On Tue, 22 Jun 2004, Lever, Charles wrote:

> new to the game.
> 
> I'm wondering what features autofs developers have in mind for the near
> future.

Charles. Why did you have to ask "that" question!

There are quite a few things that people here on the list have asked for, 
that for one reason or another, are quite difficult to implement. I won't 
go there now.

The big issue for me is that, atm autofs does not have expected 
functionality in two areas. One is the lazy mounting of multi-mount maps 
and second, direct mounts that behave as expected (there's limited 
functionality now).

To be honest I've spent a lot of time fixing bugs. When that settles down 
(soon I hope) I want to re-work the code to sort out the above.

Once autofs has functionality expected of an automounter, a roadmap of 
additional features would be good to develop.

There's a redevelopment by Mike Waychison and Tim Hocking (of Sun) 
underway but they haven't delivered any product yet. Perhaps we'll see 
something in the 2.7 - 2.8 time frame. Their design will take much of the 
function into the kernel using callback helper utilities.

There's also the 800 mount limit in the sunrpc code for NFS v2 and v3 
mounts, but you know about that.

But what functionality do you need?
And what do you think would be useful?

Ian
