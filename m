From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: consistent pathnames vs autofs
Date: Fri, 25 Feb 2005 09:18:03 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0502250846070.10017@simba.math.ucla.edu>
References: <200502192052.j1JKqiKs002944@calvin.labs.agilent.com>
	<Pine.LNX.4.61.0502231142400.30588@simba.math.ucla.edu>
	<20050225022425.GE15050@vprau.lsil.com>
Mime-Version: 1.0
In-Reply-To: <20050225022425.GE15050@vprau.lsil.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Au <rau@lsil.com>
Cc: autofs@linux.kernel.org

On Thu, 24 Feb 2005, Robert Au wrote:

> >     automount /net/tupelo file /tmp/tmpmaps/tupelo 
> > we would do
> >     automount /net/tupelo macro "* -rw,nodev,etc ${SERVER}:/&" \
> > 							-DSERVER=tupelo
> 
> I'm confused. Shouldn't
> 
>   automount /net program /etc/auto.net rw,nodev,...
> 
> do what you want? Have you reimplemented the program map (and
> /etc/auto.net) outside of autofs?

Each server exports several filesystems individually, so after everything 
is mounted you see /net/tupelo/h1, /net/tupelo/h2, /het/sassafras/h1, etc, 
with almost 100 potential mountable filesystems that change at high-stress 
times.  The way we have it set up, the programmatic /net map spins off 
multiple indirect file maps, one per actually used server, which handle 
getting the individual filesystems mounted.  But this involves a one-line 
file for the map to read, which then has to be cleaned up when the server 
becomes completely unused.  Hmmm... 5 minutes scurrying...

Thank you, thank you for making me think!  I just tried a new auto.net 
script and it induced the main automount /net process to spawn the 
following child, which subsequently mounted sassafras:/h1 as requested:

/usr/sbin/automount --submount /net/sassafras file /etc/auto.net.generic \
	rsize=8192 wsize=8192 retry=1 soft -DSERVER=sassafras


/etc/auto.net.generic contains 1 line: "* ${SERVER}:/&".

The /etc/auto.net script is now reduced to a one-liner that just emits this
(where $1 = map key in /net, i.e. server hostname).  Note, ',-D' not ',D'
which is ignored.  

-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=$1 \
	file:/etc/auto.net.generic

No more cockamamie auxiliary directory for the per-server map files and no 
more race conditions when cleaning it up!  Thank you!  And thanks to Ian 
and predecessors for keeping the interface reasonably clean so emergent 
properties can emerge.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
