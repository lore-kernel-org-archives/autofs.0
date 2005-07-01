From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Cached NIS map?
Date: Fri, 1 Jul 2005 11:09:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0507011100390.6273@xena.cft.ca.us>
References: <Pine.LNX.4.61.0506301010100.19272@simba.math.ucla.edu>
	<Pine.LNX.4.58.0507011335240.26508@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507011335240.26508@wombat.indigo.net.au>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Fri, 1 Jul 2005, Ian Kent wrote:
> 4.1.3 without patches doesn't see updates unless you send it a HUP signal.

OK, it's definitely time to upgrade the automounter to 4.1.4.

> I'm completely stumped by some people being able to mount the same mount 
> and others not? Except of course if they actually trying to mount 
> different mounts (ie. different user).

Right, in auto.home different users may be in the same exported filesystem, 
but they get mounted individually, and if they had a different history 
there is different behavior.  

Thanks to Monit Kapoor for his nscd comments.  But on our system auto.home 
is not cached by nscd.  We do see 10-minute timeouts with passwd.byname, 
due to the old passwd record being cached by nscd, and doing "nscd -i 
passwd" will break it loose if we're impatient for a particular user to get 
service restored.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
