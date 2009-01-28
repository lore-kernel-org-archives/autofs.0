From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS Race Conditions?  Negative Cache?
Date: Wed, 28 Jan 2009 12:30:06 +0900
Message-ID: <1233113406.3005.21.camel@zeus.themaw.net>
References: <F76FAA9B4E7600AAC1FFA15B@ZOP-MACTEL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <F76FAA9B4E7600AAC1FFA15B@ZOP-MACTEL.local>
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
To: Michael Loftis <mloftis@wgops.com>
Cc: autofs@linux.kernel.org

On Tue, 2009-01-27 at 13:04 -0700, Michael Loftis wrote:
> First, I'm sorry if you guys have answered any of this before but since 
> there's no public archives (the link on the kernel.org mailman interface 
> gets me an apache permission denied error) I'm not able to search them.
> 
> Debian 4.0, 2.6.18-6-686 (2.6.18.dfsg.1-23etch1) kernel, autofs 4.1.4-13
> 
> IS there any negative cache in AutoFS?  I ask because I appear to be seeing 
> repetitive calls to mount things that had already failed.  This is using a 
> wildcard map (full deployment, if we can make the automounter work at all 
> won't be using a wildcard map).
> 
> I keep seeing multiple mounts for the same place, AutoFS appears to race 
> itself a lot under high loads.
> 
> Is it expected behavior that autofs gets called for EVERY miss under the 
> autofs tree?  I would think not, but I can't figure out (excepting maybe 
> the race conditions) how a map could cause multiple mount entries except 
> because of race conditions.

It was quite a long while before we realized that a change to the VFS
between kernel 2.4 and 2.6 stopped the kernel module negative caching
from working. Trying to re-implement it in the kernel proved to be far
to complicated so it was eventually added to the daemon. I haven't
updated version 4 for a long time and don't plan to do so as the effort
in targeted at version 5 and has been for some time. I don't have time
to do both so version 5 gets the effort. Of course, if distribution
package maintainers want to update their packages, patches are around
and I can help with that effort.

There are other problems with the kernel module in 2.6.18 that appear to
give similar symptoms as well. You could try patching the kernel with
the latest autofs4 kernel module patches, which can be found in the
current version 5 tarball. There is still one issue that I'm aware of
that affects version 4 specifically, but I can't yet duplicate it and so
can't check if a fix would introduce undesirable side effects.

> 
> for ex (actual domain name changed to protect bystanders):  (in 
> /proc/mounts)
> nfs0:/www/vhosts/l /d1/l/luserdomain.org/logs nfs 
> rw,vers=3,rsize=8192,wsize=8192,hard,intr,proto=udp,timeo=11,retrans=2,sec=sys,addr=nfs0 
> 0 0
> /dev/hda3 /d1/l/luserdomain.org/logs/.renv ext3 rw,noatime,data=ordered 0 0
> 
> 
> == auto.master ==
> /d1/0 /etc/auto.jail -strict -DH=0
> /d1/1 /etc/auto.jail -strict -DH=1
> ...
> /d1/z /etc/auto.jail -strict -DH=z
> 
> == auto.jail ==
> *	/	:/www/vhosts/${H}/& /.renv :/opt/jail

I don't know where these mounts are coming from.
It doesn't look right but we don't know as we don't have a debug log to
refer to.

> 
> so how does that possibly end up with mounts like I'd shown above?  I was 
> under the impression that autofs4 would only ever call automounter with a 
> single key...for right now the source of the mounts is an nfs tree, there 
> are symlinks to other NFS mounts.  the bind mount mechanism works for now. 
> The reason I'm deploying this way and not with a static map is our 
> management software does not yet have the bits to modify a (LDAP) map, but 
> if it won't work for this proof of concept, I'm not sure it'll work at all.
> 
> Any help/guidance/wisdom/etc would be appreciated.
> 
