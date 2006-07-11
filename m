From: Ian Kent <raven@themaw.net>
Subject: Re: automount removes mountpoint upon exit
Date: Wed, 12 Jul 2006 01:53:12 +0800
Message-ID: <1152640392.22214.24.camel@raven.themaw.net>
References: <44B23316.7050808@ant.uni-bremen.de>
	<x494pxp1ql7.fsf@segfault.boston.redhat.com>
	<44B3B06F.90006@ant.uni-bremen.de> <x49r70skye3.fsf@redhat.com>
	<1152632631.16553.6.camel@raven.themaw.net>
	<x49irm4ksz6.fsf@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49irm4ksz6.fsf@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 2006-07-11 at 12:26 -0400, Jeff Moyer wrote:
> ==> Regarding Re: [autofs] automount removes mountpoint upon exit; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Tue, 2006-07-11 at 10:29 -0400, Jeff Moyer wrote:
> >> ==> Regarding Re: [autofs] automount removes mountpoint upon exit; Heinrich Rebehn <rebehn@ant.uni-bremen.de> adds:
> >> 
> rebehn> Jeff Moyer wrote:
> rebehn> Thank you for the patch, Jeff.
> rebehn> However, i failed to understand the debian package system and
> rebehn> simply have no time to read a couple of manpages and howtos just to
> rebehn> implement this small patch. So i simply set the immutable flag on
> rebehn> our server and it works!
> >> 
> rebehn> Will this patch be in the officcial version some day, so we
> rebehn> eventually see it in debian or ubuntu?
> >> 
> >> Yes, it already is in 4.1.4.  Ask the debian maintainer to upgrade autofs
> >> to that.  It's been out for some time, now.
> 
> raven> But I thought Heinrich was asking about the top directory of the mount.
> raven> I don't think we check that in the same way.
> raven> I'll have a look later.
> raven> Wonder whether I check that in v5 .....
> 
> Yeah, he's asking about the top-directory of the mount.  That's exactly
> what that patch takes care to check for.  ;)

Oops. Maybe I'll actually pay more attention some time soon!

Ian
