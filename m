From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs 4.1.4 no-unlink patch
Date: Wed, 13 Jul 2005 00:30:36 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0507130025160.3058@donald.themaw.net>
References: <42D2CBC6.200@redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <42D2CBC6.200@redhat.com>
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
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 11 Jul 2005, Chris Feist wrote:

> Ian,
> 
> We've been hearing some reports of autofs removing entire home directories
> when mounts expire.  It appears that this could be some sort of race condition
> in the walk_tree code, where when the function starts the directory is
> unmounted and then autofs unlinks files in the the directory that is supposed
> to be umounted.  I've attached a patch to the rm_unwanted_fn which adds some
> additional checks before we unlink anything, and it prevents autofs from
> unlinking files (since I'm pretty sure that autofs never creates a regular
> file).  Let me know what you think.

Yes. There doesn't seem to be enough checking and the !S_ISLNK doesn't 
look quite right. Your right, the only objects in the autofs filesystem 
are directories and symlinks.

A mount happening during an expire might lead to this. But it shouldn't be 
able to happen due to the nature of the state machine.

I'll have to keep looking.

Ian
