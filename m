From: Ian Kent <raven@themaw.net>
Subject: Re: /net support
Date: Sat, 28 Oct 2006 12:05:05 +0800
Message-ID: <1162008305.3091.8.camel@localhost>
References: <200610272022.k9RKMVk5020007@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200610272022.k9RKMVk5020007@jetcar.spd.analog.com>
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org

On Fri, 2006-10-27 at 16:22 -0400, David Meleedy wrote:
> Are there any plans to implement this correctly?  We are seeing
> problems with the auto.net script that just loads up every
> directory provided by the machine.  For example some of our
> fileservers have a lot of mounts, and this can really start
> filling up the mount table.  Also, some fileservers let certain
> clients mount some of the directories provided but not others.
> The error messages are confusing our user's because they are
> trying to cd to:
> 
> /net/<machine_name>/foo
> and they see an error message about not being able to mount
> /net/<machine_name>/goo
> 
> It would be a lot cleaner if only the directory you are cd'ing
> to got mounted instead of every directory.

As Jeff says, autofs version 5 works in a similar way to other
automounters now, by mounting (and expiring) the exported shares as you
go.

There is also a built in "-hosts" map now.

However, I've recently discovered that I haven't covered some of the
export access control syntax used by Solaris servers so you may still
need to use the auto.net script.

This issue will never be fixed in version 4 because version 4 cannot
handle the nesting of mounts found in server export lists.

Ian
