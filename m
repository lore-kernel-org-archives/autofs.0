From: Jeff Layton <jtlayton@poochiereds.net>
Subject: Re: [PATCH] mount_nfs replicated mounts patch (now sorts
	by subnet locality too)
Date: Tue, 19 Jul 2005 08:53:38 -0400
Message-ID: <1121777618.15495.11.camel@barsoom.rdu.redhat.com>
References: <1121556776.11263.13.camel@localhost.localdomain>
	<Pine.LNX.4.63.0507192032490.2061@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0507192032490.2061@donald.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Tue, 2005-07-19 at 20:34 +0800, Ian Kent wrote:
> I think I'm missing something?
> How do you get proximity information from the 'addr=' address?
> 
> Ian
> 

Ahh sorry if that wasn't clear. We don't. We resolve the addresses for
each replicated mount host (using gethostbyname) and then compare those
addresses to the routing table in /proc/net/route to determine whether
the mount is on the same subnet as the client.

When we're ready to mount, we would pass the addr= option to the mount
command to hint to it that it should use this address instead of the
first one in the list.

-- 
Jeff Layton <jtlayton@poochiereds.net>
