From: mmarion@qualcomm.com
Subject: Re: Severe problem with 4.1.2: automount caches NIS maps
 forever
Date: Thu, 6 May 2004 11:11:37 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200405061811.i46IBbbv019272@miguelito.qualcomm.com>
References: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On  6 May, Bryan O'Sullivan wrote:

> The autofs 4.1.2 release has a change in behaviour from earlier releases
> (4.1.0, I think, and 4.0.0 for sure) in that it never checks to see if a
> NIS-based automount map has changed.  This means that if I change the
> location of an autofs-mounted filesystem, I have to SIGHUP the automount
> daemons on every machine that care about that filesystem so that they'll
> forget the contents of the map and reload it.

I noticed this too and did a workaround...

I wrote a script that runs every 15 minutes out of cron and does an md5sum of
the current yp map, compares to the last known md5sum (saved in a file in
/etc) and if different, does a kill -HUP on the automount daemon.  This at
least means that changes will take no more then 15 minutes to be seen, and the
daemon won't just be hit with SIGHUPs when they aren't needed.

But yeah, it'd be nice if the daemon could do it's own periodic checks for
changes... and if that interval were configurable, even better.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Marge: "Homer, sitting that close to the TV can't be good for you."
Homer: "Talking while the TV's on can't be good for you!"
==> Simpsons
