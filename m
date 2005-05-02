From: Jeffrey Layton <jtlayton@poochiereds.net>
Subject: Re: [PATCH] replicated mounts overhaul
Date: Mon, 02 May 2005 10:24:22 -0400
Message-ID: <1115043862.3594.21.camel@barsoom.rdu.redhat.com>
References: <1115040578.3594.9.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0505022157230.9314@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505022157230.9314@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On Mon, 2005-05-02 at 22:01 +0800, raven@themaw.net wrote:
> On Mon, 2 May 2005, Jeffrey Layton wrote:
> 
> > Here's the latest version of the replicated mounts patch that I've been
> > working on. I sent this a couple of weeks ago and got no response.
> 
> I've been trying to get my direct mount stuff working.

Sounds good, just wanted to make sure it didn't slip thru the cracks. I
also wanted to make sure I don't allow any regressions as I update my
patch for new CVS versions.

Also, I've been doing some looking at what it will take to do the
"subnet" locality check. The problem seems to be quite a bit more
complicated than it seems at first glance. I'm trying to wrap my brain
around netlink sockets as that seems to be the best way to get
routing/netmask info out of the kernel.

We might also want to consider patching "mount" for that effort since
the current mount command just picks the first address when given a
hostname that resolves to more than one address.

If/when my other patch goes in, I'll start focusing on that.

-- 
Jeffrey Layton <jtlayton@poochiereds.net>
