From: Ian Kent <raven@themaw.net>
Subject: Re: Indirect mounts with map on automounted filesystem and
 --fstype=autofs
Date: Fri, 19 Feb 2010 11:09:23 +0800
Message-ID: <4B7E00E3.8090505@themaw.net>
References: <4B7DCC9A.9030508@embl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B7DCC9A.9030508@embl.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Frank Thommen <fthommen@embl.de>
Cc: autofs@linux.kernel.org

On 02/19/2010 07:26 AM, Frank Thommen wrote:
> Hi,
> 
> (I'm sure this has already been discussed on this list but somehow I
> seem unable to find the right thread or otherwise an answer on the web...)
> 
> I need to automount subdirectories of an automounted filesystem by using
> an indirect map which lies itself on an automounted filesystem:
> 
> /base/sub1/        <- mounted via auto.master and indirect map
> /base/sub1/sub2/a  <- mounted via indirect a map in /base/sub1
> 
> 'sub2' is a "physically" existing directory in /base/sub1
> (server1:/export/sub1, in example below).
> 
> 
> I managed to do it with the following:
> 
> 
> /etc/auto.master
> ----------------
> /base  file:/etc/auto.base --ghost
> 
> 
> /etc/auto.base
> --------------
> sub1   /     server1:/export/sub1 \
>        /sub2 -fstype=autofs file:/main/sub1/my.map
> 
> 
> /base/sub1/my.map
> ----------------------
> a   servera:/export/a
> b   serverb:/export/b
> ...
> 
> 
> 
> My two questions are:
> 
> a) Is this the right and recommended way to use an indirect map which is
> located on an automounted filesystem or are the better/more
> efficient/faster ways to do it?

These are submounts.

I don't think there's any other way to do this and this is the only
supported way to do nested mounts that I'm aware of.

> 
> b) is the -fstype=autofs option an official option that will stay or
> rather an unofficial option that might disappear in the future?  The
> manpages don't mention this kind of filesystem
> (autofs-5.0.1-0.rc2.131.el5_4.1 on CentOS 5.4), so I'm unsure about it's
> status.

Ha, I wish I could get rid of support for submounts but that's not going
to happen because they have been available for a long time and quite a
few people need to use them and it's the only supported way to create
nested mounts.

They have been very difficult to get working well in v5 and while there
are probably still problems they seem to be holding up under fairly
heavy usage now.

> 
> 
> Thank you for any hint or referral to other online documentation.

Yes, the documentation does need some information on multi-mounts and
some reference to submounts. My bad.

Ian
