From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs4 patch] implement included map support
Date: Fri, 10 Nov 2006 12:02:21 +0800
Message-ID: <1163131341.3797.5.camel@localhost>
References: <x491wodnvdk.fsf@segfault.boston.devel.redhat.com>
	<1163049640.7831.3.camel@localhost>
	<x49odrgmzbc.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49odrgmzbc.fsf@segfault.boston.devel.redhat.com>
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

On Thu, 2006-11-09 at 10:09 -0500, Jeff Moyer wrote:
> ==> On Thu, 09 Nov 2006 13:20:40 +0800, Ian Kent <raven@themaw.net> said:
> 
> Ian> On Wed, 2006-11-08 at 22:37 -0500, Jeff Moyer wrote: > Hi, Ian,
> Ian> list, (again, sorry if this is a dup)
> Ian> > 
> Ian> > Here is an implementation of included map support for autofs
> Ian> v4.  This > supports included maps in both the master map, and
> Ian> regular direct or > indirect file maps.
> Ian> > 
> Ian> > Because I dread writing bash code, I implemented the included
> Ian> map > checking for the master map in C.  We basically just call
> Ian> into the > daemon with a bogus mount point, asking for it to dump
> Ian> out all of the > maps.  This works well for 2 reasons: 1) it's
> Ian> not bash, and 2) it > re-uses the code that the daemon will use
> Ian> to read the included maps > anyway.
> Ian> > 
> Ian> > Review would be greatly appreciated.  I tested this in my
> Ian> environment > by creating a number of included maps, and
> Ian> modifying > /etc/nsswitch.conf to ensure that it works as
> Ian> expected for file and > NIS maps.
> 
> Ian> I've only looked briefly at this but I get the impression that it
> Ian> will allow "+" map inclusion from other than file maps. Is that
> Ian> right?
> 
> That was not the intent, and upon testing, it certainly doesn't follow
> included maps from yp.  It does, however, interpret the included
> map as a key in the map, which give a directory listing like this:
> 
> # ls /test/
> +auto.test  repltest  sbox

I'm impressed!

You've been able to duplicate the broken Solaris behavior I've seen in
the past. Hehe!

Ian
