From: Ian Kent <raven@themaw.net>
Subject: Re: Status of >800 mounts
Date: Fri, 7 May 2004 12:24:35 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405071223550.8952@wombat.indigo.net.au>
References: <409A7A7C.2000109@sedona.intel.com>
	<20040506185528.GA5149@crashy.west.sun.com>
	<20040507040605.GU12857@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040507040605.GU12857@sun.com>
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
To: Tim Hockin <thockin@sun.com>
Cc: autofs@linux.kernel.org

On Thu, 6 May 2004, Tim Hockin wrote:

> On Fri, May 07, 2004 at 11:22:40AM +0800, Ian Kent wrote:
> > > i am working on a patch currently which multiplexes nfs connections
> > > per sever so you end up with a 800 server limit, similar to the
> > > way nfsv4 works now.. i will send it out for review very soon after
> > > i ferret out a few bugs.
> 
> With an early version of Stew's patch, I hit over 2000 simultaneous NFS
> mounts.  Once the last bugs are out, we can call this one closed, I think.
> 

Will it cover 2.4 as well or is it 2.6 only?

Ian
