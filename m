From: Tim Hockin <thockin@sun.com>
Subject: Re: Status of >800 mounts
Date: Thu, 6 May 2004 21:06:05 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040507040605.GU12857@sun.com>
References: <409A7A7C.2000109@sedona.intel.com>
	<20040506185528.GA5149@crashy.west.sun.com>
	<Pine.LNX.4.58.0405071116540.7903@wombat.indigo.net.au>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405071116540.7903@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Fri, May 07, 2004 at 11:22:40AM +0800, Ian Kent wrote:
> > i am working on a patch currently which multiplexes nfs connections
> > per sever so you end up with a 800 server limit, similar to the
> > way nfsv4 works now.. i will send it out for review very soon after
> > i ferret out a few bugs.

With an early version of Stew's patch, I hit over 2000 simultaneous NFS
mounts.  Once the last bugs are out, we can call this one closed, I think.

:)

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
