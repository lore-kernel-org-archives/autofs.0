From: Joseph V Moss <jmoss@ichips.intel.com>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Fri, 21 Oct 2005 10:53:07 -0700
Message-ID: <30007.1129917187@plxw9904.pdx.intel.com>
References: <17241.7001.581589.222635@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Fri, 21 Oct 2005 12:46:17 EDT."
	<17241.7001.581589.222635@segfault.boston.redhat.com> 
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
Content-Transfer-Encoding: 7bit
To: jmoyer@redhat.com
Cc: autofs mailing list <autofs@linux.kernel.org>, Adrian Bunk <bunk@stusta.de>, Ian Kent <raven@themaw.net>


> raven> As Jeff has said this sort of nesting of mounts is, in general, not
> raven> supported by autofs and it worked previously because the locking was
> raven> less broken in 4.1.3 than in 4.1.4 (yes its still broken in 4.1.4).
> 
> raven> Can this case be done safely?
> 
> raven> I'm not entirely sure of the answer to this but I've never liked
> raven> using locking in autofs. I introduced it only to prevent mtab
> raven> corruption during mount (correct me if you have a different
> raven> recollection Jeff). It happens during rapid mount activity such as
> raven> when there as a largish number of entries in the master map (of the
> raven> order of 50 or more).
> 
> I'm not sure why it was introduced.  When looking at the code, the only
> thing I could deduce was that we do locking in autofs in order to not issue
> a ton of mounts all at once.  Because the mount command has a timeout for
> each mount, and because each mount will take some amount of time to
> complete, there exists a possibility of getting failed mounts due to a
> timeout or lack of resources.  That was my only guess.

Yes, with lots of mounts within a short time, you can easily run out of
available reserved ports (since many of them end up in a TIME_WAIT state
for a while).  We changed mount to simply wait and retry in such cases.
I can send you the patch we're currently using, if you really want it, but
I'd implement it differently if I were to do it again (i.e. as implemented
it retries a fixed number of times; I think it would be better to retry
until the timeout specified in the timeo parameter expires so that
port starvation isn't handled differently than other problems).

> 
> I have seen mtab corruption in the field, but typically only in the
> presence of mvfs (the clearcase file system).

There aren't enough hours in the day to go into all the problems induced
by mvfs.....
