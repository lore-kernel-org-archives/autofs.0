From: Ian Kent <raven@themaw.net>
Subject: Re: Status of >800 mounts
Date: Fri, 7 May 2004 11:22:40 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405071116540.7903@wombat.indigo.net.au>
References: <409A7A7C.2000109@sedona.intel.com>
	<20040506185528.GA5149@crashy.west.sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040506185528.GA5149@crashy.west.sun.com>
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
To: Stew Smith <stew.smith@sun.com>
Cc: autofs@linux.kernel.org

On Thu, 6 May 2004, Stew Smith wrote:

> On Thu, May 06, 2004 at 10:48:44AM -0700, Michael Blandford wrote:
> > Hello,
> > 
> > What is the current status of having more than 800 nfs mounts ( on 2.4 
> > and 2.6 )?
> > 
> > I had heard there might be a patch to use one port per server instead of 
> > per mount. 
> > 
> 
> i am working on a patch currently which multiplexes nfs connections
> per sever so you end up with a 800 server limit, similar to the
> way nfsv4 works now.. i will send it out for review very soon after
> i ferret out a few bugs.
> 

I tried porting a patch of Tronds' for 2.5, forward for 2.6 and backward 
to 2.4. My understanding of the NFS/rpc code was (is) not sufficient 
to be confident with this. When I asked for someone to check and comment 
on what I had done I got only silence. At least I think I posted that to 
the list?

After that I tried to merge it into a RedHat kernel, which proved to be 
too much for me to do at the time.

I look forward to seeing your patch.

Ian
