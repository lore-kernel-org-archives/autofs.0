From: Stef Bon <stef@bononline.nl>
Subject: Re: More directories?
Date: Wed, 12 Mar 2008 10:45:22 +0100
Message-ID: <47D7A632.8010101@bononline.nl>
References: <47D4445E.10100@bononline.nl>	<1205114970.3025.19.camel@raven.themaw.net>
	<47D4DFFC.8010705@bononline.nl>
	<1205197978.2955.5.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1205197978.2955.5.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
>
>
> Return everything else but the key as usual.
> Format like:
>
> [-fstype=<type>,<options] [[/] [localtion] \
> 	/<dir> location \
> 	/<dir> location ....
>
> The leading "/" is required and the root mount "/" is optional.
> It's been a while since I played with this but I think the offsets of
> the multi-mount need to be in depth order.
>
> Ian
>
>   
Ok, this format you give returns a list. This list is interpreted by the 
automount daemon,
and it determines which entry applies.

Now it should be possible to let this script (it has to be a script) 
only show the entry which applies:

-fstype=cifs,credentials=/home/sbon/.smb/mount.cred     / \
                         /sbon/lfs20060812/public ://lfs20060812/public


if I give the command:

ls <autofsmountpoint>/sbon/lfs20060812/public

This way the script is more "smart".

Stef Bon
