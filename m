From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with /net and dropped mounts in 2.6.17.11
Date: Wed, 28 Feb 2007 11:48:56 +0900
Message-ID: <1172630936.3461.12.camel@raven.themaw.net>
References: <ac37e1230702260721u306898f8g4fae054a5812af8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ac37e1230702260721u306898f8g4fae054a5812af8e@mail.gmail.com>
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
To: Brian Weaver <bjweaverj@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-02-26 at 08:21 -0700, Brian Weaver wrote:
> Greetings,
> 
> We recently moved one of our projects from 2.6.12 up to 2.6.17.11 for
> some hardware enablement reasons, but now we are seeing mounts
> consistently drop.
> 
> We have a dedicated NFS fileserver with 9 exported mount points. Our
> Linux clients 
> are using /etc/auto.net to mount these on /net.  Everything works fine
> on initial
> startup, all of the mounts show up fine, but then after a while, one
> of the mounts
> disappears, is no longer mounted or in /etc/mtab, and automounter logs
> the following 
> to syslog whenever we try to access the mount:
> 
> Feb 26 08:01:08 fclw436 automount[25387]: >> /sbin/showmount: can't
> get address for cvl-xp1/mnt/xp1b 
> Feb 26 08:01:08 fclw436 automount[25387]: lookup(program): lookup for
> cvl-xp1/mnt/xp1b failed 
> Feb 26 08:01:08 fclw436 automount[25387]: failed to
> mount /net/cvl-xp1/mnt/xp1b
> 
> 
> 
> So it looks like showmount is actually failing.. It shouldn't be
> looking up host cvl-xp1/mnt/xp1b.. 
> 
> Am I just running into an old showmount bug? 

Don't think so.
Updating the kernel with patches from the autofs 5.0.1 tar may help with
this.

Ian
