From: raven@themaw.net
Subject: RE: csh/cd not getting the right cwd at the mount point
Date: Tue, 13 Jul 2004 18:56:06 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407131852300.1375@donald.themaw.net>
References: <BA0E4392AD99D040885C414D992C24BE08264BD4@us-bv-m11.bv.tek.com>
 <Pine.LNX.4.58.0407122058410.3238@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407122058410.3238@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

On Mon, 12 Jul 2004, Jim Carter wrote:

> 
> Now here's what I'm thinking: with Linux autofs the inode returned by stat
> isn't quite right, or changes at just the wrong time, or something like
> that.  If the pwd algorithm can't find the target, the behavior is
> implementation defined, and a very likely behavior is to skip that
> directory component with no error message.  I know that the pwd command is
> implemented internally in csh and tcsh -- it just prints $pwd -- and I
> wouldn't be surprised if the shell does the research with its own code
> rather than forking /bin/pwd.
> 
> So that's a possible explanation of why (t)csh shows the behavior and
> (ba)sh doesn't.  Hope this helps.
> 
> I wonder what would break if autofs were super-smart and returned the inode 
> number of what was on the mount point, as long as it was still mounted.  It 
> would save a bunch of otherwise wasted NFS traffic and would avoid the kind
> of hangs that troubled us (and still trouble us) when a server goes down.  
> But lying about inode numbers probably has baleful consequences in some 
> bizarre circumstance.  Like keeping use counts up to date.

Don't think the original problem was as colorful as that.

In this case I think that the source of this original problem was an error 
in the daemon wrt directory create/remove as well as some bouncing around 
creating/removing them. That approach seemed to fix it.

Ian
