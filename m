From: raven@themaw.net
Subject: Re: rpc_ping always uses UDP
Date: Thu, 13 May 2004 20:41:46 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405132039530.13693@donald.themaw.net>
References: <16546.29772.254542.152548@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16546.29772.254542.152548@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 12 May 2004, Jeff Moyer wrote:

> Hello Ian, list,
> 
> I had a user report an issue which is summed up in the subject.  Basically,
> he disallowed UDP traffic to his NFS server.  Because the autofs code uses
> UDP in the rpc_ping function to determine if a server is alive, it would
> conclude that the server was not alive.  He was, of course, using NFSv4
> over TCP.

> So, thoughts?  Comments?

Oh and another thing.

The rpc ping should only occur if replicated server mount syntax is being 
used. If this is not the case it's also a bug.

Is he using the latest replicated server patch?

Ian
