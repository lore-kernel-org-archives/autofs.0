From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: How exactly does timeout work?
Date: Tue, 10 Apr 2007 11:06:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101046450.1885@simba.math.ucla.edu>
References: <1176133554.30046.175.camel@psmithub>
	<x49wt0ly17p.fsf@segfault.boston.devel.redhat.com>
	<x49slb9xzu6.fsf@segfault.boston.devel.redhat.com>
	<1176137315.30046.185.camel@psmithub>
	<x49odlxxz70.fsf@segfault.boston.devel.redhat.com>
	<1176138870.30046.203.camel@psmithub>
	<x49k5wlxy4i.fsf@segfault.boston.devel.redhat.com>
	<1176140195.30046.225.camel@psmithub>
	<1176177492.3476.44.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1176177492.3476.44.camel@raven.themaw.net>
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

On Tue, 10 Apr 2007, Ian Kent wrote:

> The inode access times aren't (and never were) used to determine
> timeout. So the words "Access times" might end up being be misleading.
> ...
> Prior to version 5 update this was updated for any access. So "busy"
> could be loosely defined as "any access".
> 
> Following the version 5 update it is only updated if the mount is really
> busy. This means only if at least one process working directory or any
> open file is within the filesystem at the time of an expire check...

So if my mail monitor stats my mailbox, on an otherwise unused automounted 
filesystem, every few seconds, the filesystem would be eligible to be 
unmounted but would be remounted a few seconds later.  And similarly if the 
KDE or Gnome desktop used the same strategy on remote directories, we hope 
not too many of them.  A lot of sysops complain about this behavior.

The "right" way to handle the issue is if the application uses FAM to 
detect changes, not the stupid polling.  But if network FAM is enabled and 
you set a watch on the mailbox, and the filesystem is then unmounted, will 
local FAM maintain the net connection to FAM on the the residence host?  
I have no idea, and in any case this is not a relevant issue for autofs.

Or alternatively the application could fork a process that would cwd to the 
containing directory, preventing unmounting.  That's a lot of overhead 
particularly for a desktop with lots of folders.  

You want to encourage unmounting, particularly with NFSv4 which has its 
own unmounting paradigm, because if the server is rebooted you'll end up 
with a stale NFS filehandle on all mounted filesystems, which in my 
experience does not self-heal reliably.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
