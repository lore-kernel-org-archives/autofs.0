From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: How to use the user mount option
Date: Fri, 12 Sep 2008 13:31:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0809121307460.10299@xena.cft.ca.us>
References: <Pine.LNX.4.64.0809121259080.30744@rray.drdc.mstc.ms.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0809121259080.30744@rray.drdc.mstc.ms.gov>
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
To: Richard Ray <rray@mstc.state.ms.us>
Cc: autofs@linux.kernel.org

On Fri, 12 Sep 2008, Richard Ray wrote:

> I feel this must be a simple thing but it is not working for me.
> In auto.misc I have
> 
> flash -fstype=auto,rw,sync,flush,user    :/dev/sdb1
> 
> In auto.master I have
> 
> /misc file:/etc/auto.misc
> 
> If I cd /misc/flash the device will mount but all files belong to root
> If I add uid= to auto.misc the files belong to me
> Should not the user option do that without specifying a uid

As I read the man page for mount, "user" or "users" or "owner" governs 
who can mount, but only "uid=" affects ownership.  As I remember, there is 
no substitution for the UID of the requesting user -- but if there were, it 
would be really helpful in your case, and I think that information is 
available to the daemon.  

If your hotplug subsystem were doing its job it would mount the device 
automatically, and would get the ownership right.  I have a "howto" about 
this (not totally complete).  See the last four items, dated 2007-01-22, in 
this URL: http://www.math.ucla.edu/~jimc/documents/bugfix.html

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
