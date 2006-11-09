From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs4 patch] implement included map support
Date: Thu, 09 Nov 2006 13:20:40 +0800
Message-ID: <1163049640.7831.3.camel@localhost>
References: <x491wodnvdk.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x491wodnvdk.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Wed, 2006-11-08 at 22:37 -0500, Jeff Moyer wrote:
> Hi, Ian, list,  (again, sorry if this is a dup)
> 
> Here is an implementation of included map support for autofs v4.  This
> supports included maps in both the master map, and regular direct or
> indirect file maps.
> 
> Because I dread writing bash code, I implemented the included map
> checking for the master map in C.  We basically just call into the
> daemon with a bogus mount point, asking for it to dump out all of the
> maps.  This works well for 2 reasons: 1) it's not bash, and 2) it
> re-uses the code that the daemon will use to read the included maps
> anyway.
> 
> Review would be greatly appreciated.  I tested this in my environment
> by creating a number of included maps, and modifying
> /etc/nsswitch.conf to ensure that it works as expected for file and
> NIS maps.

I've only looked briefly at this but I get the impression that it will
allow "+" map inclusion from other than file maps. Is that right?

If that is the case we need to explicitly ignore "+" map entries in map
sources other than file maps as it's not legal or at least for
consistency.

Ian
