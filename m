From: Ian Kent <raven@themaw.net>
Subject: Re: how does this work?
Date: Sat, 17 Mar 2007 01:59:52 +0900
Message-ID: <1174064392.3397.65.camel@raven.themaw.net>
References: <c80174f10703130359o45f0a547r6b620e862fa4de14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <c80174f10703130359o45f0a547r6b620e862fa4de14@mail.gmail.com>
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
To: Sanjay Sha <sanjay.sha@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-03-13 at 16:29 +0530, Sanjay Sha wrote:
> Here is the scenario::
> ~~~~~~~~~~~~~~~~
> 
> myhome.nfs is a CNAME to myweb.apla.com
> (myhome.nfs.apla.com is a CNAME to myweb.apla.com)
> 
> autofs config looks like this::
> 
> /auto/myhome    myhome.nfs:/home/sanjay

What config?
What file is this line located in?

You need to place automount managed mount points in a master map, often
named "auto.master" and commonly located in "/etc".

For example an auto.master (master map) to mount home directories might
have an entry (among others) like:

/home	/etc/auto.home

and then the map /etc/auto.home may have mount entries (among others)
like:

myhome	myhome.nfs:/home/sanjay


> on the same client machine::
> 
> /etc/resolv.conf has 
> search apla.com 
> nameserver 10.10.10.245
> nameserver 10.10.10.244
> 
> now ping to myhome.nfs gives
> 
> PING myweb.apla.com (10.10.10.12) 56(84) bytes of data
> 64 bytes from myweb.apla.com (10.10.10.12) : icmp_seq=1 ttl=254
> time=0.132ms
> 
> When I do this..
> 
> tech-sanjay:/auto$ cd myhome
> -bash: cd: myhome: No such file or directory
> 
> I am trying to understand how the automount deamon handles the
> requests... I am curious to know how the DNS resolution part is
> handled.. 

By standard system library calls like other programs.

Ian
