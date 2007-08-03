From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs 4 and 5 with nfs4
Date: Fri, 03 Aug 2007 12:09:04 +0800
Message-ID: <1186114144.3573.14.camel@raven.themaw.net>
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
> 
> Is there a map syntax that would work round this? Ideally I would like
> the map to be the same on all hosts, I can have different maps on the
> autofs4 and autofs5 hosts easily but would not want to have a separate
> map per host.

I had a look at the code which mounts these and it looks like if you
adding a port= option will force an NFS mount to be done.

Want to give it a try?

Historically the nosymlink would have had the same affect but, even
though the mount code looks for it it doesn't use it anymore. That may
not be such a bad thing given the name of the option and the fact that
it's not mentioned in the man pages. If this achieves what's needed then
I'd rather document the use of the port= option in the man pages and
keep the nosymlink a candidate for the chopping block.

Ian
