From: Ian Kent <raven@themaw.net>
Subject: Re: Long timeout on broken DNS server
Date: Thu, 20 Mar 2008 15:46:04 +0900
Message-ID: <1205995564.30292.10.camel@raven.themaw.net>
References: <20080320050635.E2FA33C3B0@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080320050635.E2FA33C3B0@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org


On Wed, 2008-03-19 at 22:06 -0700, Jim Carter wrote:
> Today I upgraded one of my three DNS servers, the first listed in
> /etc/resolv.conf, and until I got it back on the air, autofs mounting
> was glacial.  To investigate, on my own workstation I prepended an IP
> address not assigned to any machine, and reproduced the problem.  The
> symptom is that automount takes 40 to 45 seconds, while other actions 
> involving DNS or hostnames take around 5 seconds, as expected: 
> "dig math.ucla.edu. soa" and "mount -t nfs tupelo:/h1 /mnt" were 
> tested.  The command to test automounting was "ls /net/$HOST/$DIR/.",
> in this case, "ls /net/serval/h1/." but I use a different host each 
> time to make sure DNS resolution happens.  We use nscd, but the result
> is the same whether or not it is running.

Not sure about the 5 seconds, I thought the timeout was longer, but I
think autofs is doing DNS lookus for the same name more often than it
needs to.

I'll have a look and see if I can put something together for you to
test.

Ian
