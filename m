From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs / davfs
Date: Wed, 06 Jun 2007 09:50:36 -0400
Message-ID: <x49ejkpur83.fsf@segfault.boston.devel.redhat.com>
References: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
	(Kevin Muller's message of "Thu, 17 May 2007 12:18:47 +0300")
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
To: Kevin Muller <k.muller@sideshowdigital.com>
Cc: autofs@linux.kernel.org

==> On Thu, 17 May 2007 12:18:47 +0300, "Kevin Muller" <k.muller@sideshowdigital.com> said:

Kevin> autofs / davfs
Kevin> Im having a problem automounting a davfs share.
Kevin> The share is setup, and works perfect without the automount.
Kevin> but as soon as a 'ls' is done on the automount directory, and the autofs
Kevin> tries to mount it, it hangs for a while, then if ctrl-c's out of it, the
Kevin> next ls on that directory shows the files correctly.

Kevin> The idea is to have the files available through Samba, and as soon as samba
Kevin> tries to access the folder it will be a webdav share that gets mounted at
Kevin> that point.

Kevin> Any suggestions at this point will be helpful.

I'm sorry, did we leave you hanging on this issue?  The last thing I
see in the discussion was this post from you:

,----
| mount(generic): calling mount -t davfs http://v6.muglets.com.dev/repos
| /home/automount/web.site.com
| May 21 15:56:22 devaccess automount[32663]: >> /sbin/mount.davfs: no
| free coda device to mount
| May 21 15:56:22 devaccess automount[32663]: >> /sbin/mount.davfs:
| trying fuse kernel file system
| May 21 15:56:22 devaccess automount[32663]: >> /sbin/mount.davfs: fuse
| device opened successfully
| 
| >From this I deduce that the modules load, and the file system is put
| in place, and the autofs hangs before control is returned.
`----

When you reproduce this, can you get the output from `ps auxwww | grep
mount` and post it here?  I'm wondering whether the mount command ever
returns.  Also, this looks to be just a snippet of the log.  Could you
include the rest of the logs, or tell us if this was the last thing
logged by automount?

Thanks!

Jeff
