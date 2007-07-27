From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs 4 and 5 with nfs4
Date: Fri, 27 Jul 2007 17:23:55 +0800
Message-ID: <1185528235.3203.47.camel@raven.themaw.net>
References: <46A745D5.7080603@cohtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46A745D5.7080603@cohtech.com>
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
To: Howard Wilkinson <howard@cohtech.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-07-25 at 13:45 +0100, Howard Wilkinson wrote:
> I have a site that is currently using NFS4 for most of its traffic. We
> have a mix of autofs4 and autofs5 clients. The following map is used
> to provide access to host filing system exports
> 
> Auto.master:
> 
> /hosts     auto.hosts
> 
> auto.hosts
> 
> *
> -fstype=nfs4,tcp,rsize=32768,wsize=32768,hard,intr,nodev,nosuid &:/
> 
> This works fine in both autofs4 and autofs5 if the client is not the
> server (i.e. loopback ...) However with autofs5 this returns the root
> of the local file system not the exported nfs4 root.

Hahaha!!!

Yes, that's certainly something I didn't anticipate.

Historically, all local mounts are turned into bind mounts regardless of
the options specified. I can't think of an acceptable way to do this and
still use bind mounts so we need to consider under what conditions to
not mount local mounts as bind mounts.

I had a similar report recently and said that people expect that, if a
mount is local, it will be bind mounted for to give map independence.

So, this is a question for the list.
What do people think?


> 
> Is there a map syntax that would work round this? Ideally I would like the map to be the same on all hosts, I can have different maps on the autofs4 and autofs5 hosts easily but would not want to have a separate map per host.

No there isn't.

Ian
