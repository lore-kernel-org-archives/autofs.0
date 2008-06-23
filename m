From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Automounter stops mounting home directories.
Date: Sun, 22 Jun 2008 21:30:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806222118470.18218@xena.cft.ca.us>
References: <A2ECBF49F352C24F9DF65BB529DCBC7014E02D1D@hqemmail01.nvidia.com>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A5766@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC70187A5766@hqemmail01.nvidia.com>
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
To: Stephen Biggs <sbiggs@nvidia.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Thu, 19 Jun 2008, Stephen Biggs wrote:

> > A situation occurs where indirectly automounted home 
> > directories stop being mounted at login.
> > 
> > First is seen in /var/log messages:
> > Jun 19 09:30:56 server1 automount[18399]: statemachine:1383: 
> > got unexpected signal -2147417261!
> > ... The same message occurs once more 15 seconds later... I 
> > don't know what may have happened to cause this, I don't 
> > believe I have ever seen this before and this may be a red 
> > herring; possibly due to some other hardware related issue?

I don't get this particular message.

> > Then, trying to do 'kill -USR1 `pgrep automount` ; kill -HUP 
> > `pgrep automount`' gives this in the messages:
> > 
> > Jun 19 10:32:23 server1 automount[18399]: do_notify_state: 
> > signal 10 Jun 19 10:32:23 server1 automount[18399]: 
> > master.c:986: assertion
> > failed: ap->state == ST_READY
> > Jun 19 10:32:23 server1 automount[18399]: master_notify_state_change:
> > sig 10 switching /home from 2 to 3
> > 
> > ...in response to the USR1 signal.

I do get the ap->state == ST_READY assertion failure (but not 
master_notify_state_change).

> > It looks like it is stuck in some sort of expire limbo.  It 

That's what Ian Kent is working on with me: a mutex that is held when it 
should have been released.  The most dramatic symptom for me is that the 
client process hangs forever waiting for the mount, but there's another 
side effect that filesystems which should be unmounted aren't.  

> Is this the same problem as Jim Carter's?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
