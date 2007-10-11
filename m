From: Ian Kent <raven@themaw.net>
Subject: Re: Has replicated mount failover  been implemented?
Date: Thu, 11 Oct 2007 14:59:06 +0800
Message-ID: <1192085946.3114.14.camel@raven.themaw.net>
References: <836836.16914.qm@web81813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <836836.16914.qm@web81813.mail.mud.yahoo.com>
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
To: John Simon <tzzhc4@yahoo.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-10-10 at 23:28 -0700, John Simon wrote:
> We are in the process of switching from Sun blades to
> Linux blades for our compute farm and are running into
> issues with automount not failing over when an NFS
> server goes down. I am wondering if it is a
> configuration issue, if I am using a version of autofs
> that doesn't support failover or if it hasn't been
> implemented yet.
> 
> Currently I am running SLES 10 with autofs 4.1.4. Here
> are my configs. The server will pick the next host in
> line at mount but if the failure happens after mount
> the mount does NOT failover. Any information would be
> greatly appreciated.:

Failover of active NFS mounts isn't something that autofs can do. When I
say that I don't mean it hasn't been implemented, I mean, as far as I
can see, it's not possible for autofs to do it. I've thought about quite
a bit and I just can't see a way to implement it.

Once autofs has selected a server and performed the mount it has no
knowledge of what is happening in the mount itself. All that autofs
could do (if it was implemented in the NFS client) is to pass an ordered
list of servers to mount so it can then pass that to the kernel. This is
essentially what the Solaris automount does.

This has to be supported in the kernel NFS client and it's not. 

Ian
